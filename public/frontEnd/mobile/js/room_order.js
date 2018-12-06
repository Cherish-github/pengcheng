$(document).ready(function () {
    layui.use('layer', function() {
        var layer = layui.layer;
    })
    getOrderList();
})

$('.roomtop1').on('click',function () {
    if ($(this).hasClass('roomon')) {
        return;
    }
    $(this).addClass('roomon').siblings().removeClass('roomon');
    getOrderList();
})

/**
 * 获取订单列表
 * @param type   0:待付款，1待入住，2待离店，3待完成
 */
function getOrderList() {
    $('.roomcon').html('');
    layui.use('flow', function() {
        var flow = layui.flow;
        flow.load({
            elem: '.roomcon' //指定列表容器
            , done: function (page, next) { //到达临界点（默认滚动触发），触发下一页
                var lis = [];
                var url = '/api/roomorder/getList';
                var type = $('.roomon').data('type');
                var data = {status: type,page:page};
                $.get(url, data, function (response) {
                    if (response.code == 200) {
                        console.log(response);
                        var list = response.data;
                        var text = '';
                        var event = '';
                        if (type == 0) {
                            text = '待付款';
                            event = '<div class="roomcon1-7 fs24 cf tc pay">去付款</div>';
                        } else if (type == 1) {
                            text = '待入住';
                            event = '';
                        } else if (type == 2) {
                            text = '待离店';
                            event = '';
                        } else {
                            text = '已完成';
                            event = '<div class="roomcon1-9 fs24 c9 tc delete">删除订单</div>' +
                                '<div class="roomcon1-9 fs24 c9 tc again">再订一次</div>';
                        }
                        layui.each(list,function(i, item){
                            var div = '';
                            div += '<div class="roomcon1 mt40">' +
                                '       <a href="/index/user/roomOrderDetail?id=' + list[i]['id'] + '">' +
                                '            <div class="roomcon1-1 disrow disju-sb">' +
                                '                <div class="roomcon1-2 fs28 c3 fw7">订单号  ' + list[i]['order_no'] + '</div>' +
                                '                <div class="roomcon1-2 fs28 hong fw7">' + text + '</div>' +
                                '            </div>' +
                                '            <div class="roomcon1-3 disrow disju-sb">' +
                                '                <div class="roomcon1-4 fs28 c3"><img src="/frontEnd/mobile/images/icon_df_ckdd.png"/>' + list[i]['title'] + '</div>' +
                                '                <div class="roomcon1-8 fs28 c6">' + list[i]['num'] + '间</div>' +
                                '            </div>' +
                                '            <div class="roomcon1-5 disrow disju-sb">' +
                                '                <div class="roomcon1-4 fs28 c6">' +
                                '                    <img src="/frontEnd/mobile/images/icon_rili.png"/>入住:<span>' + list[i]['start_date'] + '</span> 离店:<span>' + list[i]['left_date'] + '</span></div>' +
                                '                <div class="roomcon1-8 fs28 c6">共' + list[i]['day'] + '晚</div>' +
                                '            </div>' +
                                '         </a>' +
                                '         <div class="roomcon1-6 disrow disju-sb">' +
                                '             <div class="roomcon1-2 fs36 hong fw7">￥' + list[i]['sum'] + '   </div>' +
                                '             <div class="disrow" data-id="' + list[i]['id'] + '">' +
                                event +
                                '             </div>' +
                                '         </div>' +
                                '   </div>';
                            lis.push(div);
                        });

                        //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                        //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                        next(lis.join(''), page < response.pages);

                        var pay_flag = false;
                        $('.pay').on('click', function () {
                            var id = $(this).parent().data('id');
                            console.log(id);
                            if (pay_flag) {
                                layer.msg('调起支付中');
                                return false;
                            }
                            $.post('/api/roomorder/pay', {order_id: id}, function (resp) {
                                if (resp.code == 201) {
                                    // 调起支付
                                    WeixinJSBridge.invoke('getBrandWCPayRequest', {
                                        "appId": resp.data.appId, //公众号名称，由商户传入
                                        "timeStamp": resp.data.timeStamp, //时间戳，自1970 年以来的秒数
                                        "nonceStr": resp.data.nonceStr, //随机串
                                        "package": resp.data.package,
                                        "signType": resp.data.signType, //微信签名方式:
                                        "paySign": resp.data.paySign //微信签名
                                    }, function (res) {
                                        location.href = '/index/user/roomOrderDetail?id=' + id;
                                        sub_flag = false;
                                    });
                                } else {
                                    sub_flag = false;
                                    layer.msg(resp.msg);
                                    return false;
                                }

                            }, 'json')
                        })

                        $('.delete').on('click', function () {
                            var id = $(this).parent().data('id');
                            console.log(id);
                            layer.confirm('确认删除订单吗?',
                                function (index) {
                                    layer.close(index);
                                    deleteOrder(id);
                                }
                            );

                        })

                        $('.again').on('click', function () {
                            var id = $(this).parent().data('id');
                            console.log(id);
                            location.href = '/index/order/room?id=' + id;
                        })
                    } else {
                        layer.msg(response.msg);
                    }
                },'json')
            }
        });
    });
}

/**
 * 删除订单
 * @param order_id
 */
function deleteOrder(order_id) {
    var url = '/api/roomorder/delOrder';
    var data = {id:order_id};
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
