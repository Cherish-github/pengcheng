<?php
namespace app\index\logic;
use think\Db;
class User {

    /**
     * 通过openid 查询用户静态数据
     * @param $openid
     * @return array|false|\PDOStatement|string|\think\Model
     */
    public static function getUser($openid){
        return Db::name("AppUser")->where("openid",$openid)->find();
    }

    /**
     * 添加用户
     * @param $data
     * @return bool|int|string
     */
    public static function insertUser($data){
        $unionid = isset($data['unionid']) ? $data['unionid'] : '';
        $user_id = Db::name("AppUser")->insertGetId([
            "nickname" => $data['nickname'],
            "openid" => $data["openid"],
            "avatarurl"=>$data['headimgurl'],
            'unionid'=>$unionid
        ]);
        return $user_id;
    }
}