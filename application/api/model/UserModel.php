<?php

/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/17
 * Time: 15:33
 */
namespace app\api\model;
use think\Exception;
use think\Validate;
use think\Model;
use think\Cache;
use think\Db;
class UserModel extends Model
{
    protected $table    = 'app_user';
    protected $pk       = 'id';
    protected $readonly = ['openid'];
    protected $errMsg   = '';
    /**
     * 添加、修改基本修改
     */
    public  function saveBasic(&$data){
        $rule   = [
            ['openid','require|length:28','openid不能为空|openid长度不正确'],
            ['nickname','require','昵称不能为空!'],
            ['avatarurl','require','头像不能为空'],
        ];
        $validate   = Validate::make($rule);
        if(!$validate->check($data)){
            $this->errMsg   = $validate->getError();
            return false;
        }
        try {
            $res = $this->where('openid',$data['openid'])->lock(true)->field('id')->find();
            if ($res['id']>0) {
                $this->where('openid',$data['openid'])->update($data);
                $data['id'] = $res['id'];
                return true;
            }
            $data['id'] = $this->insertGetId($data);
            return true;
        }catch (\Exception $e){
            $this->errMsg   = $e->getMessage();
            return false;
        }
    }

    public function getUserInfo($where){
        return $this->where($where)->find();
    }

    /**
     * 凭session3rd获取用户信息
     * @param $session3rd
     * @param $no_cache bool 是否更缓存
     * @return array|bool
     */
    public function session3rdToUserInfo($session3rd,$no_cache=false){
        $userInfo   = Cache::get($session3rd);
        if(empty($userInfo)){
            $this->errMsg = '无效的session3rd';
            return false;
        }
        if($no_cache){
            $userInfo = self::getUserInfo(['openid'=>$userInfo['openid']]);
            Cache::set('session3rd',$session3rd,7200);
        }
        return $userInfo;
    }

    public function getError(){
        return  $this->errMsg;
    }

}