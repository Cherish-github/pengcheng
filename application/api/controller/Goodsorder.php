<?php
/**
 * Copyright: 深圳市三牛犇科技有限公司
 * User: 小米飞刀
 * Date: 2018/4/25
 * Time: 14:35
 */
namespace app\api\controller;
use think\Cache;
use think\Db;
use think\Error;
use think\Exception;
use think\Validate;

class Goodsorder{
    public $table = 'AppGoodsOrder';

    /**
     * 获取我的商品订单列表
     * @param status: -2全部订单，-1取消订单，0待付款，1待用餐，2已完成
     */
    public function getList(){
        $page       = input('page/d',1);
        $pageSize   = input('pageSize/d',2);
        if($page<1 || $pageSize<1){
            return [
                'code'  => 400,
                'msg'   => '参数错误'
            ];
        }
        $start      = ($page - 1) * $pageSize;
        $status     = input('status/d',-2);
        if (!in_array($status,[-2,-1,0,1,2])){
            return ['code'=>400,'msg'=>'参数错误'];
        }
        $openid = session('openid');
        $where = ['openid'=>$openid,'deleted'=>0];

        if ($status!=-2){
            $where['status'] = $status;
        }
        $count = Db::name($this->table)->where($where)->count();
        $pages = ceil($count/$pageSize);
        $list   = Db::name($this->table)
            ->where($where)
            ->order('id desc')
            ->limit($start,$pageSize)
            ->field('id,order_no,meal_date,DATE_FORMAT(`meal_time`,"%H:%i") as m_time,amount,coupon_price,status,pay_money')
            ->select();
        foreach ($list as &$v){
            if ($v['status']<=0){
                $v['sum'] = fmtPrice($v['amount']-$v['coupon_price']);
            } elseif($v['status'] > 0){
                $v['sum'] = fmtPrice($v['pay_money']);
            }
            unset($v['amount']);
            unset($v['coupon_price']);
            unset($v['pay_money']);
            $v['goods'] = Db::name('AppOrderGoods')
                ->where('order_id',$v['id'])
                ->field('title,thumb,price,num,goods_id')
                ->select();
        }
        return [
            'code'  => 200,
            'data'  => $list,
            'pages' => $pages
        ];
    }

    /**
     * 取消订单
     */
    public function cancelOrder(){
        $openid = session('openid');
        $id             = input('id');
        if($id < 1){
            return ['code'  => 400, 'msg'   => '参数错误'];
        }
        $orderInfo  = Db::name($this->table)
            ->where('id',$id)
            ->where('deleted',0)
            ->where('openid',$openid)
            ->field('status')
            ->find();
        if(empty($orderInfo) || @$orderInfo['status']!=0){
            return [
                'code'  => 400,
                'msg'   => '该订单不符合取消条件!'
            ];
        }
        try {
            Db::name($this->table)->where('id', $id)->update(['status'=> -1]);
        }catch(\Exception $e){
            p($e->getMessage());
            return [
                'code'  => 400,
                'msg'   => '取消失败!'
            ];
        }
        return [
            'code'  => 200,
            'msg'   => '取消成功!'
        ];
    }

    /**
     * 删除订单
     */
    public function delOrder(){
        $openid = session('openid');
        $id             = input('id');
        if($id < 1){
            return ['code'  => 400, 'msg'   => '参数错误'];
        }
        $orderInfo  = Db::name($this->table)
            ->where('id',$id)
            ->where('openid',$openid)
            ->field('status')
            ->find();
        if(empty($orderInfo) || @$orderInfo['status']!=2){
            return [
                'code'  => 400,
                'msg'   => '该订单不符合删除条件!'
            ];
        }
        try {
            Db::name($this->table)->where('id', $id)->update(['deleted'=> 1]);
        }catch(\Exception $e){
            p($e->getMessage());
            return [
                'code'  => 400,
                'msg'   => '删除订单失败!'
            ];
        }
        return [
            'code'  => 200,
            'msg'   => '删除订单成功!'
        ];
    }

    /**
     * 提交订单
     */
    public function submitOrder(){
        $meal_date = input('date');
        $meal_time = input('time');
        $data['meal_people'] = input('people/d',1);
        $data['name']       = input('username','');
        $data['phone']      = input('phone','');
        $uc_id  = input('uc_id/d',0);
        $remark     = input('remark','');
        $user_id    = session('user_id');
        if (!$user_id){
            return ['code'=>400,'msg'=>'请重新登录'];
        }
        if (date('Y-m-d',strtotime($meal_date))!=$meal_date){
            return ['code'=>400,'msg'=>'用餐日期格式错误'];
        }
        if (date('H:i',strtotime($meal_time))!=$meal_time){
            return ['code'=>400,'msg'=>'用餐时间格式错误'];
        }
        $rule = [
            ['meal_people','number|between:1,10','用餐人数必须为数字|用餐人数必须在1~10之间'],
            ['name','require|max:10','联系人姓名必须|联系人姓名长度不能超过10个字符'],
            ['phone','require|regex:/^1[356789]\d{9}$/','手机号码必须|手机号码格式错误']
        ];
        $validate = new Validate($rule);
        $result   = $validate->check($data);
        if(!$result){
            return [
                'code'=>400,
                'msg'=>$validate->getError()
            ];
        }
        if ($uc_id!=0){
            //判断优惠券是否可用
            $coupon = Db::name('AppUserCoupon')
                ->alias('uc')
                ->join('app_coupon c','c.id=uc.coupon_id','left')
                ->where('uc.user_id',$user_id)
                ->where('uc.id',$uc_id)
                ->field('c.deadline_date,uc.is_used,c.cut_price')
                ->find();
            if (!$coupon){
                return ['code'=>400,'msg'=>'优惠券不存在'];
            }
            if ($coupon['is_used']==1){
                return ['code'=>400,'msg'=>'优惠券已使用，不能再次使用'];
            }
            if (strtotime($coupon['deadline_date']) < time()){
                return ['code'=>400,'msg'=>'优惠券已过期，不能使用'];
            }
            $orderInfo['is_coupon'] = 1;
            $orderInfo['coupon_price']  = $coupon['cut_price'];
        }else{
            $orderInfo['is_coupon'] = 0;
            $orderInfo['coupon_price']  = 0.00;
        }

        //获取购物车商品
        $goods = Db::name('AppGoodsCart')
            ->alias('c')
            ->join('app_goods g','g.id=c.goods_id','left')
            ->where('user_id',$user_id)
            ->field('g.id,g.title,g.price,g.thumb,c.num')
            ->select();
        if (!$goods){
            return ['code'=>400,'msg'=>'请先向购物车添加商品'];
        }
        $orderInfo['openid']    = session('openid');
        $orderInfo['order_no']  = date('YmdHis').rand(100000,999999);
        $orderInfo['remark']    = $remark;
        $orderInfo['meal_date'] = $meal_date;
        $orderInfo['meal_time'] = $meal_time.':00';
        $orderInfo['status']    = 0;  //未支付
        $orderInfo = array_merge($orderInfo,$data);
        $order_id = Db::name('AppGoodsOrder')->insertGetId($orderInfo);

        $goodsInfo = [];
        $amount = 0;
        foreach ($goods as $k => $g){
            $goodsInfo[$k]['title'] = $g['title'];
            $goodsInfo[$k]['price'] = $g['price'];
            $goodsInfo[$k]['thumb'] = $g['thumb'];
            $goodsInfo[$k]['num']   = $g['num'];
            $goodsInfo[$k]['order_id'] = $order_id;
            $goodsInfo[$k]['goods_id'] = $g['id'];
            $amount += $g['price'];
        }

        $amount = sprintf('%.2f',$amount);
        Db::startTrans();
        try{
            Db::name('AppOrderGoods')->insertAll($goodsInfo);
            Db::name('AppGoodsOrder')->where('id',$order_id)->update(['amount'=>$amount]);
            Db::name('AppGoodsCart')->where('user_id',session('user_id'))->delete();
            Db::commit();
        }catch (Exception $e){
            Db::rollback();
            p($e->getMessage());
            Db::name('AppGoodsOrder')->where('id',$order_id)->delete();
            return ['code'=>400,'msg'=>'提交订单失败，请稍后重试'];
        }
        return ['code'=>200,'data'=>$order_id];
    }

    /**
     * 去支付
     */
    public function pay(){
        $order_id             = input('order_id/d',0);
        if($order_id < 1){
            return ['code'  => 400, 'msg'   => '参数错误'];
        }
        $openid = session('openid');
        $orderInfo  = Db::name($this->table)
            ->where('id',$order_id)
            ->where('openid',$openid)
            ->find();
        if(empty($orderInfo) || @$orderInfo['status']!=0){
            return [
                'code'  => 'ERROR',
                'msg'   => '该订单不符支付条件!'
            ];
        }

        $goodsArr = Db::name('AppOrderGoods')->where('order_id',$order_id)->select();
        foreach ($goodsArr as $i){
            $goods = Db::name('AppGoods')->where('id',$i['goods_id'])->find();
            if (!$goods){
                return [
                    'code'  => 'ERROR',
                    'msg'   => '商品【'.$i['title'].'】不存在，订单不能支付'
                ];
            }
        }

        $fee = config('app_debug') ? 1 : ($orderInfo['amount']-$orderInfo['coupon_price']) * 100;
//        $url    = request()->domain().'/index/Wechatnotify/good';
        $notify_url = url('/index/Wechatnotify/goods',null,true,true);
        $wechat = load_wechat('pay');
        $prepayid = $wechat->getPrepayId($orderInfo['openid'], '鹏城酒店订餐支付', $orderInfo['order_no'], $fee, $notify_url, 'JSAPI');
        if(empty($prepayid)){
            return [
                'code'  => 500,
                'msg'   => '调起支付失败!'
            ];
        }
        $paymentInfo = $wechat->createMchPay($prepayid);
        return [
            'code'=>201,
            'data'=>$paymentInfo
        ];

    }

    /**
     * 再订一次
     */
    public function orderAgain(){
        $order_id = input('order_id/d',0);
        $user_id    = session('user_id');
        if (!$user_id){
            return ['code'=>400,'msg'=>'请重新登录'];
        }
        if($order_id < 1){
            return ['code'=>400,'msg'=>'参数错误'];
        }
        $goods_ids = Db::name('AppOrderGoods')->where('order_id',$order_id)->select();
        $data = [];
        foreach ($goods_ids as $v){
            $goods = Db::name('AppGoods')
                ->where('id',$v['goods_id'])
                ->find();
            if (!$goods){
                return ['code'=>400,'msg'=>'商品【'.$v['title'].'】不存在，无法下单'];
            }else{
                $data[] = ['goods_id'=>$goods['id'],'num'=>$v['num'],'user_id'=>$user_id];
            }
        }
        Db::startTrans();
        try{
            Db::name('AppGoodsCart')->where('user_id',$user_id)->delete();
            Db::name('AppGoodsCart')->insertAll($data);
            Db::commit();
        }catch (\Exception $e){
            p($e->getMessage());
            Db::rollback();
            return ['code'=>500,'msg'=>'再次下单失败'];
        }
        return ['code'=>200,'msg'=>'加入购物车成功'];
        
    }

}

