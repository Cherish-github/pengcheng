$(function () {
    layui.use('layer', function() {
        var layer = layui.layer;
    })

    $('#firstSelect').on('click', function () {
        $('.mask_calendar').show();
    });
    $('.mask_calendar').on('click', function (e) {
        if (e.target.className == "mask_calendar") {
            $('.calendar').slideUp(200);
            $('.mask_calendar').fadeOut(200);
        }
    })
    $('#firstSelect').calendarSwitch({
        selectors: {
            sections: ".calendar"
        },
        index: 4,      //展示的月份个数
        animateFunction: "slideToggle",        //动画效果
        controlDay: true,//知否控制在daysnumber天之内，这个数值的设置前提是总显示天数大于90天
        daysnumber: "90",     //控制天数
        comeColor: "#eb4f4e",       //入住颜色
        outColor: "#f00",      //离店颜色
        comeoutColor: "#F48389",        //入住和离店之间的颜色
        callback: function () {
            $('.mask_calendar').fadeOut(200);
            var startDate = $('#startDate').val();  //入住的天数
            var endDate = $('#endDate').val();      //离店的天数
            var NumDate = $('.NumDate').text();    //共多少晚
            if (NumDate == '' || undefined || null) {
                $('.NumDate').text(1);
            }
            //console.log(NumDate);
            setTotal();   //实时计算总费用
            //下面做ajax请求
            //show_loading();
            /*$.post("demo.php",{startDate:startDate, endDate:endDate, NumDate:NumDate},function(data){
                if(data.result==1){
                    //成功
                } else {
                    //失败
                }
            });*/
        },
        comfireBtn: '.comfire'//确定按钮的class或者id
    });
    var b = new Date();
    var ye = b.getFullYear();
    var mo = b.getMonth() + 1;
    mo = mo < 10 ? "0" + mo : mo;
    var da = b.getDate();
    da = da < 10 ? "0" + da : da;
    $('#startDate').val(ye + '-' + mo + '-' + da);
    b = new Date(b.getTime() + 24 * 3600 * 1000);
    var ye = b.getFullYear();
    var mo = b.getMonth() + 1;
    mo = mo < 10 ? "0" + mo : mo;
    var da = b.getDate();
    da = da < 10 ? "0" + da : da;
    $('#endDate').val(ye + '-' + mo + '-' + da);

    // 数量加减
    $(".add").click(function () {
        var t = $(this).parent().find('input[class*=text_box]');
        if (t.val() == "" || undefined || null) {
            t.val(1);
        }
        var re = parseInt(t.val()) + 1;
        if (re > left_num) {
            layer.msg('剩余房间数量不足');
            return;
        }else{
            t.val(re);
            setTotal();
        }
    })
    $(".min").click(function () {
        var t = $(this).parent().find('input[class*=text_box]');
        if (t.val() == "" || undefined || null) {
            t.val(1);
        }
        t.val(parseInt(t.val()) - 1)
        if (parseInt(t.val()) <= 0) {
            t.val(1);
        }
        setTotal();
    })
    $(".text_box").keyup(function () {
        var t = $(this).parent().find('input[class*=text_box]');
        if (parseInt(t.val()) == "" || undefined || null || isNaN(t.val())) {
            t.val(1);
        }
        setTotal();
    })



    setTotal();



    //下单支付
    $('.pay').on('click',function () {
        var room_id = $('input[name=room_id]').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();
        var username = $.trim($('input[name=username]').val());
        var num = parseInt($('input[name=num]').val());
        var phone = $('input[name=phone]').val();
        var uc_id = $('input[name=uc_id]').val();
        var regx = /^1[3456789]\d{9}$/;
        if (!startDate){
            layer.msg('请填写入住日期');
            return ;
        }
        if (!endDate){
            layer.msg('请填写离店日期');
            return ;
        }
        if (!num){
            num = 1;
        }
        if (!username){
            layer.msg('请填写联系人姓名');
            return ;
        }
        if (username.length>10){
            layer.msg('联系人姓名长度不能超过10个字符');
            return ;
        }
        if (!regx.test(phone)) {
            layer.msg('请填写正确格式的手机号');
            return ;
        }

        var data = {
            room_id: room_id,
            start_date: startDate,
            left_date: endDate,
            name: username,
            num: num,
            phone: phone,
            uc_id: uc_id
        };
        console.log(data);
        // layer.msg('订单提交成功');
        // return ;
        submitOrder(data);
    })
});
function setTotal() {
    var s = 0;
    // $("#tab td").each(function () {
    var yw = $(".NumDate").text();
    if (yw == '' || undefined || null) {
        yw = 1
    }
    var t = $('input[class*=text_box]').val();
    //var p = $(this).find('span[class*=price]').text();
    if (parseInt(t) == "" || undefined || null || isNaN(t) || isNaN(parseInt(t))) {
        t = 1;
    }
    s += parseInt(t) * room_price * parseInt(yw);
    //});
    $("#total").html(s.toFixed(2));
}

var pay_flag = false;

//提交订单
function submitOrder(data) {
    var url = '/api/roomorder/submitOrder';
    if (pay_flag){
        layer.msg('提交中请等待');
        return false;
    }
    $.post(url,data,function (response) {
        if (response.code==200){
            $.post('/api/roomorder/pay',{order_id:response.data},function (resp) {
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
                        location.href = '/index/user/roomOrderDetail?id='+response.data;
                        sub_flag = false;
                        // if(res.err_msg == "get_brand_wcpay_request:ok" ) {
                        //     location.href = '/index/user/roomOrderDetail?id='+response.data;
                        //     sub_flag = false;
                        // }else{
                        //     location.href = '/index/user/roomOrderDetail?id='+response.data;
                        //     sub_flag = false;
                        // }
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
}

