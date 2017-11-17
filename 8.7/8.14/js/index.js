function call() {//请求函数
    var data = {'code': code, 'bankType': bankType, 'payway': payWay};
    // alert(JSON.stringify(data));
    $.ajax({
        url: './getOpenId',
        type: "get",
        data: data,
        dataType: "json",
        async: false,
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        success: function (data) {
            if (data.code == '0000') {
                localStorage.setItem("openId", data.data);
            } else if (data.code == '3000') {
                call();
            }
        }, error: function (data) {
            //alert(JSON.stringify(data))
        }
    })
}


$(function () {
    var shopQRCode = localStorage.getItem("shopQRCode");//获取shopQRCode
    var jump = "";


   /* $(".commodity").on('click','li',function () {//多选
        $(this).toggleClass('Sele');
    });*/
   var single;
    $(".commodity").on('click','li',function () {//选中 取消

        /*if(single==="1"){
            if($(this).hasClass('Sele')){
                $(this).removeClass('Sele');
                single=null;
            }
            return false
        }*/
       single=$(this).attr('X-single');
       $(this).toggleClass('Sele');
       if(single==="1"){
           $(this).siblings().removeClass('Sele')
       }else {
           $(this).siblings('li[X-single!=null]').removeClass('Sele')
       }
    });

    /*var ps = [];
    var con;
    function zero() {
        for (var i = 0; i < $(".commodity").find("li").length; i++) {
            ps[i] = 0;
            if ($(".commodity li").eq(i).attr("X-single") != "null") {
                con = i;
            }
        }
    }
    zero();
    var pst = $(".commodity").find("li");
    $(".commodity").find("li").each(function (i) {//选中 取消
        $(this).click(function () {
            var index = $(".commodity").find("li").index(this);
            if (ps[index] == 0 && ps[con] != 1) {
                pst.eq(index).addClass("Sele");
                ps[index] = 1;
                if (index == con) {
                    $(this).siblings().removeClass("Sele");
                    zero();
                    ps[con] = 1;
                }
            } else {
                pst.eq(index).removeClass("Sele");
                ps[index] = 0;
            }
        })
    });*/

    $.ajax({//商品请求
        url: '../../activity-channel/shopgoods/list',
        type: "get",
        data: {'shopQRCode': shopQRCode},
        dataType: "json",
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        async: true,
        success: function (data) {
            var cla = "";

            for (var i = 0; i < data.data.length; i++) {
                var nameS = data.data[i].price;
                var nameM = nameS / 100;

                cla += "<li class='' x-la='" + data.data[i].shopGoodsCode + "'><img src='" + data.data[i].actGoods.imgUrl + "'><h5>" + data.data[i].actGoods.name + "</h5><p><b>￥" + nameM + "元/" + data.data[i].unit + "</b></p></li>"
            }
            $(".commodity").append(cla);

            $(".commodity").find("li").each(function (i) {//选中 取消
                var pt = 0;
                $(this).click(function () {
                    if (pt == 0) {
                        var single = $(this).attr("X-single");
                        $(this).addClass("Sele");
                        pt = 1;
                        if (single == '1') {
                            $(this).siblings.addClass("Sele")
                        }
                    } else {
                        $(this).removeClass("Sele");
                        pt = 0;
                    }
                    jump = $(this).attr('class');
                });
            });

            if (ua.match(/bestpay/i) == "bestpay") {//翼支付
                payWay = "03";

                $(".Bomb").show(); //显示弹框
                $(".Bname").click(function () {//输入手机号码

                    var code = $(".Bomb input").val();
                    if (!(/^1[3,4,5,7,8]\d{9}$/.test(code))) {
                        alert("手机号码不正确重新输入");
                        return false;
                    }
                    $(".Bomb").hide();
                    openId = $("#number").val();
                    localStorage.setItem("openId", openId);
                })

            }

        }, error: function (data) {
            console.log(data)
        }
    });

    $("#pay").click(function () {//跳转页面
        var param = [];
        $('.commodity').find(".Sele").each(function (i) {
            var smoke = $(this).attr("x-la");
            param.push(smoke);
        });
        var Sparam = param.join(",");
        localStorage.setItem("Sparam", Sparam);
        if ($("li").hasClass("Sele")) {
            Su();
            window.location.href = "./Shopping.html";
        } else {
            window.location.href = "./payment.html";
        }
    })

});

function Su() {
    var shopGoodsCodes = localStorage.getItem("Sparam");//获取shopGoodsCodes
    var shopQRCode = localStorage.getItem("shopQRCode");//获取shopQRCode
    var date = {'shopQRCode': shopQRCode, "shopGoodsCodes": shopGoodsCodes};

    $.ajax({//提交商品属性
        url: '../../activity-channel/shopgoods/list',
        type: "get",
        data: date,
        dataType: "json",
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        async: true,
        success: function (data) {
            console.log(data + "成功")
        }, error: function (data) {
            console.log(data)
        }
    })
}