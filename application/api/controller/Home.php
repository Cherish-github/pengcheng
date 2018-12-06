<?php

/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/16
 * Time: 10:28
 */
namespace app\api\controller;
use think\Db;
use think\Request;
use think\Cache;
use service\FileService;
class Home
{

    /**
     * 获取会员卡说明
     */
    public function vipCard(){
        $data = Db::name('AppMemberCard')->order('sort')->field('title,content')->select();
        return [
            'code'  => 'SUCCESS',
            'data'  => $data
        ];
    }

    /**
     * 文件上传
     */
    public function upload(Request $request){
        $file = $request->file('files');
        $session3rd = input('session3rd');
        // 文件上传验证
        $userInfo   = Cache::get($session3rd);
        if(empty($userInfo)){
            return [
                'code'  => 'FAIL',
                'msg'   => '请重新授权登录!'
            ];
        }
        $md5s = $userInfo['id']."_".md5_file($file->getInfo('tmp_name'));
        $ext = pathinfo($file->getInfo('name'), 4);
        $filename =  date('Ym').'/'.$md5s . ".{$ext}";
        // 文件上传处理
        if (($info = $file->move('static' . DS . 'upload' . DS .date('Ym'),$md5s, true))) {
            if (($site_url = FileService::getFileUrl($filename, 'local'))) {
                return [
                    'data' => ['site_url' => $site_url],
                    'code' => 'SUCCESS',
                    'msg' => '文件上传成功'
                ];
            }
        }
    }
    /**
     * 删除文件
     */
    public function delImg(){
        $session3rd = input('session3rd');
        $src        = input('src');
        $userInfo   = Cache::get($session3rd);
        if(empty($userInfo)){
            return [
                'code'  => 'FAIL',
                'msg'   => '请重新授权登录!'
            ];
        }
        list($id,$md5s) = explode('_',basename($src));

        if($id!=$userInfo['id']){
            return ['code'=>'ERROR','msg'=>'你没有权限删除该图片'];
        }
        $src    = urlToSrc($src);
        try{
            unlink($src);
        }catch (\Exception $e){
            return [
                'code'=> 'ERROR',
                'msg' => '删除失败'
            ];
        }
           return [
            'code'=> 'SUCCESS',
            'msg' => '删除成功'
        ];

    }


   // function test(){
//        dump( sendSMS('13923466095','SMS_134225285',[
//            'code'  => 1314520
//        ]));
  //  }

}