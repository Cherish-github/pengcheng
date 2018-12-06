// 当前资源URL目录
var baseUrl = (function () {
    var scripts = document.scripts, src = scripts[scripts.length - 1].src;
    return src.substring(0, src.lastIndexOf("/") + 1);
})();
// RequireJs 配置参数
require.config({
    waitSeconds: 0,
    baseUrl: baseUrl,
    map: {'*': {css: baseUrl + '../plugs/require/require.css.js'}},
    paths: {
        // 自定义插件（源码自创建或已修改源码）
        'admin.plugs': ['plugs'],
        'admin.listen': ['listen'],
        'layui': ['../plugs/layui/layui'],
        'ueditor': ['../plugs/ueditor/ueditor'],
        'template': ['../plugs/template/template'],
        'pcasunzips': ['../plugs/jquery/pcasunzips'],
        'laydate': ['../plugs/layui/laydate/laydate'],
        // 开源插件（未修改源码）
        'pace': ['../plugs/jquery/pace.min'],
        'json': ['../plugs/jquery/json2.min'],
        'citys': ['../plugs/jquery/jquery.citys'],
        'print': ['../plugs/jquery/jquery.PrintArea'],
        'base64': ['../plugs/jquery/base64.min'],
        'jquery': ['../plugs/jquery/jquery.min'],
        'websocket': ['../plugs/socket/websocket'],
        'bootstrap': ['../plugs/bootstrap/js/bootstrap.min'],
        'jquery.ztree': ['../plugs/ztree/jquery.ztree.all.min'],
        'bootstrap.typeahead': ['../plugs/bootstrap/js/bootstrap3-typeahead.min'],
        'zeroclipboard': ['../plugs/ueditor/third-party/zeroclipboard/ZeroClipboard.min'],
        'jquery.cookies': ['../plugs/jquery/jquery.cookie'],
        'jquery.masonry': ['../plugs/jquery/masonry.min'],
        'ckeditor':[baseUrl+'../plugs/ckeditor/ckeditor'],
        'colpick':[baseUrl+'../plugs/colpick/colpick'],
        'multiselect':[baseUrl+'../plugs/multiselect/select2.min'],
    },
    shim: {
        'citys': {deps: ['jquery']},
        'layui': {deps: ['jquery']},
        'laydate': {deps: ['jquery']},
        'bootstrap': {deps: ['jquery']},
        'pcasunzips': {deps: ['jquery']},
        'jquery.cookies': {deps: ['jquery']},
        'jquery.masonry': {deps: ['jquery']},
        'admin.plugs': {deps: ['jquery', 'layui']},
        'bootstrap.typeahead': {deps: ['jquery', 'bootstrap']},
        'websocket': {deps: [baseUrl + '../plugs/socket/swfobject.min.js']},
        'admin.listen': {deps: ['jquery', 'jquery.cookies', 'admin.plugs']},
        'jquery.ztree': {deps: ['jquery', 'css!' + baseUrl + '../plugs/ztree/zTreeStyle/zTreeStyle.css']},
        'colpick': {deps: ['jquery', 'css!' + baseUrl + '../plugs/colpick/colpick.css']},
        'ckeditor':{deps:['jquery']},
        'multiselect':{deps:['jquery','css!' + baseUrl + '../plugs/multiselect/select2.min.css']},
    },
    deps: ['css!' + baseUrl + '../plugs/awesome/css/font-awesome.min.css'],
    // 开启debug模式，不缓存资源
    urlArgs: "ver=" + (new Date()).getTime()
});
window.WEB_SOCKET_SWF_LOCATION = baseUrl + "../plugs/socket/WebSocketMain.swf";
window.UEDITOR_HOME_URL = (window.ROOT_URL ? window.ROOT_URL + '/static/' : baseUrl) + 'plugs/ueditor/';
// UI框架初始化
require(['pace', 'jquery', 'layui', 'bootstrap', 'jquery.cookies'], function () {
    layui.config({dir: baseUrl + '../plugs/layui/'});
    layui.use(['layer', 'form'], function () {
        window.layer = layui.layer;
        window.form = layui.form;
        require(['admin.listen']);
    });
});
function in_array(search,array){
    if(!array instanceof Array)
    {
        return false;
    }
    for(var i=0;i<array.length;i++){
        if(search===array[i]){
            return true;
        }
    }
    return false;
}
function filterArr(arr){
    var array = [];
    for(var i=0;i<arr.length;i++){
        if(!(arr[i]==='')){
            array.push(arr[i]);
        }
    }
    return array;
}

function mergeArray(arr1, arr2){
    for (var i = 0 ; i < arr1.length ; i ++ ){
        for(var j = 0 ; j < arr2.length ; j ++ ){
            if (arr1[i] === arr2[j]){
                arr1.splice(i,1); //利用splice函数删除元素，从第i个位置，截取长度为1的元素
            }
        }
    }
    for(var i = 0; i <arr2.length; i++){
        arr1.push(arr2[i]);
    }
    return arr1;
}

function array_splice (search,arr) {
    for(var i=0;i<arr.length;i++){
        if(arr[i]===search){
            arr.splice(i,1);
        }
    }
}