<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/9/10
 * Time: 14:49
 */

namespace app\index\controller;
use think\Db;

class Room extends Common
{
    public $table = 'AppRoom';
    public function index(){
        //获取banner
        $banners = Db::name("AppBanner")->where('type',2)->order('sort')->column('filename');
        $this->assign('banners',$banners);

        //获取电话
        $contact = Db::name('WebContact')->where('call_id',1)->find();
        $this->assign('phone',$contact['phone']);

        //获取房间列表
        $rooms = Db::name($this->table)
            ->alias('r')
            ->join('app_room_people_type pt','pt.id=r.people_type_id','left')
            ->where('r.is_show',1)
            ->field('r.id,r.price,r.thumb,r.num,pt.type pt_type')
            ->select();
        foreach ($rooms as &$v){
            $v['title'] = $v['pt_type'];
            $count = Db::name('AppRoomOrder')
                ->alias('o')
                ->join('app_order_room r','r.order_id=o.id','left')
                ->where('o.status','in',[1,2])
                ->where('r.room_id',$v['id'])
                ->count();
            $v['left_num'] = $v['num'] - $count;

            unset($v['num']);
            unset($v['pt_type']);
        }
        $this->assign('rooms',$rooms);

        $this->assign('title','订房');
        return $this->fetch();
    }

    public function detail(){
        $id     = input('id/d',0);
        if($id < 1){
            $this->error('参数错误');
        }
        $data   = Db::name($this->table)
            ->alias('r')
            ->join('app_room_people_type pt','pt.id=r.people_type_id','left')
            ->where('r.is_show',1)
            ->where('r.id',$id)
            ->field('r.id,r.price,r.detail_img,r.intro,r.num,pt.type pt_type')
            ->find();
        if (!$data){
            $this->error('房间不存在');
        }
        $data['title'] = $data['pt_type'];
        $data['detail_img'] = explode('|',$data['detail_img']);
        $count = Db::name('AppRoomOrder')
            ->alias('o')
            ->join('app_order_room r','r.order_id=o.id','left')
            ->where('o.status','in',[1,2])
            ->where('r.room_id',$data['id'])
            ->count();
        $data['left_num'] = $data['num'] - $count;

        unset($data['num']);
        unset($data['pt_type']);

        $this->assign('detail',$data);
        $this->assign('title','房间详情');
        return $this->fetch();
    }
}