<?php
/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2017/8/9
 * Time: 15:01
 */
namespace app\admin\Controller;
use controller\BasicAdmin;
use think\Db;
use service\DataService;
use app\admin\Model;
use think\Request;
use think\Validate;

class Membercard extends BasicAdmin{
    public  $table = "AppMemberCard";
    public function index(){
        // 设置页面标题
        $this->title = '会员设置管理';
        // 实例Query对象
        $db = Db::name($this->table);
        return parent::_list($db);
    }

    /**
     * 添加
     * @return array|string
     */
    public function add(){
        return $this->_form($this->table, 'form','','');
    }

    /**
     * 删除常态内容
     */
    public function del(){
        $id = input("post.id");
        $data = Db::name($this->table)->where("id","in",$id)->field("content")->select();
        if(!$data)$this->error("你要删除的数据不存在！");
        foreach($data as $item) {
            $arr = array();
            preg_match('@/ueditor/php/upload/image/[\w\W]+.(jpg|jpeg|gif|png)@U', $item["content"], $arr);
            if (!empty($arr)) {
                foreach ($arr as $img) {
                    @unlink(ROOT . $img);
                    @rmdir(dirname(ROOT . $img));
                }
            }
        }
        if(Db::name($this->table)->where("id","IN",$id)->delete()){
            $this->success("常态内容删除成功","");
        }else{
            $this->error("常态内容删除失败，请稍候再试！");
        }
    }

    /**
     * 编辑常态内容
     */
    public function edit(){
        return $this->_form($this->table, 'form');
    }

    /**
     * 数据过滤
     */
    public function _form_filter($data){

    }


}