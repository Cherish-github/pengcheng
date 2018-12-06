<?php
/**
* Company: 深圳市三牛犇科技有限公司.
* User: 小米飞刀
* Date: 2017/8/11
* Time: 11:09
*/
namespace app\index\Controller;
use think\Controller;
use app\index\logic\User as logicUser;

class Common extends Controller{
    public function __construct()
    {
        parent::__construct();
        if(request()->isMobile()) {
             $user_id = session('user_id');
             if(!$user_id){
                 if(request()->has('code','get') && request()->get('code')!==''){
                     $this->oauthCallback();
                 }else{
                     //去授权
                     return $this->doOauth();
                 }
             }
         } else {
            $this->error("请在移动端微信打开此页面","/");
         }
    }


    /**
     * 去授权
     */
    public function doOauth(){
        $wechat = load_wechat("Oauth");
        $callback = Url("",'',true,true); //当面页面
        //var_dump($callback);die;
        $res = $wechat->getOauthRedirect($callback,'','snsapi_userinfo');
        header("location:".$res);
        exit;
    }

    /**
     * 授权回调
     */
    public function oauthCallback(){
        $wechat = load_wechat("Oauth");
        $tokenInfo  = $wechat->getOauthAccessToken();
        if($tokenInfo){
            /*用户是否存在数据库中*/
            $userInfo = logicUser::getUser($tokenInfo["openid"]);

            if(!$userInfo) {
                $userInfo   = $wechat->getOauthUserInfo($tokenInfo["access_token"], $tokenInfo['openid']);
                $userInfo["appid"]  = $wechat->appid;
                $user_id    = logicUser::insertUser($userInfo);
            }else{
                $user_id    = $userInfo["id"];
            }
            session("user_id",$user_id);
            session("openid",$tokenInfo['openid']);
        }else{
            $this->error("您的访问有误!","/");
            exit;
        }
    }



}