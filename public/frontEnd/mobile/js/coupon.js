$(document).ready(function () {
    layui.use('layer', function() {
        var layer = layui.layer;
    })
    // console.log(way);
    var span = '<span class="coucon-sp1 fs24 cf tc get">领取</span>';
    getCouponList('/api/user/noGetCoupon',span);
})
$('.coutop ul li span').on('click',function () {
    if ($(this).hasClass('on')) {
        return;
    }
    $(this).addClass('on').parent().siblings().find("span").removeClass('on');
    var type = $(this).data('type');
    var url = '';
    var span = '';
    if (type==1){            //待领取
        url = '/api/user/noGetCoupon';
        span = '<span class="coucon-sp1 fs24 cf tc get">领取</span>';
    }else if (type==2){     //待使用
        url = '/api/user/noUsedCoupon';
        span = '<span class="coucon-sp1 fs24 cf tc use">去使用</span>';
    }else if (type==3){     //已使用
        url = '/api/user/usedCoupon';
        span = '<span class="coucon-sp2 fs24 cf tc">已使用</span>';
    }else if(type==4){      //已过期
        url = '/api/user/expiredCoupon';
        span = '<span class="coucon-sp2 fs24 cf tc">已过期</span>';
    }else{
        return ;
    }
    
    if (url){
        getCouponList(url,span);
    } 
})


function getCouponList(url,span) {
    $.get(url,{},function (response) {
        if (response.code == 200){
            var list = response.data;
            // console.log(list);
            var div = '';
            for (var i in list){
                div += '<div class="coucon1 disrow">' +
                    '        <div class="coucon11 fs28 hong tc">￥<span class="fs49 fw7">'+list[i]['cut_price']+'</span></div>' +
                    '        <div class="coucon12">' +
                    '            <div class="coucon12-1 fs28 c3">'+list[i]['title']+'</div>' +
                    '            <div class="coucon12-1 fs24 c6">有效期：'+list[i]['deadline_date']+'</div>' +
                    '        </div>' +
                    '        <div class="coucon13" data-id="'+list[i]['id']+'">'+span+'</div>' +
                    '    </div>'
            }
            $('.coucon').html(div);

            $('.get').on('click',function () {
                var id = $(this).parent().data('id');
                getCoupon(id);
            });

            $('.use').on('click',function () {
                var id = $(this).parent().data('id');
                if (way==1){
                    location.href = '/index/order/goods?uc_id='+id;
                } else if (way==2){
                    location.href = '/index/order/room?uc_id='+id+'&id='+room_id;
                } else{
                    location.href = '/index/room/index';
                }

            })
        }
    })
}

function getCoupon(coupon_id) {
    var url = '/api/user/getCoupon';
    var data = {id:coupon_id};
    $.get(url,data,function (response) {
        if (response.code==200){
            layer.msg('领取成功',{time:1000},function () {
                location.href = '/index/user/coupon';
            });
        }else {
            layer.msg(response.msg);
        }
    })
}