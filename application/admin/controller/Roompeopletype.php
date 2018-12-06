<?php

/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/9
 * Time: 9:24
 */

namespace app\admin\controller;
use controller\BasicAdmin;
use service\DataService;
use think\Db;

class Roompeopletype extends BasicAdmin
{
    public $table = 'AppRoomPeopleType';
    public $title = '房间分类--按大小';
    public function index(){
        return parent::_list();
    }

    public function add(){
        return parent::_form(null,'form');
    }
    public function edit(){
        return parent::_form(null,'form');
    }

    /**
     * 控制隐藏和显示
     */
    public function hideAndShow(){
        if($this->request->post("value")){
            $msg = "显示";
        }else{
            $msg = "隐藏";
            //该分类下的课程也隐藏
            $id = input('post.id');
            Db::name('app_room')->where(['type_id'=>$id])->update(['is_show'=>0]);
        }

        if (DataService::update($this->table)) {
            $this->success("类型{$msg}成功！", '');
        }
        $this->error("类型{$msg}失败，请稍候再试！");
    }

    public function del(){
        $id = input('id');
        $res = Db::name('app_room')->field('group_concat(people_type_id) ids')->where(['people_type_id'=>['in',$id]])->find();
        $ids = implode(',',array_unique(explode(',',$res['ids'])));
        if($res && $res['ids'] != null){
            $this->error('ID为【'.$ids.'】下存在房间，不能删除');
        }
        if(DataService::update($this->table)){
            $this->success('删除成功！','');
        }
        $this->error('删除失败！');
    }
}