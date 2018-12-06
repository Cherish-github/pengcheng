$(document).ready(function () {
    layui.use('layer', function() {
        var layer = layui.layer;
    })
    var pay_flag = false;

    $('.pay').on('click',function () {
        var date = $.trim($('#endTime').text());
        var time = $.trim($('#endTime2').text());
        var username = $.trim($('input[name=username]').val());
        var people = parseInt($('input[name=people]').val());
        var phone = $('input[name=phone]').val();
        var uc_id = $('input[name=uc_id]').val();
        var remark = $.trim($('textarea[name=remark]').val());
        var date_regx = /^\d{4}[-]\d{2}[-]\d{2}$/;
        var time_regx = /^\d{2}[:]\d{2}$/;
        var phone_regx = /^1[3456789]\d{9}$/;
        if (!date_regx.test(date)){
            console.log(date);
            layer.msg('请填写用餐日期');
            return ;
        }
        if (!time_regx.test(time)){
            console.log(time);
            layer.msg('请填写用餐时间');
            return ;
        }

        if (!people || people<1 || people>10){
            layer.msg('用餐人数应在1到10人之间');
            return ;
        }
        if (!username){
            layer.msg('请填写联系人姓名');
            return ;
        }
        if (username.length>10){
            layer.msg('联系人姓名长度不能超过10个字符');
            return ;
        }
        if (!phone_regx.test(phone)) {
            layer.msg('请填写正确格式的手机号');
            return ;
        }
        
        var data = {
            date: date,
            time: time,
            username: username,
            people: people,
            phone: phone,
            uc_id: uc_id,
            remark: remark
        };
        console.log(data);
        // layer.msg('订单提交成功');
        var url = '/api/goodsorder/submitOrder';
        // return;
        if (pay_flag){
            layer.msg('提交中请等待');
            return false;
        }
        $.post(url,data,function (response) {
            if (response.code==200){
                $.post('/api/goodsorder/pay',{order_id:response.data},function (resp) {
                    if (resp.code==201){
                        // 调起支付
                        WeixinJSBridge.invoke('getBrandWCPayRequest',{
                            "appId" : resp.data.appId, //公众号名称，由商户传入
                            "timeStamp": resp.data.timeStamp, //时间戳，自1970 年以来的秒数
                            "nonceStr" : resp.data.nonceStr, //随机串
                            "package" : resp.data.package,
                            "signType" : resp.data.signType, //微信签名方式:
                            "paySign" : resp.data.paySign //微信签名
                        },function(res){
                            // console.log(res.errMsg);
                            location.href = '/index/user/goodsorder';
                            sub_flag = false;
                        });
                    } else{
                        sub_flag = false;
                        layer.msg(resp.msg);
                        return false;
                    }
                },'json')
            }else{
                sub_flag = false;
                layer.msg(response.msg);
                return false;
            }
        },'json')
    })
})