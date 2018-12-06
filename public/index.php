<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// [ 应用入口文件 ]
// 定义应用目录
defined('APP_NAME') OR define('APP_NAME','三牛犇科技CMS');
/* SESSION会话名称 */
session_name('s' . substr(md5(__FILE__), 0, 8));
define('APP_PATH', __DIR__ . '/../application/');
define('ROOT',getcwd());
define('WEB_ROOT',ROOT.DIRECTORY_SEPARATOR);
/* 定义Runtime运行目录 与application 同级 */
define('RUNTIME_PATH', __DIR__ . '/../runtime/');

define("UP_PATH",ROOT."/static/upload");//上传目录
// 加载框架引导文件
require __DIR__ . '/../thinkphp/start.php';
