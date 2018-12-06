<?php
/**
 * Copyright: 深圳市三牛犇科技有限公司
 * User: 小米飞刀
 * Date: 2018/5/20
 * Time: 15:03
 */
namespace app\admin\controller;
use controller\BasicAdmin;
use think\Db;
use service\DataService;
class Goodsorder extends BasicAdmin{
    public $table   = "AppGoodsOrder";
    public $title   = "订餐列表";

    public function index(){
        $db = null;
        $get = $this->request->get();
        if($this->request->isGet()){
            $db = Db::name($this->table)
                ->alias('o')
                ->join('app_user u','o.openid=u.openid','left')
                ->join('app_order_goods g','o.id = g.order_id','left')
                ->group('o.id')
                ->order('o.id desc')
                ->field('o.*,u.nickname,u.avatarurl,g.title,g.num');

            foreach (['title', 'order_no'] as $key) {
                if (isset($get[$key]) && $get[$key] !== '') {
                    $db->where($key, 'like', "%{$get[$key]}%");
                }
            }

            if(isset($get['created_time']) && $get['created_time'] !==''){
                $created_time =$get['created_time'].' 00:00:00';
                $time = strtotime('+1 day',strtotime($created_time));
                $end_time = date('Y-m-d H:i:s',$time);
                $db->where("o.created_time between '".$created_time."' and '".$end_time."'");
            }

            foreach (['openid', 'meal_date','status'] as $key) {
                if (isset($get[$key]) && $get[$key] !== '') {
                    $db->where('o.'.$key,$get[$key]);
                }
            }
        }
        return parent::_list($db);
    }

    public function edit(){
        return parent::_form(null,'form');
    }

    public function _edit_form_filter(&$data){
        if($this->request->isGet()){
            $roomList = Db::name('app_order_goods')->where('order_id',$data['id'])->field('title,thumb,price,num')->select();
            $buyer      = Db::name('app_user')->where('openid',$data['openid'])->field('nickname')->find();
            $this->assign('roomList',$roomList);
            $this->assign('buyer',$buyer['nickname']);
        }
    }

    public function del(){
        $ids = $this->request->post("id");
        $res = Db::name($this->table)->where("id","in",$ids)->delete();
        Db::name('AppOrderGoods')->where('order_id',"in",$ids)->delete();
        if($res){
            $this->success("删除成功","");
        }else{
            $this->error("删除失败，请稍候再试！");
        }
    }

    /**
     * 订单完成，改变状态
     */
    public function finishOrder(){
        $id = $this->request->post('id');
        $orderInfo = Db::name($this->table)->where('id',$id)->find();
        if ($orderInfo && $orderInfo['status']==1){
            $res = Db::name($this->table)->where('id',$id)->update(['status'=>2]);
            if (false!==$res){
                $this->success('操作成功','');
            }else{
                $this->error('操作失败');
            }
        }else{
            $this->error('该订单不符合操作条件');
        }
    }

    public function canExport()
    {
        $order_no = input('order_no','');
        $title = input('title','');
        $created_time   = input('created_time','');
        $meal_date      = input('meal_date','');
        $status         = input('status','');
        $where = [];
        if($order_no){
            $where['order_no'] = ['like',"%$order_no%"];
        }
        if($title){
            $where['title'] = ['like',"%$title%"];
        }

        if($created_time){
            $created_time =$created_time.' 00:00:00';
            $time = strtotime('+1 day',strtotime($created_time));
            $end_time = date('Y-m-d H:i:s',$time);
            $where['created_time'] = ['between',[$created_time,$end_time]];
        }
        if ($meal_date!==''){
            $where['meal_date'] = ['eq',$meal_date];
        }
        if ($status!==''){
            $where['status'] = ['eq',$status];
        }
        $orderList = Db::name($this->table)
            ->alias('o')
            ->join('app_order_goods g','o.id = g.order_id','left')
            ->field("o.id")
            ->where($where)
            ->find();
        if($orderList){
            echo json_encode(['code'=>1]);
        }else{
            echo json_encode(['code'=>0]);
        }
    }

    public function order_export()
    {
        $order_no = input('order_no','');
        $title = input('title','');
        $created_time = input('created_time','');
        $meal_date      = input('meal_date','');
        $status         = input('status','');
        $where = [];
        if($order_no){
            $where['order_no'] = ['like',"%$order_no%"];
        }
        if($title){
            $where['title'] = ['like',"%$title%"];
        }

        if($created_time){
            $created_time =$created_time.' 00:00:00';
            $time = strtotime('+1 day',strtotime($created_time));
            $end_time = date('Y-m-d H:i:s',$time);
            $where['created_time'] = ['between',[$created_time,$end_time]];
        }
        if ($meal_date!==''){
            $where['meal_date'] = ['eq',$meal_date];
        }
        if ($status!==''){
            $where['status'] = ['eq',$status];
        }
        $orderList = Db::name($this->table)
            ->alias('o')
            ->join('app_order_goods g','o.id = g.order_id','left')
            ->where($where)
            ->group('o.id')
            ->order('o.id desc')
            ->field('o.*')
            ->select();
        if(!$orderList){
            $this->error('没有订单数据','');
            exit();
        }
        $strTable ='<table width="600" border="1">';
        $strTable .= '<tr>';
        $strTable .= '<td style="text-align:center;font-size:12px;width:150px;">订单编号</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="120px">下单日期</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">联系人</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">联系电话</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">订单金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">用餐时间</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">用餐人数</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">订单状态</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">优惠金额</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">商品信息</td>';
        $strTable .= '<td style="text-align:center;font-size:12px;" width="*">备注信息</td>';
        $strTable .= '</tr>';
        if(is_array($orderList)){
            foreach($orderList as $k=>$val){
                $strTable .= '<tr>';
                $strTable .= '<td style="text-align:center;font-size:12px;">&nbsp;'.$val['order_no'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['created_time'].' </td>';
                $strTable .= '<td style="text-align:center;font-size:12px;">'.$val['name'].'</td>';
                $strTable .= '<td style="text-align:right;font-size:12px;vnd.ms-excel.numberformat:@;">'.$val['phone'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">￥'.$val['pay_money'].'</td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['meal_date'].' '.$val['meal_time'].'</td>';
                $strTable .= '<td style="text-align:center;font-size:12px;">'.$val['meal_people'].'</td>';
                $strTable .= '<td style="text-align:center;font-size:12px;">'.goodsOrderStatus($val['status']).'</td>';
                $strTable .= '<td style="text-align:center;font-size:12px;">￥'.$val['coupon_price'].'</td>';
                $orderGoods = Db::name('AppOrderGoods')->where('order_id='.$val['id'])->select();
                $strGoods="";
                foreach($orderGoods as $goods){
                    $strGoods .= " 商品名称：".$goods['title'].'<br/>';
                    $strGoods .= " 商品单价：￥".$goods['price'].'<br/>';
                    $strGoods .= " 商品数量：".$goods['num']."<br />";
                }
                unset($orderCourse);
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$strGoods.' </td>';
                $strTable .= '<td style="text-align:left;font-size:12px;">'.$val['remark'].'</td>';
                $strTable .= '</tr>';
            }
        }
        $strTable .='</table>';
        unset($orderList);
        downloadExcel($strTable,'商品订单');
        exit();

    }

}
