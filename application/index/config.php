<?php
$way = "/frontEnd/".(request()->isMobile()?'mobile/':'pc/');
return [
    // 默认输出类型
    'default_return_type'    => 'html',
    'tpl_cache' => false,
    'template'               => [
        // 模板引擎类型 支持 php think 支持扩展
        'type'         => 'Think',
        // 模板路径
        'view_path'    =>ROOT.$way,
        // 模板后缀
        'view_suffix'  => 'html',
        // 模板文件名分隔符
        'view_depr'    => DS,
        // 模板引擎普通标签开始标记
        'tpl_begin'    => '{',
        // 模板引擎普通标签结束标记
        'tpl_end'      => '}',
        // 标签库标签开始标记
        'taglib_begin' => '{',
        // 标签库标签结束标记
        'taglib_end'   => '}',
        'tpl_replace_string' => [
            '__STATIC__' => '/static',
            "__CSS__"=>$way."css",
            "__IMAGES__"=>$way."images",
            "__JS__"=>$way."js",
            "__PLUGS__"=>"/static/plugs",
        ],
    ],
    'TMPL_CACHE_ON'   => false,  // 默认开启模板编译缓存 false 的话每次都重新编译模板
    'ACTION_CACHE_ON'  => false,  // 默认关闭Action 缓存
    'HTML_CACHE_ON'   => false,   // 默认关闭静态缓存

];