<?php

// +----------------------------------------------------------------------
// | Think.Admin
// +----------------------------------------------------------------------
// | 版权所有 2014~2017 广州楚才信息科技有限公司 [ http://www.cuci.cc ]
// +----------------------------------------------------------------------
// | 官方网站: http://think.ctolog.com
// +----------------------------------------------------------------------
// | 开源协议 ( https://mit-license.org )
// +----------------------------------------------------------------------
// | github开源项目：https://github.com/zoujingli/Think.Admin
// +----------------------------------------------------------------------

namespace app\admin\controller;

use controller\BasicAdmin;
use service\FileService;
use think\Db;
use think\Request;

/**
 * 插件助手控制器
 * Class Plugs
 * @package app\admin\controller
 * @author Anyon <zoujingli@qq.com>
 * @date 2017/02/21
 */
class Plugs extends BasicAdmin
{

    /**
     * 默认检查用户登录状态
     * @var bool
     */
    public $checkLogin = false;

    /**
     * 默认检查节点访问权限
     * @var bool
     */
    public $checkAuth = false;

    /**
     * 图片裁切上传
     */
    public function cropImage(){
        $token = Request::instance()->token("fileToken");
        return view('',[
            'scale' => input('scale'),
            'elem' => input('elem'),
            'token' => $token
        ]);
    }

    /**
     * 文件上传
     * @return \think\response\View
     */
    public function upfile()
    {
        if (!in_array(($uptype = $this->request->get('uptype')), ['local', 'qiniu', 'oss'])) {
            $uptype = sysconf('storage_type');
        }
        $types = $this->request->get('type', 'jpg,png');
        $mode = $this->request->get('mode', 'one');
        $limit = $this->request->get('limit', 300);
        $this->assign("limit",$limit); //文件最多个数
        $this->assign('mimes', FileService::getFileMine($types));
        $this->assign('field', $this->request->get('field', 'file'));
        return view('', ['mode' => $mode, 'types' => $types, 'uptype' => $uptype]);
    }
    /**
     * 通用文件上传
     * @return \think\response\Json
     */
    public function upload()
    {
        $file = $this->request->file('file');
        $md5s = $this->request->post('md5');
        $ext = pathinfo($file->getInfo('name'), 4);
        $filename =  date('Ym').'/'.$md5s . ".{$ext}";
        // 文件上传Token验证
        if ($this->request->post('token') !== md5($filename . session_id())) {
            return json(['code' => 'ERROR', '文件上传验证失败']);
        }
        // 文件上传处理
        if (($info = $file->move('static' . DS . 'upload' . DS .date('Ym'),$md5s, true))) {
            if (($site_url = FileService::getFileUrl($filename, 'local'))) {
                return json(['data' => ['site_url' => $site_url], 'code' => 'SUCCESS', 'msg' => '文件上传成功']);
            }
        }
        return json(['code' => 'ERROR', '文件上传失败']);
    }

    /**
     * 裁切上传
     * @return mixed
     */
    public function uploadFile()
    {
        $file = $this->request->file('file');
        $token = $this->request->post('token');
        if($token!==session('fileToken')){
            return json(['code' => 'ERROR', '文件上传验证失败']);
        }
        $ext = explode('/',$file->getInfo('type'))[1];
        $filename =  date('Ym').'/'.$token . ".{$ext}";

        // 文件上传处理
        if (($info = $file->move('static' . DS . 'upload' . DS , $filename,true))) {
            if (($site_url = FileService::getFileUrl($filename, 'local'))) {
                return json(['data' => ['site_url' => '/static/upload/'.$filename], 'code' => 'SUCCESS', 'msg' => '文件上传成功']);
//                return json(['data' => ['site_url' => $site_url], 'code' => 'SUCCESS', 'msg' => '文件上传成功']);
            }
        }
        return json(['code' => 'ERROR', '文件上传失败']);
    }



    /**
     * 文件状态检查
     */
    public function upstate()
    {
        $post = $this->request->post();
        $filename = date('Ym').'/'.$post['md5'] . '.' . pathinfo($post['filename'], PATHINFO_EXTENSION);
        // 检查文件是否已上传
        if (($site_url = FileService::getFileUrl($filename))) {
            $this->result(['site_url' => $site_url], 'IS_FOUND');
        }
        // 需要上传文件，生成上传配置参数
        $config = ['uptype' => $post['uptype'], 'file_url' => $filename];
        switch (strtolower($post['uptype'])) {
            case 'qiniu':
                $config['server'] = FileService::getUploadQiniuUrl(true);
                $config['token'] = $this->_getQiniuToken($filename);
                break;
            case 'local':
                $config['server'] = FileService::getUploadLocalUrl();
                $config['token'] = md5($filename . session_id());
                break;
            case 'oss':
                $time = time() + 3600;
                $policyText = [
                    'expiration' => date('Y-m-d', $time) . 'T' . date('H:i:s', $time) . '.000Z',
                    'conditions' => [['content-length-range', 0, 1048576000]],
                ];
                $config['policy'] = base64_encode(json_encode($policyText));
                $config['server'] = FileService::getUploadOssUrl();
                $config['site_url'] = FileService::getBaseUriOss() . $filename;
                $config['signature'] = base64_encode(hash_hmac('sha1', $config['policy'], sysconf('storage_oss_secret'), true));
                $config['OSSAccessKeyId'] = sysconf('storage_oss_keyid');
        }
        $this->result($config, 'NOT_FOUND');
    }

    /**
     * 生成七牛文件上传Token
     * @param string $key
     * @return string
     */
    protected function _getQiniuToken($key)
    {
        $accessKey = sysconf('storage_qiniu_access_key');
        $secretKey = sysconf('storage_qiniu_secret_key');
        $bucket = sysconf('storage_qiniu_bucket');
        $host = sysconf('storage_qiniu_domain');
        $protocol = sysconf('storage_qiniu_is_https') ? 'https' : 'http';
        $params = [
            "scope"      => "{$bucket}:{$key}",
            "deadline"   => 3600 + time(),
            "returnBody" => "{\"data\":{\"site_url\":\"{$protocol}://{$host}/$(key)\",\"file_url\":\"$(key)\"}, \"code\": \"SUCCESS\"}",
        ];
        $data = str_replace(['+', '/'], ['-', '_'], base64_encode(json_encode($params)));
        return $accessKey . ':' . str_replace(['+', '/'], ['-', '_'], base64_encode(hash_hmac('sha1', $data, $secretKey, true))) . ':' . $data;
    }

    /**
     * 字体图标选择器
     * @return \think\response\View
     */
    public function icon()
    {
        $field = $this->request->get('field', 'icon');
        return view('', ['field' => $field]);
    }

    /**
     * 区域数据
     * @return \think\response\Json
     */
    public function region()
    {
        return json(Db::name('DataRegion')->where('status', '1')->column('code,name'));
    }

    /**
     * 删除文件
     */
    public function delFile(){
        $filename = $this->request->post('filename');
        $src      = urlToSrc($filename);
        return json([
            'code'  => 'SUCCESS',
            'result'=> @unlink($src)
        ]);
    }

    public function upAudio(){
        $audio  = Db::name("AppAudio")->select();
        $this->assign('audio',$audio);
        $this->assign('field', $this->request->get('field', 'file'));
        return view();
    }
    public function upGoods(){
        $goods  = Db::name("AppGoods")->where('is_show',1)->field('id,title')->select();
        $this->assign('goods',$goods);
        $this->assign('field', $this->request->get('field', 'file'));
        return view();
    }
}
