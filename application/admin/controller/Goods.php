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
class Goods extends BasicAdmin
{
    public $table   = 'appGoods';
    public $title   = '商品列表';
    public function index(){
        $db = Db::name($this->table);
        if($this->request->isGet()){
            $db->alias('g');
            $db->join('app_goods_type e','e.id=g.type_id','left');
            $db->field('g.*,e.type');
            $db->order('sort asc,id desc');

            if($this->request->get('type')){
                $db->where('e.id',$this->request->get('type'));
            }
        }
        return parent::_list($db);
    }
    public function _data_filter($data){
            if($this->request->isGet()){

                $types      = Db::name('appGoodsType')
                    ->where("is_show",1)
                    ->field('id,type')
                    ->select();
                $this->assign('types',$types);
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

            $types      = Db::name('appGoodsType')
                            ->where("is_show",1)
                            ->field('id,type')
                            ->select();
            $this->assign('types',$types);

            if (isset($data['id'])){
                $data['detail_img'] = explode('|',$data['detail_img']);
            }
        }else{
            $data['is_show'] =  isset($data['is_show'])?$data['is_show']:0;
            $data['is_recommend'] =  isset($data['is_recommend'])?$data['is_recommend']:0;
            if($data['price'] == '0.00'){
                $this->error('价格不能为0.00');
            }

            // if ($data['intro']==''){
            //     $this->error('请填写商品详情');
            // }
            // if (!isset($data['detail_img']) || count($data['detail_img'])<1) {
            //     $this->error('请上传详情页banner图');
            // }
//            dump($data['detail_img']);die;
            // $imgs = [];
            // foreach ($data['detail_img'] as $img){
            //     if ($img){
            //         $imgs[] = $img;
            //     }
            // }
            // $data['detail_img'] = implode('|',$imgs);
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
            $detail_imgs = explode('|',$v['detail_img']);
            foreach ($detail_imgs as $i){
                @unlink(WEB_ROOT.$i);
            }
        }
        if(DataService::update($this->table)){
            Db::name('AppGoodsCart')->where('id','in',$ids)->delete();
            $this->success('删除成功！','');
        }
        $this->error('删除失败！');
    }
}