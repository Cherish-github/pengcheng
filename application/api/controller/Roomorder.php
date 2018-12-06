<?php
/**
 * Copyright: 深圳市三牛犇科技有限公司
 * User: 小米飞刀
 * Date: 2018/4/25
 * Time: 14:35
 */
namespace app\api\controller;
use think\Cache;
use think\Db;
use think\Error;
use think\Validate;

class Roomorder{
    public $table = 'AppRoomOrder';

    /**
     * 获取我的订房订单列表
     * @param status: -2全部订单，-1取消订单，0待付款，1待入住，2待离店，3已完成
     */
    public function getList(){
        $openid = session('openid');
        $page       = input('page/d',1);
        $pageSize   = input('pageSize/d',2);
        if($page<1 || $pageSize<1){
            return [
                'code'  => 400,
                'msg'   => '参数错误'
            ];
        }
        $start      = ($page - 1) * $pageSize;
        $status     = input('status/d',-2);
        if (!in_array($status,[-2,-1,0,1,2,3])){
            return ['code'=>400,'msg'=>'参数错误'];
        }
        $where = ['o.openid'=>$openid,'deleted'=>0];

        if($status!=-2){
            $where['o.status'] = $status;
        }
        $count = Db::name($this->table)
            ->alias('o')
            ->join('app_order_room r','r.order_id=o.id','left')
            ->where($where)
            ->count();
        $pages = ceil($count/$pageSize);
        $list      =  Db::name($this->table)
             ->alias('o')
             ->join('app_order_room r','r.order_id=o.id','left')
             ->where($where)
             ->order('o.id desc')
             ->limit($start,$pageSize)
             ->field('o.id,o.order_no,o.start_date,o.left_date,o.status,o.amount,o.coupon_price,o.pay_money,r.title,r.num')
             ->select();
        foreach ($list as &$v){
            if ($v['status']<=0){
                $v['sum'] = fmtPrice($v['amount']-$v['coupon_price']);
            } elseif($v['status'] > 0){
                $v['sum'] = fmtPrice($v['pay_money']);
            }
            unset($v['amount']);
            unset($v['coupon_price']);
            unset($v['pay_money']);
            $diff = strtotime($v['left_date']) - strtotime($v['start_date']);
            $v['day'] = ceil($diff / (24 * 3600));
        }
        return [
            'code'  => 200,
            'data'  => $list,
            'pages' => $pages
        ];
    }

    /**
     * 取消订单
     */
    public function cancelOrder(){
        $openid = session('openid');
        $id             = input('id');
        if($id < 1){
            return ['code'  => 'ERROR', 'msg'   => '参数错误'];
        }
        $orderInfo  = Db::name($this->table)
            ->where('id',$id)
            ->where('deleted',0)
            ->where('openid',$openid)
            ->field('status')
            ->find();
        if(empty($orderInfo) || @$orderInfo['status']!=0){
            return [
                'code'  => 'ERROR',
                'msg'   => '该订单不符合取消条件!'
            ];
        }
        try {
            Db::name($this->table)->where('id', $id)->update(['status'=> -1]);
        }catch(\Exception $e){
            p($e->getMessage());
            return [
                'code'  => 'ERROR',
                'msg'   => '取消失败!'
            ];
        }
        return [
            'code'  => 'SUCCESS',
            'msg'   => '取消成功!'
        ];
    }

    /**
     * 删除订单
     */
    public function delOrder(){
        $openid = session('openid');
        $id             = input('id');
        if($id < 1){
            return ['code'  => 'ERROR', 'msg'   => '参数错误'];
        }
        $orderInfo  = Db::name($this->table)
            ->where('id',$id)
            ->where('openid',$openid)
            ->field('status')
            ->find();
        if(empty($orderInfo) || @$orderInfo['status']!=3){
            return [
                'code'  => 'ERROR',
                'msg'   => '该订单不符合删除条件!'
            ];
        }
        try {
            Db::name($this->table)->where('id', $id)->update(['deleted'=> 1]);
        }catch(\Exception $e){
            p($e->getMessage());
            return [
                'code'  => 'ERROR',
                'msg'   => '删除订单失败!'
            ];
        }
        return [
            'code'  => 'SUCCESS',
            'msg'   => '删除订单成功!'
        ];
    }

    /**
     * 提交订单
     */
    public function submitOrder(){
        $start_date = input('start_date','');
        $left_date = input('left_date','');
        $data['name']       = input('name','');
        $data['phone']      = input('phone','');
        $data['num']      = input('num',1);
        $uc_id  = input('uc_id',0);
        $user_id    = session('user_id');
        $room_id    = input('room_id/d',0);
        if ($room_id < 1){
            return ['code'=>400,'msg'=>'请选择房间下单'];
        }
        if (date('Y-m-d',strtotime($start_date))!=$start_date){
            return ['code'=>400,'msg'=>'住店日期格式错误'];
        }
        if (date('Y-m-d',strtotime($left_date))!=$left_date){
            return ['code'=>400,'msg'=>'离店日期格式错误'];
        }
        $rule = [
            ['name','require|max:10','联系人姓名必须|联系人姓名长度不能超过10个字符'],
            ['phone','require|regex:/^1[356789]\d{9}$/','手机号码必须|手机号码格式错误'],
            ['num','number|min:1','订房数量必须为数字|订房数量至少为1间'],
        ];
        $validate = new Validate($rule);
        $result   = $validate->check($data);
        if(!$result){
            return [
                'code'=>400,
                'msg'=>$validate->getError()
            ];
        }
        if ($uc_id!=0){
            //判断优惠券是否可用
            $coupon = Db::name('AppUserCoupon')
                ->alias('uc')
                ->join('app_coupon c','c.id=uc.coupon_id','left')
                ->where('uc.user_id',$user_id)
                ->where('uc.id',$uc_id)
                ->field('c.deadline_date,uc.is_used,c.cut_price')
                ->find();
            if (!$coupon){
                return ['code'=>400,'msg'=>'优惠券不存在'];
            }
            if ($coupon['is_used']==1){
                return ['code'=>400,'msg'=>'优惠券已使用，不能再次使用'];
            }
            if (strtotime($coupon['deadline_date']) < time()){
                return ['code'=>400,'msg'=>'优惠券已过期，不能使用'];
            }
            $orderInfo['is_coupon'] = 1;
            $orderInfo['coupon_price']  = $coupon['cut_price'];
        }else{
            $orderInfo['is_coupon'] = 0;
            $orderInfo['coupon_price']  = 0.00;
        }

        $room = Db::name('AppRoom')
            ->alias('r')
            ->join('app_room_people_type pt','pt.id=people_type_id','left')
            ->where('r.id',$room_id)
            ->where('is_show',1)
            ->field('r.id,pt.type pt_type,r.price,r.num')
            ->find();
        if (!$room){
            return ['code'=>400,'msg'=>'下单的房间不存在'];
        }
        $count = Db::name('AppRoomOrder')
            ->alias('o')
            ->join('app_order_room r','r.order_id=o.id','left')
            ->where('o.status','in',[1,2])
            ->where('r.room_id',$room['id'])
            ->count();
        $left_num = $room['num'] - $count;
        if ($left_num <= 0){
            return ['code'=>400,'msg'=>'剩余房间只有'.$left_num.'间，请重新选择数量'];
        }

        $orderInfo['openid']    = session('openid');
        $orderInfo['order_no']  = date('YmdHis').rand(100000,999999);
        $orderInfo['start_date'] = $start_date;
        $orderInfo['left_date'] = $left_date;
        $orderInfo['status']    = 0;  //未支付
        $orderInfo['amount'] = sprintf('%.2f',$room['price'] * $data['num']);

        $roomInfo['title'] = $room['pt_type'];
        $roomInfo['price'] = $room['price'];
        $roomInfo['room_id'] = $room['id'];
        $roomInfo['num'] = $data['num'];

        unset($data['num']);
        $orderInfo = array_merge($orderInfo,$data);

        Db::startTrans();
        try{
            $order_id = Db::name('AppRoomOrder')->insertGetId($orderInfo);
            $roomInfo['order_id'] = $order_id;
            Db::name('AppOrderRoom')->insert($roomInfo);
            Db::commit();
        }catch (Exception $e){
            Db::rollback();
            p($e->getMessage());
            return ['code'=>400,'msg'=>'提交订单失败，请稍后重试'];
        }
        return ['code'=>200,'data'=>$order_id];
    }

    /**
     * 去支付
     */
    public function pay(){
        $order_id             = input('order_id/d',0);
        if($order_id < 1){
            return ['code'  => 400, 'msg'   => '参数错误'];
        }
        $openid = session('openid');
        $orderInfo  = Db::name($this->table)
            ->where('id',$order_id)
            ->where('openid',$openid)
            ->find();
        if(empty($orderInfo) || @$orderInfo['status']!=0){
            return [
                'code'  => 'ERROR',
                'msg'   => '该订单不符支付条件!'
            ];
        }

        $fee = config('app_debug')?1:($orderInfo['amount']-$orderInfo['coupon_price'])*100;
//        $url    = request()->domain().'/index/Wechatnotify/room';
        $notify_url = url('/index/Wechatnotify/room',null,true,true);
        $wechat = load_wechat('pay');
        $prepayid = $wechat->getPrepayId($orderInfo['openid'], '鹏城酒店订房支付', $orderInfo['order_no'], $fee, $notify_url, 'JSAPI');
        if(empty($prepayid)){
            return [
                'code'  => 500,
                'msg'   => '调起支付失败!'
            ];
        }
        $paymentInfo = $wechat->createMchPay($prepayid);
        return [
            'code'      => 201,
            'data'      => $paymentInfo
        ];

    }
}

