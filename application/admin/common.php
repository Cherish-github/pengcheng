<?php
/**
 * 业务逻辑函数库
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2017/9/27
 * Time: 9:03
 */
use think\Db;
/**
 *  获取商品分类树
 * @param $cat_id
 * @param $cat_pid
 * @param $cat_ppid
 * @return string
 */
function getGoodsCatePath($cat_id,$cat_pid,$cat_ppid){
    $table = "WebGoodsCategory";
    $cate = Db::name($table)->where("id",$cat_id)->value("name");
    $pcate = Db::name($table)->where("id",$cat_pid)->value("name");
    $ppcate = Db::name($table)->where("id",$cat_ppid)->value("name");
    return $ppcate."-".$pcate."-".$cate;
}

/**
 * 获取某一规格的所有值
 * @param $spec_id int 规格ID
 * @return string|null
 */
function getSpecificationItem($spec_id){
    $table = "WebSpecItem";
    $items = Db::name($table)->where("spec_id",$spec_id)->field("GROUP_CONCAT(item SEPARATOR '\\n') as c ")->order("id asc")->find();
    if(empty($items["c"])){
        return null;
    }
    return $items["c"];
}

function roomOrderStatus($status)
{
    $s = [-1=>'取消订单',0=>'待支付',1=>'待入住',2=>'待完成',3=>'已完成'];
    return $s[$status];
}

function goodsOrderStatus($status)
{
    $s = [-1=>'取消订单',0=>'待支付',1=>'待用餐',2=>'已完成',];
    return $s[$status];
}

