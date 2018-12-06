<?php

/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/17
 * Time: 15:32
 */

namespace app\api\controller;
use think\Db;
use think\Cache;
class User
{
    /**
     * 用户登录入口
     */
    public function wxLogin(){
        $code = input("code");
        $rawData = input("rawData",'','htmlspecialchars_decode');
        $signature = input("signature",'','htmlspecialchars_decode');
        $encryptedData = input("encryptedData",'','htmlspecialchars_decode');
        $iv = input("iv",'','htmlspecialchars_decode');

        $wehcat = load_wechat('Program');
        $res    = $wehcat->jsonCode2Session($code);
        if(!isset($res['session_key'])){
            return [
                'code' => 'ERROR',
                'msg'  => $wehcat->getError(),
            ];
        }
        $sessionKey = $res['session_key'];
        session('session_key',$sessionKey);

        if(!$wehcat->checkSignature2($rawData,$sessionKey,$signature)){
            return [
                'code'  => 'ERROR',
                'msg'   => '签名验证失败!'
            ];
        }
        /*验证数据真实性*/
        $data = '';
        if(!$wehcat->decryptData($sessionKey, $encryptedData, $iv, $data)){
            return [
                'code'  => 'ERROR',
                'msg'   => $wehcat->getError(),
            ];
        }

        /*数据验验证成功后，更新数据库*/
        $data           = json_decode($data,true);
        $insertData     = [
            'openid'    => $data['openId'],
            'nickname'  => $data['nickName'],
            'avatarurl' => $data['avatarUrl'],
            'unionid'    => isset($data['unionid']) ? $data['unionid'] : ''
        ];
        if(!model('UserModel')->saveBasic($insertData)){
            return [
                'code'  => 'ERROR',
                'msg'   => model('UserModel')->getError()
            ];
        }
        $session3rd = rd_rand();
//        $liftTime   = $res['expires_in'];
//        unset($res['expires_in']);
        $res    = array_merge($res,$insertData);
        $returnData = ['session3rd'=>$session3rd];
        self::loginHook($returnData,$res);
        Cache::set($session3rd,$res,24*3600);
        return [
            'code'  => 'SUCCESS',
            'data'  => $returnData
        ];
    }
    /**
     * 获取用户信息
     */
    public function getUserInfo(){
        $session3rd  = input('session3rd');
        $userInfo    = Cache::get($session3rd);
//        TODO:修改openid
        $userInfo['openid'] = 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k';

        if(empty($userInfo)){
            return ['msg'=>'请重新授权','code'=>'FAIL'];
        }
        $userInfo = Db::name("AppUser")
            ->where('openid', $userInfo['openid'])
            ->find();
        Cache::set($session3rd,$userInfo,24*3600);
        unset($userInfo['openid']);
        unset($userInfo['unionid']);
        return [
            'code'  => 'SUCCESS',
            'data'   => $userInfo
        ];
    }

    /**
     * 登录钩子
     * @param $returnData
     * @param $userData
     */
    private function loginHook(&$returnData,&$userData){

    }

    /**
     * 修改用户信息
     */
    public function modifyUserInfo(){
        $name = input('post.name','');
        $phone = input('post.phone','');
        if (mb_strlen($name) > 10){
            return ['msg'=>'联系人名字长度不能超过10个字符','code'=>'ERROR'];
        }
        $pattern = '/^1[3456789]\d{9}$/';
        if (!preg_match($pattern,$phone)){
            return ['msg'=>'手机号格式错误','code'=>'ERROR'];
        }
        $openid = session('openid');
        $res = Db::name('AppUser')->where('openid',$openid)->update(['name'=>$name,'phone'=>$phone]);

        if (false !== $res){
            return ['msg'=>'更改信息成功','code'=>200];
        }else{
            return ['msg'=>'更改信息失败，请稍后重试','code'=>500];
        }
    }

    /**
     * 领取优惠券
     */
    public function getCoupon(){
        $coupon_id = input('id/d',0);
        if ($coupon_id < 1){
            return ['msg'=>'参数错误','code'=>400];
        }
        $coupon = Db::name('AppCoupon')->where('id',$coupon_id)->find();
        if (!$coupon){
            return ['msg'=>'优惠券不存在','code'=>400];
        }
        $userCoupon = Db::name('AppUserCoupon')->where('user_id',session('user_id'))->where('coupon_id',$coupon_id)->find();
        if ($userCoupon){
            return ['msg'=>'您领取过该优惠券','code'=>400];
        }
        $res = Db::name('AppUserCoupon')->insert([
            'user_id' => session('user_id'),
            'coupon_id' => $coupon_id
        ]);
        if ($res){
            return ['msg'=>'领取成功','code'=>200];
        }else{
            return ['msg'=>'领取失败，请稍后重试','code'=>500];
        }
    }

    /**
     * 获取用户所有优惠券
     */
    public function couponList(){
        $session3rd  = input('session3rd');
        $userInfo    = Cache::get($session3rd);
//        TODO:修改openid
        $userInfo['id'] = 1;
        if(empty($userInfo)){
            return ['msg'=>'请重新授权','code'=>'FAIL'];
        }

        $data = Db::name('AppUserCoupon')
            ->alias('uc')
            ->join('app_coupon c','c.id=uc.coupon_id','left')
            ->where('uc.user_id',$userInfo['id'])
            ->order('uc.created_time desc')
            ->field('c.*,c.deadline_date,uc.is_used')
            ->select();
        $ids = Db::name('AppUserCoupon')->where('user_id',$userInfo['id'])->column('coupon_id');
        $coupons = Db::name('AppCoupon')->where('id','not in',$ids)->order('id desc')->select();
        $curr = time();
        foreach ($data as &$v){
            $v['cut_price'] = fmtPrice($v['cut_price']);
            if (strtotime($v['deadline_date']) < $curr){
                $v['status'] = -1;  //已过期
            }elseif ($v['is_used']==0){
                $v['status'] = 0;  //待使用
            }elseif ($v['is_used']==1){
                $v['status'] = 1;  //已使用
            }
            unset($v['is_used']);
        }

        foreach ($coupons as &$v){
            $v['cut_price'] = fmtPrice($v['cut_price']);
            if (strtotime($v['deadline_date']) < $curr){
                $v['status'] = -1;  //已过期
            }else{
                $v['status'] = -2;  //待领取
            }
        }

        $data = array_merge($data,$coupons);
        return [
            'code'  => 'SUCCESS',
            'data'  => $data
        ];
    }

    /**
     * 获取待领取优惠券
     */
    public function noGetCoupon(){
        $user_id = session('user_id');
//        $user_id = 1;
        $ids = Db::name('AppUserCoupon')->where('user_id',$user_id)->column('coupon_id');
        $curr = date("Y-m-d");
        $coupons = Db::name('AppCoupon')
            ->where('id','not in',$ids)
            ->where('deadline_date','>',$curr)
            ->order('id desc')
            ->select();
        foreach ($coupons as &$v){
            $v['cut_price'] = fmtPrice($v['cut_price']);
        }

        return [
            'code'  => 200,
            'data'  => $coupons
        ];
    }

    /**
     * 获取待使用优惠券
     */
    public function noUsedCoupon(){
        $user_id = session('user_id');
        $curr = date("Y-m-d");
        $data = Db::name('AppUserCoupon')
            ->alias('uc')
            ->join('app_coupon c','c.id=uc.coupon_id','left')
            ->where('uc.user_id',$user_id)
            ->where('uc.is_used',0)
            ->where('c.deadline_date','>',$curr)
            ->order('uc.created_time desc')
            ->field('uc.id,c.title,c.cut_price,c.deadline_date')
            ->select();
        foreach ($data as &$v){
            $v['cut_price'] = fmtPrice($v['cut_price']);
        }

        return [
            'code'  => 200,
            'data'  => $data
        ];
    }

    /**
     * 获取已使用优惠券
     */
    public function usedCoupon(){
        $user_id = session('user_id');
        $data = Db::name('AppUserCoupon')
            ->alias('uc')
            ->join('app_coupon c','c.id=uc.coupon_id','left')
            ->where('uc.user_id',$user_id)
            ->where('uc.is_used',1)
            ->order('uc.created_time desc')
            ->field('uc.id,c.title,c.cut_price,c.deadline_date')
            ->select();
        foreach ($data as &$v){
            $v['cut_price'] = fmtPrice($v['cut_price']);
        }
        return [
            'code'  => 200,
            'data'  => $data
        ];
    }

    /**
     * 获取已过期优惠券
     */
    public function expiredCoupon(){
        $user_id = session('user_id');
        $curr = date("Y-m-d");
        $data = Db::name('AppUserCoupon')
            ->alias('uc')
            ->join('app_coupon c','c.id=uc.coupon_id','left')
            ->where('uc.user_id',$user_id)
            ->where('c.deadline_date','<',$curr)
            ->order('uc.created_time desc')
            ->field('uc.id,c.title,c.cut_price,c.deadline_date')
            ->select();
        $ids = Db::name('AppUserCoupon')->where('user_id',$user_id)->column('coupon_id');
        $curr = date("Y-m-d");
        $coupons = Db::name('AppCoupon')
            ->where('id','not in',$ids)
            ->where('deadline_date','<',$curr)
            ->order('id desc')
            ->select();
        $data = array_merge($data,$coupons);
        foreach ($data as &$v){
            $v['cut_price'] = fmtPrice($v['cut_price']);
        }
        return [
            'code'  => 200,
            'data'  => $data
        ];
    }
}