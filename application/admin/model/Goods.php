<?php
/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2017/9/25
 * Time: 16:01
 */
namespace app\admin\model;
use think\model;
use think\Request;
use think\Db;
class Goods extends model
{
    /**
     * 删除商品分类
     */
    public function delCategory(){
        $ids =  Request::instance()->post("id/a");
        $count = $this->where("cat_id","in",$ids)->count();
        if($count>0){
            return ["code"=>400,"msg"=>"该分类有商品不能被删除"];
        }
        Db::name("WebGoodsCategory")->where("id","in",$ids)->delete();
        return ["code"=>200,"msg"=>"分类删除成功"];
    }

}