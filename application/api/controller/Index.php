<?php
/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/16
 * Time: 10:53
 */
namespace app\api\controller;
use controller\BasicApi;
class Index extends BasicApi
{
    public function index()
    {
        $cachekey   = $apes    = $this->request->request('api');//以‘，’分隔 http://www.meixun.com/api?api=home_banner
        if(empty($cachekey)) return self::response('缺少必填参数api','error','');
        $no_cache   = $this->request->request('no_cache',false);
        $prefix  = "\\app\\api\\controller\\";
        $apes    = explode(',',$apes);
        $data    = [];
        if(!config('app_debug') && !$no_cache){
            $paramArr   = input();
            ksort($paramArr);
            $paramStr   = implode('',$paramArr);
            $data = self::getCache($cachekey.$paramStr);
            if(!empty($data)){
                return self::response('响应成功','SUCCESS',$data);
            }
        }
        $code   = 'SUCCESS';
        $msg    = '响应成功';
        foreach($apes as $api){
            list($classes,$method) = explode('_',$api);//以‘_’分隔
            $classes = $prefix . ucfirst($classes);
            if(!class_exists($classes)){
                continue;
            }
            if( !method_exists($classes, $method)){
                continue;
            }
            $tempData    = [];
            if(empty($tempData)) {
                $cls = new $classes;
                $tempData = call_user_func([$cls, $method]);
            }
            $tempData['code'] ==='ERROR' && ($tempData['data']=[]) ;
            $code   = $code=='SUCCESS' ? strtoupper($tempData['code']) : $code;
            $msg = isset($tempData['msg'])  &&  $tempData['msg']!='' ? $tempData['msg']:$msg;
            $data[$api] = isset($tempData['data'])?$tempData['data']:[];
        }
        if(!config('app_debug') ){
            self::setCache($cachekey.$paramStr,$data,600); //缓存10分钟
        }
        return self::response($msg,$code,$data);
    }

}