$(function () {
    $('.menu-ul li').eq(0).addClass('active');

    //设置高度
    var H = window.innerHeight;
    var i = H - 110
    $('.dinner').css('height', i + 'px');
    $('.dinnerl').css('height', i + 'px');
    $('.dinnerr').css('height', i + 'px');

    //清空购物车
    $(".cart-top2").on('click',function(){
        $("#goods div").remove();
        $("#totalcountshow").html(0);
        $("#totalpriceshow").html(0);
        $(".dinnerr1-7").prev().css("display", "none");
        $(".dinnerr1-7").css("display", "none");
        $(".dinnerr1-7").html(0);
        $('.dinnerl li i').hide();
        $('.dinnerl li i').html(0);
        isshow();
        clearCart();
    })

    //加的效果
    $(".add").click(function () {
        $(this).prevAll().css("display", "block");
        var p =$(this).parents('.dinnerr')
        var n = $(this).prev().text();
        var num = parseInt(n) + 1;
        if (num == 0) {
            return;
        }
        $(this).prev().text(num);
        var jianum = $(this).prev().text();

        var danjia = $(this).next().text();//获取单价
        var a = $("#totalpriceshow").html();//获取当前所选总价
        $("#totalpriceshow").html((a * 1 + danjia * 1).toFixed(2));//计算当前所选总价


        var nm = $("#totalcountshow").html();//获取数量
        $("#totalcountshow").html(nm * 1 + 1);

        var ii = $(this).parents('.dinnerr').index();
        left_i_show(ii,1,1);
        jss();//  改变按钮样式

        addcart(this);

        var id = $(this).parents('.dinnerr1').attr('id');
        addCart(id);
    });
    //减的效果
    $(".minus").click(function () {
        var n = $(this).next().text();
        var num = parseInt(n) - 1;

        $(this).next().text(num);//减1

        var danjia = $(this).nextAll(".price").text();//获取单价
        var a = $("#totalpriceshow").html();//获取当前所选总价
        $("#totalpriceshow").html((a * 1 - danjia * 1).toFixed(2));//计算当前所选总价

        var nm = $("#totalcountshow").html();//获取数量
        $("#totalcountshow").html(nm * 1 - 1);

        //$(".dinnerr1-77").html(nm * 1 - 1);

        //如果数量小于或等于0则隐藏减号和数量
        var i = $(this).parents('.dinnerr').index();

        var ii = $(this).parents('.dinnerr1').attr('id');
        left_i_show(i,2,1);
        shopcart_show(ii,2,1);

        var id = $(this).parents('.dinnerr1').attr('id');
        desCart(id);

        if (num <= 0) {
            $(this).next().css("display", "none");
            $(this).css("display", "none");
            jss();//改变按钮样式
            return
        }

    });

    //选项卡
    $(".con>div").hide();
    $(".con>div:eq(0)").show();

    $(".left-menu li").click(function () {
        $(this).addClass("active").siblings().removeClass("active");
        var n = $(".left-menu li").index(this);
        $(".con>div").hide();
        $(".con>div:eq(" + n + ")").show();
    });

    //购物车
    $('.gocart').on('click',function(){
        isshow()
        $('.mask').fadeIn();
        $('.cart').fadeIn();
    })
    $('.guanbi').on('click',function(){
        $('.mask').fadeOut();
        $('.cart').fadeOut();
    })
    //飞入cart
    var offset = $("#end").offset();
    $(".addcar").click(function(event){
        var addcar = $(this);
        //var img = addcar.parent().find('img').attr('src');
        var img = addcar.find('img').attr('src');
        var flyer = $('<img class="u-flyer" src="'+img+'">');
        flyer.fly({
            start: {
                left: event.pageX, //开始位置（必填）#fly元素会被设置成position: fixed
                top: event.pageY, //开始位置（必填）
            },
            end: {
                left: offset.left+10, //结束位置（必填）
                top: offset.top+10, //结束位置（必填）
                width: 0, //结束时宽度
                height: 0 //结束时高度
            },
            onEnd: function(){ //结束回调
                //$("#msg").show().animate({width: '250px'}, 200).fadeOut(1000); //提示信息
                //addcar.css("cursor","default").removeClass('orange').unbind('click');
            }
        });
    });

})
//购物车数据变化
function shopcart_show(index,type,num){
    // var cnum = parseInt($('.cart-con1').eq(index).children('.dinnerr1-5').children('.dinnerr1-77').html());
    var cnum = parseInt($('#goods #'+index).find('.dinnerr1-77').html());
    if(type == 2){
        cnum -= num;
    }else{
        cnum += num;
    }
    $('#goods #'+index).find('.dinnerr1-77').html(cnum);
    // $('.cart-con1').eq(index).children('.dinnerr1-5').children('.dinnerr1-77').html(cnum);
    if(cnum <= 0){
        $('#goods #'+index).remove();
        // $('.cart-con1').eq(index).remove();
    }
}
//分类上、所选数量
function left_i_show(index,type,num){
    var leftnum = parseInt($('.menu-ul li').eq(index).children('i').html());
    if(type == 2){
        leftnum -= num;
    }else{
        leftnum += num;
    }
    $('.menu-ul li').eq(index).children('i').html(leftnum);
    if(leftnum > 0){
        $('.dinnerl li i').eq(index).show();
    }else{
        $('.dinnerl li i').eq(index).hide();
    }
}
//下单按钮切换样式
function jss() {
    var m = $("#totalcountshow").html();
    if (m > 0) {
        $(".right").find("a").removeClass("disable");
    } else {
        $(".right").find("a").addClass("disable");
    }
};
// var cart = [];
// function searchCart(id){
//     for(var i=0;i<cart.length;i++){
//         if(cart[i].id == id){
//             return true;
//         }
//     }
//     return false;
// }
//
// function pushCart(id,num,index,name,price) {
//     cart.push({id:id,num:num,index:index,name:name,price:price});
// }
// function spliceCart(id,index) {
//     cart.splice(index,1);
// }
//加数据
// function changeCartNum(id,num) {
//     for(var i=0;i<cart.length;i++){
//         if(cart[i].id == id){
//             cart[i].num  = num;
//         }
//     }
// }
//加到购物车
function addcart(btn){
    var $tds = $(btn).parents('.dinnerr1-2').children();
    //$tds.eq(0)是jQuery对象  $tds[0]是DOM对象
    var name = $tds.eq(0).children().html();//string
    var price = $tds.eq(1).children(1).children('i').html();//string
    var num = $tds.eq(1).children().children('.dinnerr1-7').html();
    //console.log(num);
    var index = $tds.eq(0).parent().parent('.dinnerr1').index();
    var id = $(btn).parents('.dinnerr1').attr('id');
    var allprice = $tds.eq(1).children('.allprice').html();
    // if(!searchCart(id)){
    //     pushCart(id,num,index,name,price);
    // }else{
    //     changeCartNum(id,num);
    // }
    //console.log(cart);
    //在添加之前确定该商品在购物车中是否存在,若存在,则数量+1,若不存在则创建行
    var $trs = $("#goods>div");
    for (var i = 0; i < $trs.length; i++) {
        var $gtds = $trs.eq(i).children();
        // var gName = $gtds.eq(0).html();
        var gId = $trs.eq(i).attr('id');
        if (id == gId) {        //若存在
            var num = parseInt($gtds.eq(2).children().eq(1).html());
            $gtds.eq(2).children().eq(1).html(++num);//数量+1
            //金额从新计算
            //$gtds.eq(3).html(price * num);
            return;//后面代码不再执行
        }
    }
    //若不存在,创建后追加
    var li =
        "<div id='"+id+"' class='cart-con1 disrow'>"+
        "<div class='cart-con2 fs26 c3 fw7'>"+ name +"</div>"+
        "<div class='cart-con3 fs26 hong'>"+'￥'+"<span>"+ price +"</span>"+"</div>"+
        "<div class='dinnerr1-5 disrow disju-c'>"+
        "<div class='dinnerr1-66' onclick='decrease(this,"+id+","+index+");'>"+"<img src='/frontEnd/mobile/images/icon_jians_jj.png'/>"+"</div>"+
        "<div class='dinnerr1-77 fs32 c3 tc'>"+ num + "</div>"+
        "<div class='dinnerr1-8' onclick='increase(this,"+id+","+index+");'>"+"<img src='/frontEnd/mobile/images/icon_jia_jj.png'/>"+"</div>"+
        "<i class='price'' style='display: none;'>"+price+"</i>"+
        "</div>"+
        "</div>";
    //追加到#goods后面
    $("#goods").append($(li));

}

//购物车增加"+"功能
function increase(btn,id,index) {
    //购物车数据改变
    var $td = $(btn).prev();
    var num = parseInt($td.html());//number
    //num此时为number类型(在计算时会自动转换为number类型)
    $td.html(++num);
    var jianum = parseInt($td.html());
    // console.log($('div[id='+id+'].dinnerr1'));
    var length = $('div[id='+id+'].dinnerr1').length;
    //判断热门推荐和其他分类是否商品重叠
    if (length > 1){
        var goods_num_div = $('div[id='+id+'].dinnerr1').eq(1).find('.dinnerr1-7');
    } else {
        var goods_num_div = $('div[id='+id+'].dinnerr1').eq(0).find('.dinnerr1-7');
    }
    var goods_num = goods_num_div.html();
    if (goods_num==0){
        goods_num_div.prev().css("display", "block");
        goods_num_div.css("display", "block");
    }

    goods_num_div.html(++goods_num);

    // $("#"+id+" .dinnerr1-7").html(jianum);

    var nm = $("#totalcountshow").html();//获取数量
    $("#totalcountshow").html(nm * 1 + 1);

    var ii =  goods_num_div.parents('.dinnerr').index();
    left_i_show(ii,1,1);

    //获取单价,再加计算前要先转换为number类型
    var price = $(btn).parent().prev().children('span').html();
    var zong = $("#totalpriceshow").html();
    $("#totalpriceshow").html((zong * 1 + price * 1).toFixed(2));

    //api添加数据
    addCart(id);
}
//购物车减少"-"功能
function decrease(btn,id,index) {
    //获取单价和当前总价
    var price = $(btn).parent().prev().children('span').html();
    var zong = $("#totalpriceshow").html();
    //该商品数量=0时候删除
    var num = parseInt($(btn).next().html());
    if (num <= 1) {
        $(btn).parent().parent().remove();
    }

    //商品数量-1
    $(btn).next().html(--num);
    var jiannum = parseInt($(btn).next().html());
    var length = $('div[id='+id+'].dinnerr1').length;
    if (length > 1){
        var goods_num_div = $('div[id='+id+'].dinnerr1').eq(1).find('.dinnerr1-7');

        //判断商品数量-1之后是否和购物车中的相同，不同说明购物车中该商品数量分别来源于热门推荐中和正常分类中，则优先减少热门推荐中该商品数量
        if (parseInt(goods_num_div.html())-1 != jiannum) {
            goods_num_div = $('div[id='+id+'].dinnerr1').eq(0).find('.dinnerr1-7');
        }
    }else {
        var goods_num_div = $('div[id='+id+'].dinnerr1').eq(0).find('.dinnerr1-7');
    }
    //改变商品数量
    var goods_num = parseInt(goods_num_div.html());
    goods_num_div.html(--goods_num);

    //改变购物车总数
    var nm = $("#totalcountshow").html();  //获取数量
    $("#totalcountshow").html(nm * 1 - 1);

    //改变分类栏商品数量
    var ii =  goods_num_div.parents('.dinnerr').index();
    left_i_show(ii,2,1);

    //api减少购物车数据
    desCart(id);
    //如果数量小于或等于0则隐藏减号和数量
    if (goods_num <= 0) {
        goods_num_div.prev().css("display", "none");
        goods_num_div.css("display", "none");

        jss();//改变按钮样式
        $("#totalpriceshow").html((zong * 1 - price * 1).toFixed(2));
        isshow();
        return
    }
    //重新计算金额
    $("#totalpriceshow").html((zong * 1 - price * 1).toFixed(2));

}
//是否有数据显示
function isshow(){
    if($("#goods div").length == 0){
        $('.cart-h31').show();
    }else{
        $('.cart-h31').hide();
    }
}

/*
api添加购物车数据
 */
function addCart(goods_id) {
    var url = '/api/cart/add';
    var data = {goods_id:goods_id};
    $.get(url,data,function (response) { });
}

/*
api删除购物车数据
 */
function desCart(goods_id) {
    var url = '/api/cart/del';
    var data = {goods_id:goods_id};
    $.get(url,data,function (response) { });
}

/*
api清除购物车数据
 */
function clearCart() {
    var url = '/api/cart/clear';
    $.get(url,null,function (response) { })
}