<?php

// +----------------------------------------------------------------------
// | Think.Admin
// +----------------------------------------------------------------------
// | 版权所有 2014~2017 广州楚才信息科技有限公司 [ http://www.cuci.cc ]
// +----------------------------------------------------------------------
// | 官方网站: http://think.ctolog.com
// +----------------------------------------------------------------------
// | 开源协议 ( https://mit-license.org )
// +----------------------------------------------------------------------
// | github开源项目：https://github.com/zoujingli/Think.Admin
// +----------------------------------------------------------------------
use service\DataService;
use service\NodeService;
use Wechat\Loader;
use think\Db;
use think\Request;

/**
 * 打印输出数据到文件
 * @param mixed $data
 * @param bool $replace
 * @param string|null $pathname
 */
function p($data, $replace = false, $pathname = null)
{
    is_null($pathname) && $pathname = RUNTIME_PATH . date('Ymd') . '.txt';
    $str = (is_string($data) ? $data : (is_array($data) || is_object($data)) ? print_r($data, true) : var_export($data, true)) . "\n";
    $replace ? file_put_contents($pathname, $str) : file_put_contents($pathname, $str, FILE_APPEND);
}

/**
 * 获取微信操作对象
 * @param string $type
 * @return \Wechat\WechatReceive|\Wechat\WechatUser|\Wechat\WechatPay|\Wechat\WechatScript|\Wechat\WechatOauth|\Wechat\WechatMenu|\Wechat\WechatMedia
 */
function & load_wechat($type = '')
{
    static $wechat = [];
    $index = md5(strtolower($type));
    if (!isset($wechat[$index])) {
        $config = [
            'token'          => sysconf('wechat_token'),
            'appid'          => sysconf('wechat_appid'),
            'appsecret'      => sysconf('wechat_appsecret'),
            'encodingaeskey' => sysconf('wechat_encodingaeskey'),
            'mch_id'         => sysconf('wechat_mch_id'),
            'partnerkey'     => sysconf('wechat_partnerkey'),
            'ssl_cer'        => sysconf('wechat_cert_cert'),
            'ssl_key'        => sysconf('wechat_cert_key'),
            'cachepath'      => CACHE_PATH . 'wxpay' . DS,
        ];
        $wechat[$index] = Loader::get($type, $config);
    }
    return $wechat[$index];
}

/**
 * UTF8字符串加密
 * @param string $string
 * @return string
 */
function encode($string)
{
    $chars = '';
    $len = strlen($string = iconv('utf-8', 'gbk', $string));
    for ($i = 0; $i < $len; $i++) {
        $chars .= str_pad(base_convert(ord($string[$i]), 10, 36), 2, 0, 0);
    }
    return strtoupper($chars);
}

/**
 * UTF8字符串解密
 * @param string $string
 * @return string
 */
function decode($string)
{
    $chars = '';
    foreach (str_split($string, 2) as $char) {
        $chars .= chr(intval(base_convert($char, 36, 10)));
    }
    return iconv('gbk', 'utf-8', $chars);
}

/**
 * RBAC节点权限验证
 * @param string $node
 * @return bool
 */
function auth($node)
{
    return NodeService::checkAuthNode($node);
}

/**
 * 设备或配置系统参数
 * @param string $name 参数名称
 * @param bool $value 默认是false为获取值，否则为更新
 * @return string|bool
 */
function sysconf($name, $value = false)
{
    static $config = [];
    if ($value !== false) {
        $config = [];
        $data = ['name' => $name, 'value' => $value];
        return DataService::save('SystemConfig', $data, 'name');
    }
    if (empty($config)) {
        foreach (Db::name('SystemConfig')->select() as $vo) {
            $config[$vo['name']] = $vo['value'];
        }
    }
    return isset($config[$name]) ? $config[$name] : '';
}

/**
 * 数据表排序方式
 * @param $table string 数据表
 * @param $sort string 排序方式
 * @return $tableSorts array|bool
 */
function tableSort($table, $sort = false){
    static $tableSorts = [];
    if ($sort !== false) {
        $tableSorts = [];
        $data = ['table' => $table, 'sort' => $sort];
        return DataService::save('SystemSort', $data,"table");
    }
    if (empty($tableSorts)) {
        foreach (Db::name('SystemSort')->select() as $vo) {
            $tableSorts[$vo['table']] = $vo['sort'];
        }
    }
    return isset($tableSorts[$table]) ? $tableSorts[$table] : '';
}

/**
 * array_column 函数兼容
 */
if (!function_exists("array_column")) {

    function array_column(array &$rows, $column_key, $index_key = null)
    {
        $data = [];
        foreach ($rows as $row) {
            if (empty($index_key)) {
                $data[] = $row[$column_key];
            } else {
                $data[$row[$index_key]] = $row[$column_key];
            }
        }
        return $data;
    }

}

/**
 *
 * 字符截取
 * @param string $string
 * @param int $start
 * @param int $length
 * @param string $charset
 * @param string $dot
 *
 * @return string
 */
function str_cut(&$string, $start, $length, $charset = "utf-8", $dot = '...') {
    if(function_exists('mb_substr')) { //如果给定的函数已经被定义就返回 TRUE
        if(mb_strlen($string, $charset) > $length) {//获取字符串的长度
            return mb_substr ($string, $start, $length, $charset) . $dot;
        }
        return mb_substr ($string, $start, $length, $charset);

    }else if(function_exists('iconv_substr')) {
        if(iconv_strlen($string, $charset) > $length) {
            return iconv_substr($string, $start, $length, $charset) . $dot;
        }
        return iconv_substr($string, $start, $length, $charset);
    }

    $charset = strtolower($charset);
    switch ($charset) {
        case "utf-8" :
            preg_match_all("/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|\xe0[\xa0-\xbf][\x80-\xbf]|[\xe1-\xef][\x80-\xbf][\x80-\xbf]|\xf0[\x90-\xbf][\x80-\xbf][\x80-\xbf]|[\xf1-\xf7][\x80-\xbf][\x80-\xbf][\x80-\xbf]/", $string, $ar);
            if(func_num_args() >= 3) {
                if (count($ar[0]) > $length) {
                    return join("", array_slice($ar[0], $start, $length)) . $dot;
                }
                return join("", array_slice($ar[0], $start, $length));
            } else {
                return join("", array_slice($ar[0], $start));
            }
            break;
        default:
            $start = $start * 2;
            $length   = $length * 2;
            $strlen = strlen($string);
            for ( $i = 0; $i < $strlen; $i++ ) {
                if ( $i >= $start && $i < ( $start + $length ) ) {
                    if ( ord(substr($string, $i, 1)) > 129 ) $tmpstr .= substr($string, $i, 2);
                    else $tmpstr .= substr($string, $i, 1);
                }
                if ( ord(substr($string, $i, 1)) > 129 ) $i++;
            }
            if ( strlen($tmpstr) < $strlen ) $tmpstr .= $dot;

            return $tmpstr;
    }
}


// ##############################################################

function Iif($expression, $returntrue, $returnfalse = ''){
    if($expression){
        return $returntrue;
    }else{
        return $returnfalse;
    }
}
/////#$########################################################
function displayDate($date,$fmt="Y-m-d"){
    if($date){
        return date($fmt,$date);
    }
    return date($fmt,time());
}

/**
 * 过滤输入字符
 */
function filterString(&$query_string){
    if(is_string($query_string)){
        $query_string = htmlspecialchars(str_replace (array('\0', '　'), '', $query_string), ENT_QUOTES);
        $query_string = addslashes($query_string);
        return $query_string;
    }
}


/**
 * 求多个笛卡尔乘积
 */
function cartesianProduct($arr){
    $result = array_shift($arr);
    if($result && !count($arr)){//只有一个元素时
        $res = [];
        foreach($result as $k=>$v){
            $res[$k][] = $v;
        }
        return $res;
    }
    while($arr2 = array_shift($arr)){
        $arr1 = $result;
        $result = [];
        foreach($arr1 as $v){
            foreach($arr2 as $v2){
                is_array($v) || $v = [$v];
                is_array($v2)|| $v2 = [$v2];
                $result[] = array_merge_recursive($v,$v2);
            }
        }
    }

    return $result;
}

function filter($subject,$rule = ['\/','\\',':',"?",'#','$','%','^','&','*','`','!','+',';']){
    return str_replace($rule,'',$subject);
}

/**
 * 将远程路径转成本地路径
 */
function urlToSrc($url){
    if(strpos($url,'/static/upload/')===0){
        //如果是以/static/upload/开头
        return ROOT.$url;
    }
    $doman  = Request::instance()->domain();
    $doman  = preg_replace(["/http:\/\//",'/https:\/\//'],'',$doman);
    return  preg_replace(["@http://".$doman."@",'@https://'.$doman.'@'],ROOT,$url);
}

/**
 * 生成更安全的伪随机数
 * @param $len int 目标长度
 * @return string
 */
function rd_rand($sublen=128){
    $arr        = 'QWERTYUIOPASDFGHJKLZXCVBNM1234567890';
    $timestamp  = strval(time());
    $len        = strlen($arr)-1;
    $str        = '';
    $j          = 0;
    for($i=0;$i<$sublen;$i++){
        if($i%3==0 && $j<strlen($timestamp)){
            $rand = $timestamp[$j];
            $j++;
        }else {
            $rand = mt_rand(0, $len);
        }
        $str    .= $arr[$rand];
    }
    return $str;
}
/**
 * 格式化日期时间
 * @param $datetime
 * @return string
 */
function fmt_time($datetime){
    $timestamp  = strtotime($datetime);
    $current    = time();
    $diff       = $current    - $timestamp;
    if($diff>24*3600){
        //如果超过一天
        return $datetime;
    }
    $h      = floor($diff/3600);
    if($h==0){
        $i = intval($diff/60);
        if($i===0){
            return '刚刚';
        }
        return $i.'分钟前';
    }
    return $h."小时前";
}

function fmtPrice($float){
    if(($float*100)%100==0){
        return (int) $float;
    }
    return $float;
}

/**
 * 导出excel
 * @param $strTable 表格内容
 * @param $filename 文件名
 */
function downloadExcel($strTable,$filename)
{
    header("Content-type: application/vnd.ms-excel");
    header("Content-Type: application/force-download");
    header("Content-Disposition: attachment; filename=".$filename."_".date('Y-m-d').".xls");
    header('Expires:0');
    header('Pragma:public');
    echo '<html><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'.$strTable.'</html>';
}


function html($String) {
    return str_replace(array('&amp;','&#039;','&quot;','&lt;','&gt;'), array('&','\'','"','<','>'), $String);
}
