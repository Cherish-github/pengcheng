<?php

/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/9
 * Time: 11:45
 */

namespace app\admin\controller;
use controller\BasicAdmin;
use think\Db;
use service\DataService;
class Room extends BasicAdmin
{
    public $table   = 'appRoom';
    public $title   = '房间列表';
    public function index(){
        $db = Db::name($this->table);
        if($this->request->isGet()){
            $db->alias('r');
            $db->join('app_room_people_type pt','pt.id=r.people_type_id','left');
            $db->field('r.*,pt.type p_type');
            $db->order('sort asc,id desc');
            $get = $this->request->get();
            if(isset($get['ptype']) && $get['ptype']!==''){
                $db->where('pt.id',$get['ptype']);
            }
          
        }
        return parent::_list($db);
    }
    public function _data_filter($data){
            if($this->request->isGet()){
                $ptypes      = Db::name('appRoomPeopleType')
                    ->field('id,type')
                    ->select();
                $this->assign('ptypes',$ptypes);
            }
    }
    public function edit(){
        return parent::_form(null,'form');
    }

    public function add(){
        return parent::_form(null,'form');
    }

    public function _form_filter(&$data){
        if($this->request->isGet()){
            $ptypes      = Db::name('appRoomPeopleType')
                ->field('id,type')
                ->select();
            $this->assign('ptypes',$ptypes);

            if (isset($data['id'])){
                $data['detail_img'] = explode('|',$data['detail_img']);
            }
        }else{
            $data['is_show'] =  isset($data['is_show'])?$data['is_show']:0;
            $data['price'] = sprintf('%.2f',$data['price']);
            if($data['price'] == '0.00'){
                $this->error('价格不能为0.00');
            }
            if ($data['num']==0){
                $this->error('请填写房间数量');
            }
            if ($data['intro']==''){
                $this->error('请填写房间详情');
            }
            if (!isset($data['detail_img']) || count($data['detail_img'])<1) {
            	$this->error('请上传详情页banner图');
            }
            $imgs = [];
            foreach ($data['detail_img'] as $img){
                if ($img){
                    $imgs[] = $img;
                }
            }
            $data['detail_img'] = implode('|',$imgs);
        }

    }
    public function update(){
        if(DataService::update($this->table)){
            $this->success('修改成功！','');
        }
        $this->error('修改失败！');
    }

    public function del(){
        $ids  = input('id');
        $img = Db::name($this->table)->field('thumb,detail_img')->where('id','in',$ids)->select();
        foreach($img as $v){
            @unlink(WEB_ROOT.$v['thumb']);
            @unlink(WEB_ROOT.$v['detail_img']);
        }
        if(DataService::update($this->table)){
            $this->success('删除成功！','');
        }
        $this->error('删除失败！');
    }
}