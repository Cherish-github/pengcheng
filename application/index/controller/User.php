<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/9/10
 * Time: 14:53
 */

namespace app\index\controller;
use think\Db;

class User extends Common
{
    public $table = 'AppUser';

    /**
     * 个人中心页面
     * @return mixed
     */
    public function index(){
        $userInfo = Db::name($this->table)->where('id',session('user_id'))->field('nickname,avatarurl')->find();
        $this->assign('userInfo',$userInfo);
        $this->assign('title','个人中心');
        return $this->fetch();
    }

    /**
     * 个人资料修改页面
     * @return mixed
     */
    public function modify(){
        $user_id = session('user_id');
        $user = Db::name($this->table)->where('id',$user_id)->field('name,phone')->find();
        $this->assign('userInfo',$user);
        $this->assign('title','编辑信息');
        return $this->fetch();
    }

    /**
     * 优惠券列表页面
     * @return mixed
     */
    public function coupon(){
        //1 下单页面过来
        $way = input('way/d',0);

        //房间订单页面过来
        if ($way==2){
            $room_id = input('room_id/d',0);
            $this->assign('room_id',$room_id);
        }
        $this->assign('way',$way);
        $this->assign('title','优惠券');
        return $this->fetch();
    }

    /**
     * 订餐订单页面
     * @return mixed
     */
    public function goodsOrder(){
        $this->assign('title','我的订单');
        return $this->fetch('goods_order');
    }

    /**
     * 订房订单页面
     * @return mixed
     */
    public function roomOrder(){
        $type = input('type/d');
        $this->assign('type',$type);
        $this->assign('title','我的订单');
        return $this->fetch('room_order');
    }

    /**
     * 订房订单详情
     * @return mixed
     */
    public function roomOrderDetail(){
        $order_id = input('id/d');
        $openid = session('openid');
        $data = Db::name('AppRoomOrder')
            ->alias('o')
            ->join('app_order_room r','o.id=r.order_id','left')
            ->where('o.id',$order_id)
            ->where('o.deleted',0)
            ->where('o.openid',$openid)
            ->field('o.id,o.order_no,o.start_date,o.left_date,o.amount,o.coupon_price,o.pay_money,o.name,o.phone,o.status,r.room_id,r.title,r.num')
            ->find();
        if (!$data){
            $this->error('订单不存在');
        }
        if ($data['status']==0){
            $data['sum'] = fmtPrice($data['amount']-$data['coupon_price']);
        }elseif($data['status'] > 0){
            $data['sum'] = fmtPrice($data['pay_money']);
        }
        unset($data['amount']);
        unset($data['coupon_price']);
        unset($data['pay_money']);
        $diff = strtotime($data['left_date']) - strtotime($data['start_date']);
        $data['day'] = ceil($diff / (24 * 3600));
        $this->assign('orderInfo',$data);

        $this->assign('title','我的订单');
        return $this->fetch('room_order_x');
    }
}