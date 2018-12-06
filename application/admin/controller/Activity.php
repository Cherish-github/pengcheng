<?php
/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2017/9/25
 * Time: 16:36
 */
namespace app\admin\controller;
use controller\BasicAdmin;
use think\Db;
use service\DataService;
class Activity extends BasicAdmin
{
    public $table = "app_course_activity";
    public function index(){
        $db = Db::name($this->table);
        if ($this->request->isGet()){
            $type_id  = input('type');
            if (isset($type_id) && $type_id!=''){
                $db = $db->where('type',$type_id);
            }
        }
        $this->assign("title","活动管理");
        return parent::_list($db);
    }

    /*修改字段*/
    public function update(){
        if (DataService::update($this->table)) {
            $this->success("数据操作成功！", '');
        }
        $this->error("数据操作失败，请稍候再试！");
    }

    public function edit(){
        return $this->_form(null,"form");
    }

    public function _edit_form_filter(){
        if($this->request->isGet()) {
            $id = input('id/d', 0);
            $courses = Db::name("AppCourse")
                ->where(['is_show' => 1, 'prom_type' => 0])
                ->whereOr(['prom_id' => $id])
                ->field('id,title,origin_price,thumb')
                ->select();
            $this->assign('courses', $courses);
        }
    }

    public function add(){
        $data = [];
        return $this->_form(null,"form","","",$data);
    }

    public function _add_form_filter(&$data){
        if($this->request->isGet()) {
            $courses= Db::name("AppCourse")
                ->where(['is_show'=>1,'prom_type'=>0])
                ->field('id,title,origin_price,thumb')
                ->select();
            $this->assign('courses',$courses);
        }else{
            if(!$data['thumb']){
                $this->error('请上传图片');
            }
            if(!$data['c_id']){
                $this->error('请选择参加活动课程');
            }
            if(!$data['type']){
                $this->error('请选择活动类型');
            }
            $start_time = strtotime($data['start_time']);
            $end_time = strtotime($data['end_time']);
            if($end_time < $start_time){
                $this->error('活动结束时间不能小于开始时间');
            }
            if($data['cut_min'] > $data['cut_max']){
                $this->error('砍价下限不能大于砍价上限');
            }
            $id = input('id/d',0);
            if(!$id){
                $data['created_time'] = date('Y-m-d H:i:s');
            }
            if($id){
                Db::name($this->table)->where(['id'=>$id])->update($data);
            }else{
                $id = Db::name($this->table)->insertGetId($data);
            }
            //更改课程类型
            Db::name('app_course')->where(['prom_id'=>$id])->update(['prom_type'=>0,'prom_id'=>0]);
            Db::name('app_course')->where(['id'=>$data['c_id']])->update(['prom_type'=>$data['type'],'prom_id'=>$id]);
            $this->success('操作成功！','');
            return false;

        }
    }

    public function _form_filter(&$data){

    }

    public function del(){
        $ids = input('id');
        if(DataService::update($this->table)){
            //修改课程类型
            Db::name('app_course')->where(['prom_id'=>['in',$ids]])->update(['prom_type'=>0,'prom_id'=>0]);
            $this->success('删除成功！','');
        }
        $this->error('删除失败！');
    }


}