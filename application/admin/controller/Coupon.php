<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/9/6
 * Time: 14:11
 */

namespace app\admin\controller;
use controller\BasicAdmin;
use think\Db;
use service\DataService;

class Coupon extends BasicAdmin
{
    public $table = 'AppCoupon';

    public function index(){
        $db = Db::name($this->table)
            ->order('created_time desc');
        $this->assign('title','优惠券列表');
        return parent::_list($db);
    }

    public function add(){
        return parent::_form(null,'form','','');
    }

    public function edit(){
        return parent::_form(null,'form','','');
    }

    public function del(){
        $ids = input('id');
        if(DataService::update($this->table)){
            Db::name('AppUserCoupon')->where('coupon_id','in',$ids)->delete();
            $this->success('删除成功！','');
        }
        $this->error('删除失败！');
    }
}