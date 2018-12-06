<?php
namespace app\admin\controller;
use controller\BasicAdmin;
use think\Db;
use service\DataService;
class Banner extends BasicAdmin
{
    public $table = "appBanner";
    public function index(){
        $get = $this->request->get();
        $db = Db::name($this->table);
        /*排序控制*/
        if(isset($get["field"]) && $get["field"]=="order"){
            $order = $get["value"];
            tableSort($this->table,$order);
        }else{
            $order = tableSort($this->table);
        }
        $db->order("sort",$order);
        // 实例化并显示
        $this->assign("title","banner管理");
        $this->assign("orderSort",$order);
        return parent::_list($db);
    }

    public function add(){
        return parent::_form(null,"form");
    }

    public function edit(){
        return parent::_form(null,"form");
    }


    protected function _form_filter($data){
        if($this->request->isPost()){
            if(strlen($data['filename'])>255){
                $this->error('图片地址过长!');
            }
        }
    }

    /**
     * 删除
     */
    public function del()
    {
        $ids = $this->request->post("id");
        $result = Db::name($this->table)->where("id","in",$ids)->select();
        foreach($result as $val){
            $filename   = str_replace($this->request->domain(),WEB_ROOT,$val["filename"]);
            @unlink($filename);
        }
        if (Db::name($this->table)->where("id","in",$ids)->delete()) {
            $this->success("数据删除成功!", '');
        }
        $this->error("数据删除失败, 请稍候再试!");
    }

}