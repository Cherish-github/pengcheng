<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/9/10
 * Time: 15:19
 */

namespace app\index\controller;
use think\Db;

class Order extends Common
{
    /**
     * 房间下单页面
     * @return mixed
     */
    public function room(){
        $user_id = session('user_id');
        if (!$user_id){
            $this->error('请重新登录');
        }
        //选完优惠券过来
        $uc_id = input('uc_id/d',0);
        if ($uc_id){
            $coupon = Db::name('AppUserCoupon')
                ->alias('uc')
                ->join('app_coupon c','c.id=uc.coupon_id','left')
                ->where('uc.user_id',$user_id)
                ->where('uc.id',$uc_id)
                ->where('uc.is_used',0)
                ->field('c.cut_price,uc.id')
                ->find();
            if ($coupon){
                $coupon_price = $coupon['cut_price'];
                $uc_id = $coupon['id'];
            }else{
                $coupon_price = 0;
                $uc_id = 0;
            }
        }else{
            $coupon_price = 0;
            $uc_id = 0;
        }
        $room_id = input('id/d',0);
        if (!$room_id){
            $this->error('请先选择房间');
        }
        $room = Db::name('AppRoom')
            ->alias('r')
            ->join('app_room_people_type pt','pt.id=r.people_type_id','left')
            ->where('r.id',$room_id)
            ->field('r.id,r.price,r.num,pt.type pt_type')
            ->find();
        if (!$room){
            $this->error('房间不存在');
        }
        $room['title'] = $room['pt_type'];
        $count = Db::name('AppRoomOrder')
            ->alias('o')
            ->join('app_order_room r','r.order_id=o.id','left')
            ->where('o.status','in',[1,2])
            ->where('r.room_id',$room['id'])
            ->count();
        $room['left_num'] = $room['num'] - $count;

        $content1 = Db::name('WebContent')->where('call_id',3)->find();
        $refundInfo = $content1['content'];
        $content2 = Db::name('WebContent')->where('call_id',4)->find();
        $remark = $content2['content'];

        $this->assign('room',$room);
        $this->assign('coupon_price',$coupon_price);
        $this->assign('uc_id',$uc_id);
        $this->assign('refundInfo',$refundInfo);
        $this->assign('remark',$remark);

        $this->assign('title','订单填写');
        return $this->fetch();
    }

    /**
     * 订餐下单页面
     * @return mixed
     */
    public function goods(){
        $user_id = session('user_id');
        if (!$user_id){
            $this->error('请重新登录');
        }
        //选完优惠券过来
        $uc_id = input('uc_id/d',0);
        if ($uc_id){
            $coupon = Db::name('AppUserCoupon')
                ->alias('uc')
                ->join('app_coupon c','c.id=uc.coupon_id','left')
                ->where('uc.user_id',$user_id)
                ->where('uc.id',$uc_id)
                ->where('uc.is_used',0)
                ->field('c.cut_price,uc.id')
                ->find();
            if ($coupon){
                $coupon_price = $coupon['cut_price'];
                $uc_id = $coupon['id'];
            }else{
                $coupon_price = 0;
                $uc_id = 0;
            }
        }else{
            $coupon_price = 0;
            $uc_id = 0;
        }
        $cart_goods = Db::name('AppGoodsCart')
            ->alias('c')
            ->join('app_goods g','g.id=c.goods_id','left')
            ->where('c.user_id',$user_id)
            ->field('g.id goods_id,g.title,g.thumb,g.price,c.num')
            ->select();
        $amount = 0.00;     //总价
        foreach ($cart_goods as $c){
            $amount += $c['num'] * $c['price'];
        }
        $amount = $amount - $coupon_price;
        $this->assign('cart_goods',$cart_goods);
        $this->assign('amount',$amount);
        $this->assign('coupon_price',$coupon_price);
        $this->assign('uc_id',$uc_id);
        $this->assign('title','订单填写');
        return $this->fetch();
    }

}