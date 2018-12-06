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
use service\DataService;
use think\Db;
use think\helper\Hash;

/**
 * 系统用户管理控制器
 * Class User
 * @package app\admin\controller
 * @author Anyon <zoujingli@qq.com>
 * @date 2017/02/15 18:12
 */
class Users extends BasicAdmin
{

    /**
     * 指定当前数据表
     * @var string
     */
    public $table = 'AppUser';

    /**
     * 用户列表
     */
    public function index()
    {
        // 设置页面标题
        $this->title = '小程序用户列表';
        // 获取到所有GET参数
        $get = $this->request->get();
        // 实例Query对象
        $db = Db::name($this->table);
        // 应用搜索条件
        foreach (['nickname', 'phone'] as $key) {
            if (isset($get[$key]) && $get[$key] !== '') {
                $db->where($key, 'like', "%{$get[$key]}%");
            }
        }
        // 实例化并显示
        return parent::_list($db);
    }

    public function coupon(){
        $user_id = $this->request->get('user_id');
        $db = Db::name('AppUserCoupon')
            ->alias('uc')
            ->join('app_user u','u.id=uc.user_id','left')
            ->join('app_coupon c','c.id=uc.coupon_id','left')
            ->where('uc.user_id',$user_id)
            ->field('c.*,c.deadline_date,uc.is_used')
            ->order('uc.created_time desc');
        return parent::_list($db,false);
    }

    public function _coupon_data_filter(){
        $user_id = $this->request->get('user_id');
        $myCoupons = Db::name('AppUserCoupon')->where('user_id',$user_id)->column('coupon_id');
        $couponList = Db::name('AppCoupon')->where('id','not in',$myCoupons)->order('id desc')->select();
        $this->assign('couponList',$couponList);
    }
}
