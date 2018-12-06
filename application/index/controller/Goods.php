<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/9/10
 * Time: 14:52
 */

namespace app\index\controller;
use think\Db;

class Goods extends Common
{
    /**
     * 获取商品分类及其分类下的商品
     * @return mixed
     */
    public function index(){
        $user_id = session('user_id');
        if (!$user_id){
            $this->error('请重新登录');
        }

        //获取分类
        $types = Db::name('AppGoodsType')
            ->where('is_show',1)
            ->order('sort')
            ->field('id,type')
            ->select();
        //添加热门推荐分类
        $rec = ['id'=>0,'type'=>'热门推荐'];
        array_unshift($types,$rec);

        $goods = [];    //商品
        $cart_sum = 0;  //购物车总数
        $carts = [];    //购物车内商品

        //获取各分类下的商品
        foreach ($types as $k => &$v){
            if (!$v['id']){
                $v['sum'] = 0;      //该分类的购物车商品总数

                $data = Db::name('AppGoods')
                    ->where('is_recommend',1)
                    ->field('id,title,price,thumb')
                    ->select();
                $goods[$k] = $data;
            }else{
                $c = Db::name('AppGoodsCart')
                    ->alias('c')
                    ->join('app_goods g','c.goods_id=g.id','left')
                    ->join('app_goods_type t','g.type_id=t.id','left')
                    ->where('t.id',$v['id'])
                    ->where('c.user_id',$user_id)
                    ->sum('c.num');
                $v['sum'] = $c;     //该分类的购物车商品总数
                $cart_sum += $c;    //购物车商品总数叠加

                //获取该分类下的购物车商品，用于购物车中商品展示
                $cart = Db::name('AppGoodsCart')
                    ->alias('c')
                    ->join('app_goods g','c.goods_id=g.id','left')
                    ->join('app_goods_type t','g.type_id=t.id','left')
                    ->where('t.id',$v['id'])
                    ->where('c.user_id',$user_id)
                    ->field('g.title,g.id,g.price,c.num')
                    ->select();
                if ($cart){
//                    dump($cart);

                    foreach ($cart as &$c){
                        $c['type_index'] = $k;  //记录购物车中商品所属分类索引
                        $carts[] = $c;  //购物车商品叠加
                    }
                }

                //获取分类下的所有商品
                $data = Db::name('AppGoods')
                    ->alias('g')
                    ->join('app_goods_type t','g.type_id=t.id','left')
                    ->where('t.id',$v['id'])
                    ->field('g.id,g.title,g.price,g.thumb')
                    ->select();
                $goods[$k] = $data;
            }
        }
        $this->assign('types',$types);

        $amount = 0.00;
        //判断商品是否存在购物车中，并存储购物车中该商品数量，计算购物车商品总价
        foreach ($goods as $k => &$g){
            if ($k!==0){
                foreach ($g as &$v){
                    $d = Db::name('AppGoodsCart')
                        ->where('user_id',$user_id)
                        ->where('goods_id',$v['id'])
                        ->field('num')
                        ->find();
                    if ($d){
                        $v['num'] = $d['num'];
                        $amount += $d['num'] * sprintf('%.2f',$v['price']);
                    }else{
                        $v['num'] = 0;
                    }
                }
            }
        }
        $amount = sprintf('%.2f',$amount);
        $this->assign('goods',$goods);
        $this->assign('amount',$amount);

        $this->assign('carts',$carts);
        $this->assign('cart_num',$cart_sum);

        $this->assign('title','订餐');
        return $this->fetch();
    }

    /**
     * 获取商品详情
     * @return mixed
     */
    public function detail(){
        $goods_id     = input('id/d',0);
        if($goods_id < 1){
            $this->error('参数错误');
        }

        $data   = Db::name('AppGoods')
            ->where('is_show',1)
            ->where('id',$goods_id)
            ->field('id,title,price,detail_img,intro')
            ->find();
        if (!$data){
            $this->error('商品不存在');
        }
        $data['detail_img'] = explode('|',$data['detail_img']);

        $cartNum = Db::name('AppGoodsCart')->where(['goods_id'=>$data['id'], 'user_id' => session('user_id')])->find();
        $data['cart_num'] = $cartNum['num'];

        $this->assign('detail',$data);
        $this->assign('title','菜品详情');
        return $this->fetch();
    }
}