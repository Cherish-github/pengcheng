$(document).ready(function () {
    $('.cancel').on('click',function () {
        var id = $(this).data('id');
        layer.confirm('确认取消订单吗?',
            function(index){
                layer.close(index);
                var url = '/api/goodsorder/cancelOrder';
                var data = {id:id};
                $.get(url,data,function (response) {
                    if (response.code==200){
                        layer.msg('订单取消成功',{time:1000},function () {
                            location.href = '/index/user/eatOrder';
                        });
                    }else {
                        layer.msg(response.msg);
                    }
                })
            }
        );
    })

    var pay_flag = false;
    $('.pay').on('click',function () {
        var id = $(this).parent('.disrow').data('id');
        if (pay_flag){
            layer.msg('调起支付中');
            return false;
        }
        $.post('/api/roomorder/pay',{order_id:id},function (resp) {
            if (resp.code==201) {
                // 调起支付
                WeixinJSBridge.invoke('getBrandWCPayRequest',{
                    "appId" : resp.data.appId, //公众号名称，由商户传入
                    "timeStamp": resp.data.timeStamp, //时间戳，自1970 年以来的秒数
                    "nonceStr" : resp.data.nonceStr, //随机串
                    "package" : resp.data.package,
                    "signType" : resp.data.signType, //微信签名方式:
                    "paySign" : resp.data.paySign //微信签名
                },function(res){
                    layer.msg(res);
                    // location.href = '/index/user/roomOrderDetail?id='+id;
                    sub_flag = false;
                });
            } else{
                sub_flag = false;
                layer.msg(resp.msg);
                return false;
            }

        },'json')
    })

    $('.del').on('click',function () {
        var id = $(this).parent('.disrow').data('id');
        layer.confirm('确认删除订单吗?',
            function(index){
                layer.close(index);

                var url = '/api/roomorder/delOrder';
                var data = {id:id};
                $.get(url,data,function (response) {
                    if (response.code==200){
                        layer.msg('订单删除成功',{time:1000},function () {
                            location.href = '/index/user/roomOrder';
                        });
                    }else {
                        layer.msg(response.msg);
                    }
                })
            }
        );
    })

    $('.again').on('click',function () {
        var id = $(this).parent('.disrow').data('id');
        location.href = '/index/order/room?id='+id;
    })
})