<?php
/**
 * Company: 深圳市三牛犇科技有限公司.
 * User: 小米飞刀
 * Date: 2018/4/16
 * Time: 15:46
 */
function diffTime($subtime){
    $currentDate    = time();
    $subtime        = strtotime($subtime);
    $day            = ceil(($subtime -$currentDate)/86400);
    return  $day>0 ? $day:0;
}
/**
 * 两个时间差
 */
function diffFmtTime($end_time,$start_time=''){
    $start_time = $start_time ? $start_time : time();
    $diff       = $end_time - $start_time;
    $day        = floor(($diff)/86400);
    $hour       = floor(($diff%86400)/3600);
    $min        = floor(($diff%86400)%3600/60);
    $sec        = ($diff%86400)%3600%60;
    return [
        'day'   => $day >0 ?$day:0,
        'hour'  => $hour >0 ? $hour:0,
        'min'   => $min >0 ?$min:0,
        'sec'   => $sec >0 ? $sec:0
    ];
}
function safeFilter($str){
    return str_replace(['!','#','$','%',':','\/','\\','~','^','&','*'],'',$str);
}

function sendSMS($phone,$sign_mode,$message,$sign='美技通'){
    $service = \service\SmsService::getInstance();
    $res = $service->sendSms($phone,$sign,$sign_mode,$message);
    return json_decode(json_encode($res),true);
}


