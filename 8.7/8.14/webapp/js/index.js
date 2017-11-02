
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
            localStorage.setItem("openId", data.data);
        }, error: function (data) {
           //alert(JSON.stringify(data))
        }
    })
}

$(function () {
    var shopQRCode = localStorage.getItem("shopQRCode");//获取shopQRCode
    var jump = "";

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
                cla += "<li class='' x-la='" + data.data[i].shopGoodsCode + "'><img src='" + data.data[i].actGoods.imgUrl + "'><h5>" + data.data[i].actGoods.name + "</h5><p><b>￥" + nameM + "</b></p></li>"
            }
            $(".commodity").append(cla)
            
            $(".commodity").find("li").each(function (i) {//选中 取消
                var pt = 0;
                $(this).click(function () {
                    if (pt == 0) {
                        $(this).addClass("Sele");
                        pt = 1;
                    } else {
                        $(this).removeClass("Sele");
                        pt = 0;
                    }
                    jump = $(this).attr('class');
                });
            });

            if (ua.match(/bestpay/i) == "bestpay") {//翼支付
                payWay = "03";
             
                $(".Bomb").show()//显示弹框
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
