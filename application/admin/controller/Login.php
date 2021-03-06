<?php

namespace app\admin\controller;

use controller\BasicAdmin;
use service\LogService;
use service\NodeService;
use think\Db;
use think\helper\Hash;

/**
 * 系统登录控制器
 * class Login
 * @package app\admin\controller
 * @author Anyon <zoujingli@qq.com>
 * @date 2017/02/10 13:59
 */
class Login extends BasicAdmin
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
     * 控制器基础方法
     */
    public function _initialize()
    {
        if (session('user') && $this->request->action() !== 'out') {
            $this->redirect('@admin');
        }
    }

    /**
     * 用户登录
     * @return string
     */
    public function index()
    {
        if ($this->request->isGet()) {
            return $this->fetch('', ['title' => '用户登录']);
        } else {
            // 输入数据效验
            $username = $this->request->post('username', '', 'trim');
            $password = $this->request->post('password', '', 'trim');
            strlen($username) < 4 && $this->error('登录账号长度不能少于4位有效字符!');
            strlen($password) < 4 && $this->error('登录密码长度不能少于4位有效字符!');
            // 用户信息验证
            $user = Db::name('SystemUser')->where('username', $username)->find();
            empty($user) && $this->error('登录账号不存在，请重新输入!');
            (!Hash::check($password,$user["password"])) && $this->error('登录密码与账号不匹配，请重新输入!');
            empty($user['status']) && $this->error('账号已经被禁用，请联系管理!');
            // 更新登录信息
            $data = ['login_at' => ['exp', 'now()'], 'login_num' => ['exp', 'login_num+1']];
            Db::name('SystemUser')->where('id', $user['id'])->update($data);
            session('user', $user);
            !empty($user['authorize']) && NodeService::applyAuthNode();
            LogService::write('系统管理', '用户登录系统成功');
            $this->success('登录成功，正在进入系统...', '@admin');
        }
    }

    /**
     * 退出登录
     */
    public function out()
    {
        LogService::write('系统管理', '用户退出系统成功');
        session('user', null);
        session_destroy();
        $this->success('退出登录成功！', '@admin/login');
    }

}
