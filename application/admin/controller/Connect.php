<?php
/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2017/8/7
 * Time: 17:31
 */
namespace app\admin\Controller;
use controller\BasicAdmin;
use think\Db;
use service\DataService;
use app\admin\Model;
class Connect extends BasicAdmin{
    public  $table = "WebConnect";
    public function index(){
        // 设置页面标题
        $this->title = '联系我们';
        // 获取到所有GET参数
        $get = $this->request->get();
        // 实例Query对象
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
        $this->assign("orderSort",$order);

        return parent::_list($db);
    }

    /**
     * 添加
     * @return array|string
     */
    public function add(){
        $data = array();
        if($this->request->post()){
            $data["update_time"] = time();
        }else{
            $data["is_show"]  = 1;
        }
        return $this->_form($this->table, 'form',null,null,$data);
    }

    /**
     * 控制隐藏和显示
     */
    public function hideAndShow(){
        if($this->request->post("value")){
            $msg = "显示";
        }else{
            $msg = "隐藏";
        }
        if (DataService::update($this->table)) {
            $this->success("联系{$msg}成功！", '');
        }
        $this->error("联系{$msg}失败，请稍候再试！");
    }



    /**
     * 删除联系
     */
    public function del(){
        $model = model($this->table);
        if($model->del($this->request->post("id"))){
            $this->success("联系删除成功","");
        }else{
            $this->error("联系删除失败，请稍候再试！");
        }
    }

    /**
     * 编辑联系
     */
    public function edit(){
        $data["update_time"] = time();
        return $this->_form($this->table, 'form',null,null,$data);
    }

    public function _form_filter($data){
        if($this->request->isPost()) {
            if (!$data["filename"]) {
                $this->error("请上传图片！");
            }
        }
        return true;
    }



}