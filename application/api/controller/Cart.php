<?php
/**
 * Copyright: 深圳市三牛犇科技有限公司
 * User: 小米飞刀
 * Date: 2018/4/25
 * Time: 14:39
 */
namespace app\api\controller;
use think\Db;
use think\Validate;
use think\Cache;
/**
 *购物车
 * Class Cart
 */
class Cart{
    public $table = 'AppGoodsCart';

    /**
     * 添加购物车
     */
    public function add(){
        $goods_id   = input('goods_id/d',0);

        if ($goods_id < 1){
            return ['code'=>400,'msg'=>'商品参数错误'];
        }
        $user_id = session('user_id');
        if (!$user_id){
            return;
        }
        $goods = Db::name('AppGoods')->where('id',$goods_id)->find();
        if (!$goods){
            return ['code'=>400,'msg'=>'商品不存在'];
        }
        $curDayOrderNum = Db::name('AppGoodsOrder')
            ->alias('o')
            ->join('app_order_goods g','g.order_id=o.id','left')
            ->where('g.goods_id',$goods_id)
            ->whereTime('pay_time', 'today')
            ->where('o.status','in',[1,2])
            ->count();
//        if ($curDayOrderNum >= $goods['num'] ){
//            return ['code'=>201,'msg'=>'商品已售完'];
//        }

        $res = Db::name($this->table)
            ->where('user_id',$user_id)
            ->where('goods_id',$goods_id)
            ->find();
        if ($res){
            $r = Db::name($this->table)
                ->where('user_id',$user_id)
                ->where('goods_id',$goods_id)
                ->setInc('num',1);
        }else{
            $r = Db::name($this->table)
                ->insert([
                    'user_id'   => $user_id,
                    'goods_id'  => $goods_id,
                    'num'       => 1
                ]);
        }
        if ($r){
            return ['code'=>200,'msg'=>'添加购物车成功'];
        }
    }

    /**
     * 删除购物车
     */
    public function del(){
        $goods_id   = input('goods_id/d',0);
        if ($goods_id < 1){
            return ['code'=>400,'msg'=>'商品参数错误'];
        }
        $user_id = session('user_id');
        if (!$user_id){
            return;
        }
        $res = Db::name($this->table)
            ->where('user_id',$user_id)
            ->where('goods_id',$goods_id)
            ->find();
        if (!$res){
            return ['code'=>400,'msg'=>'购物车中该商品不存在'];
        }
        if ($res['num'] <= 1){
            $r = Db::name($this->table)
                ->where('user_id',$user_id)
                ->where('goods_id',$goods_id)
                ->delete();
        }else{
            $r = Db::name($this->table)
                ->where('user_id',$user_id)
                ->where('goods_id',$goods_id)
                ->setDec('num',1);
        }
        if ($r){
            return ['code'=>200,'msg'=>'购物车中的商品删除成功'];
        }
    }

    /**
     * 清空购物车
     * @return array|void
     */
    public function clear(){
        $user_id = session('user_id');
        if (!$user_id){
            return;
        }
        $res = Db::name('AppGoodsCart')
            ->where('user_id',$user_id)
            ->delete();
        return ['code'=>200,'msg'=>'清空购物车成功'];
    }
}
