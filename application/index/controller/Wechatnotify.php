<?php
/**
 * Copyright: 深圳市三牛犇科技有限公司
 * User: 小米飞刀
 * Date: 2018/5/2
 * Time: 14:56
 */
namespace app\index\controller;
use think\Log;
use think\Db;
class Wechatnotify{
    public function goods(){
        // 实例支付接口
        $pay = &load_wechat('Pay');
        // 获取支付通知
        $notifyInfo = $pay->getNotify();

        // 支付通知数据获取失败
        if ($notifyInfo === false) {
            // 接口失败的处理
            Log::error("微信支付通知消息验证失败，{$pay->errCode}[{$pay->errCode}]");
            return $pay->errMsg;
        } else {
            //支付通知数据获取成功
            if ($notifyInfo['result_code'] == 'SUCCESS' && $notifyInfo['return_code'] == 'SUCCESS') {
                p($notifyInfo,false, RUNTIME_PATH .'log/'.date('Ym').'/WechatPay.txt' );
                $orderInfo  = Db::name('AppGoodsOrder')->where('order_no',$notifyInfo['out_trade_no'])->find();
                if(empty($orderInfo)){
                    exit;
                }
                $order['out_trade_no'] = $notifyInfo['transaction_id'];//微信支付订单号
                $order['pay_money'] = intval($notifyInfo['total_fee']) / 100;
                $order['status'] = 1;//待用餐
                $order['pay_time'] = date("Y-m-d H:i:s",strtotime($notifyInfo['time_end']));
                try{
                    Db::name('AppGoodsOrder')
                        ->where('order_no', $notifyInfo['out_trade_no'])
                        ->update($order);
                    Db::name('AppGoodsCart')->where('user_id',session('user_id'))->delete();
                }catch (\Exception $e){
                    p($e->getMessage());
                    exit;
                }

                $data = Db::name('AppGoodsOrder')
                    ->alias('o')
                    ->join('app_order_goods g','g.order_id=o.id','left')
                    ->where('o.order_no', $notifyInfo['out_trade_no'])
                    ->field('o.openid,o.pay_money,o.pay_time,o.remark,o.order_no,group_concat(g.`title`) goods')
                    ->group('g.order_id')
                    ->find();
                $this->goodsHook($data);

                // 回复xml，replyXml方法是终态方法
                $pay->replyXml(['return_code' => 'SUCCESS', 'return_msg' => '系统业务处理成功！']);
            }
        }

    }

    public function room(){
        // 实例支付接口
        $pay = &load_wechat('Pay');
        // 获取支付通知
        $notifyInfo = $pay->getNotify();

        // 支付通知数据获取失败
        if ($notifyInfo === false) {
            // 接口失败的处理
            Log::error("微信支付通知消息验证失败，{$pay->errCode}[{$pay->errCode}]");
            return $pay->errMsg;
        } else {
            //支付通知数据获取成功
            if ($notifyInfo['result_code'] == 'SUCCESS' && $notifyInfo['return_code'] == 'SUCCESS') {
                p($notifyInfo,false, RUNTIME_PATH .'log/'.date('Ym').'/WechatPay.txt' );
                $orderInfo  = Db::name('AppRoomOrder')->where('order_no',$notifyInfo['out_trade_no'])->find();
                if(empty($orderInfo)){
                    exit;
                }
                $order['out_trade_no'] = $notifyInfo['transaction_id'];//微信支付订单号
                $order['pay_money'] = intval($notifyInfo['total_fee']) / 100;
                $order['status'] = 1;//待入住
                $order['pay_time'] = date("Y-m-d H:i:s",strtotime($notifyInfo['time_end']));
                try{
                    Db::name('AppRoomOrder')
                        ->where('order_no', $notifyInfo['out_trade_no'])
                        ->update($order);
                }catch (\Exception $e){
                    p($e->getMessage());
                    exit;
                }
                $data = Db::name('AppRoomOrder')
                    ->alias('o')
                    ->join('app_order_room r','r.order_id=o.id','left')
                    ->where('o.order_no', $notifyInfo['out_trade_no'])
                    ->field('o.openid,o.pay_money,o.start_date,o.order_no,r.title,r.num')
                    ->find();
                $this->roomHook($data);

                // 回复xml，replyXml方法是终态方法
                $pay->replyXml(['return_code' => 'SUCCESS', 'return_msg' => '系统业务处理成功！']);
            }
        }

    }

    public function goodsHook($data){
        //实例模板消息接口
        $message = &load_wechat('Message');
        $data  = [
            "touser"        => $data['openid'],
            "template_id"   => 'g4Ya8KaDouqVQgIbhh9ptoJps01OMpha1KwRTmIoMxg',
            "topcolor"      => "#FF0000",
            "data"          => [
                "first" => [
                    "value" => "订餐订单支付成功",
                    "color" => "#173177"
                ],
                "keyword1" => [
                    "value" => $data['order_no'],
                    "color" => "#173177"
                ],
                "keyword2" => [
                    "value" => $data['goods'],
                    "color" => "#173177"
                ],
                "keyword3" => [
                    "value" => $data['pay_money'],
                    "color" => "#173177"
                ],
                "keyword4" => [
                    "value" => $data['pay_time'],
                    "color" => "#173177"
                ],
                "remark" => [
                    "value" => '备注： '.$data['remark'],
                    "color" => "#173177"
                ]
            ]
        ];

        $result = $message->sendTemplateMessage($data);
        p($result,false, RUNTIME_PATH .'log/'.date('Ym').'/WechatMessage.txt' );
    }

    public function roomHook($data){
        //实例模板消息接口
        $message = &load_wechat('Message');
        $data  = [
            "touser"        => $data['openid'],
            "template_id"   => 'BHXMpQ11F-_SswZWLFNvP9HKhCo3raQD-7TkLU7rTBI',
            "topcolor"      => "#FF0000",
            "data"          => [
                "first" => [
                    "value" => "订房订单支付成功",
                    "color" => "#173177"
                ],
                "hotelName" => [
                    "value" => "鹏城酒店",
                    "color" => "#173177"
                ],
                "roomName" => [
                    "value" => $data['title'].' '.$data['num'].'间',
                    "color" => "#173177"
                ],
                "pay" => [
                    "value" => $data['pay_money'],
                    "color" => "#173177"
                ],
                "date" => [
                    "value" => $data['start_date'],
                    "color" => "#173177"
                ],
                "remark" => [
                    "value" => '订单编号: '.$data['order_no'],
                    "color" => "#173177"
                ]
            ]
        ];
        $result = $message->sendTemplateMessage($data);
        p($result,false, RUNTIME_PATH .'log/'.date('Ym').'/WechatMessage.txt' );
    }

}
