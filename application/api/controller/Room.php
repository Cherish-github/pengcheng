<?php

/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/16
 * Time: 14:25
 */

namespace app\api\controller;
use think\Cache;
use think\Db;
use think\Validate;

class Room
{
    public $table = 'AppRoom';

    /**
     * 获取订房模块banner图
     */
    public function banner(){
        $res = Db::name("AppBanner")->where('type',2)->order('sort')->field('filename,title')->select();
        return [
            'code'  => 'SUCCESS',
            'data'  => $res
        ];
    }

    /**
     * 获取房间列表
     */
    public function getList(){
        $session3rd = input('session3rd');
        $userInfo = Cache::get($session3rd);
        $userInfo['openid'] = 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k';
        if(empty($userInfo)){
            return ['code'  => 'FAIL', 'msg'   => '请重新授权'];
        }

        $page           = input('page/d',1);
        $pageSize       = input('pageSize/d',6);
        $start          = ($page - 1 ) * $pageSize;

        if ($page<1 || $pageSize<1){
            return [
                'code'  => 'ERROR',
                'msg'   => '缺少必填参数~'
            ];
        }
        $data = Db::name($this->table)
            ->alias('r')
            ->join('app_room_people_type pt','pt.id=r.people_type_id','left')
            ->where('r.is_show',1)
            ->field('r.id,r.price,r.thumb,r.num,pt.type pt_type')
//            ->limit($start,$pageSize)
            ->select();
        foreach ($data as &$v){
            $v['title'] = $v['pt_type'];
            $count = Db::name('AppRoomOrder')
                ->alias('o')
                ->join('app_order_room r','r.order_id=o.id','left')
                ->where('o.status','in',[1,2])
                ->where('r.room_id',$v['id'])
                ->where('o.openid',$userInfo['openid'])
                ->count();
            $v['left_num'] = $v['num'] - $count;

            unset($v['num']);
            unset($v['pt_type']);
        }

        return [
            'code'  => 'SUCCESS',
            'data'  => $data
            ];
    }

    /**
     * 获取房间详情
     */
    public function getDetail(){
        $id     = input('id',0);
        $session3rd = input('session3rd');
        if($id < 1){
            return ['code'  => 'ERROR','msg'   => '参数错误'];
        }
        $userInfo = Cache::get($session3rd);
        $userInfo['openid'] = 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k';
        if(empty($userInfo)){
            return ['code'  => 'FAIL', 'msg'   => '请重新授权'];
        }
        $data   = Db::name($this->table)
            ->alias('r')
            ->join('app_room_people_type pt','pt.id=r.people_type_id','left')
            ->where('r.is_show',1)
            ->where('r.id',$id)
            ->field('r.id,r.price,r.detail_img,r.intro,r.num,pt.type pt_type')
            ->find();
        if (!$data){
            return [
                'code' => 'ERROR',
                'msg'   => '课程不存在',
            ];
        }
        $data['title'] = $data['pt_type'] .' -'.$data['ft_type'];
        $count = Db::name('AppRoomOrder')
            ->alias('o')
            ->join('app_order_room r','r.order_id=o.id','left')
            ->where('o.status','in',[1,2])
            ->where('r.room_id',$data['id'])
            ->where('o.openid',$userInfo['openid'])
            ->count();
        $data['left_num'] = $data['num'] - $count;

        unset($data['num']);
        unset($data['pt_type']);

        return [
            'code'  =>  'SUCCESS',
            'data'  =>  $data
        ];
    }

}