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
use think\Validate;

class Contact extends BasicAdmin
{
    public $table = "webContact";

    public function index(){
        $db = Db::name($this->table);
        $this->assign('title','联系方式');
        return parent::_list($db);
    }

    public function add(){
        $data = '';
        if($this->request->isPost()){
            $item = Db::name($this->table)->order("call_id desc")->field("call_id")->find();
            if(!empty($item)){
                $data["call_id"] = ++$item["call_id"];
            }else{
                $data["call_id"] =1;
            }
        }
        return $this->_form($this->table, 'form','','',$data);
    }

    public function _form_filter($data){
        if($this->request->isPost()) {
            $rule = [
                ["call_id", "require|unique:" . $this->table, "调用ID不能为空|调用ID不能重复"]
            ];
            $validate = new Validate($rule);
            if (!$validate->check($data)) {
                $msg = $validate->getError();
                $this->Error($msg);
                return false;
            }
        }
        return true;
    }

    public function edit(){
        return parent::_form(null,'form');
    }

    public function del(){
        $ids = $this->request->post("id");
        $res = Db::name($this->table)->where("id","in",$ids)->delete();
        if($res){
            $this->success("删除成功","");
        }else{
            $this->error("删除失败，请稍候再试！");
        }
    }
}