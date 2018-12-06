
layui.use('layer', function() {
    var layer = layui.layer;
})

$('input[name=username]').on('change',function (e) {
    console.log(e);
})

$('.info-btn').on('click',function (e) {
    console.log($('input[name=username]').val());
    console.log($('input[name=phone]').val());
    var username = $.trim($('input[name=username]').val());
    var phone = $('input[name=phone]').val();
    if (username.length==0 || phone.length==0){
        layer.msg('请将信息填写完整');
    }else {
        var regx = /^1[35678]\d{9}$/;
        var res = regx.test(phone);
        if (!res){
            layer.msg('手机号格式错误');
        }else{
            submitUserInfo(username,phone);
        }
    }
})

function submitUserInfo(name,phone) {
    var data = {name:name,phone:phone};
    $.post('/api/user/modifyUserInfo',data,function (response) {
        if (response.code == 200){
            layer.msg('修改成功',{time:1000},function () {
                // location.href = '/index/user/index';
                window.history.go(-1);
            });
        }
    })
}
