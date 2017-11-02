$(function () {
	
	 window.alert = function(name){  //去掉弹框路径
         var iframe = document.createElement("IFRAME");  
        iframe.style.display="none";  
        iframe.setAttribute("src", 'data:text/plain,');  
        document.documentElement.appendChild(iframe);  
        window.frames[0].window.alert(name);  
        iframe.parentNode.removeChild(iframe);  
    }  
	
    var ua = navigator.userAgent.toLowerCase();//获是什么取浏览器
    $(".tab table tr td input").each(function () {//键盘输入
        $(this).on("touchstart", function () {
            $(this).css({boxShadow: " 0px 0px 0px 2px #e2e2e2"})
        });
        $(this).on("touchend ", function () {
            $(this).css({boxShadow: " 0px 0px 0px 0px #FFF"})
        });
        $(this).on("touchend", function () {
            pas = $(this).val();
            $("#gold").append(pas);
        })
    });
    var shopName = localStorage.getItem("shopName");//标题
    $("title").html(shopName);
    $("#delete").click(function () {//删除
        $("#gold").html("");
    });
    
    var n = 0;
    $("#pay").on("touchend", function () {//付款
        if ($("#gold").html() == "") {
            alert("请输入金额");
            return false;
        }
        if (n == 0) {
            n++;   
            $(".zhuan").show()
            if (ua.match(/micromessenger/i) == "micromessenger") {//微信
                payWay = "00";
                var code = localStorage.getItem("code");
                call(payWay)
            } else if (ua.match(/alipayclient/i) == "alipayclient") {//支付宝
                payWay = "01";
                var code = localStorage.getItem("code");// 获取code
                call(payWay)
            } else if (ua.match(/jdpay/i) == "jdpay") {//京东
                payWay = "02";
                call(payWay)
            } else if (ua.match(/bestpay/i) == "bestpay") {//易支付
                payWay = "03";
                call(payWay)// 请求调用
            }
        } else if (n == 1) {
            n--;
            return false;
        }
        function call() {
            var gold = $("#gold").html();//输入金额
            var volume = $("#volume").html();//抵扣卷
            var and = gold - volume;//计算
            var ZZi = and * 100;
            var amount = Number(ZZi).toFixed(0);
            if (gold == "") {
                alert("请输入金额");
                return false;
            }
            // var memberIdL = decodeURI(window.location.href);//获取memberIdL
            var openId = localStorage.getItem("openId");

            var staffMId = localStorage.getItem("staffMId");//店员id
            var shopActCode = localStorage.getItem("shopActCode");//活动编码
            var shopQRCode = localStorage.getItem("shopQRCode");//店铺编码
            var payType = "00";//普通支付
            var data = JSON.stringify({
                'amount': amount,
                'openId': openId,
                'payWay': payWay,
                'staffMId': staffMId,
                'activityCode': shopActCode,
                "qrCode": shopQRCode,
                "payType": payType
            });
            $.ajax({
                url: './pay/prepay',
                type: "post",
                data: data,
                dataType: "json",
                headers: {
                    'Content-Type': 'application/json;charset=UTF-8',
                    'Accept': 'application/json;charset=UTF-8'
                },
                async: true,
                success: function (data) {
                	 $(".zhuan").hide()
                    try {
                       // alert(JSON.stringify(data))
                        zhifu(data);//调用支付判断
                        localStorage.setItem("outTradeNo", data.data.outTradeNo);
                    } catch (e) {
                       // alert(e.message);
                        alert("系统繁忙")
                         $(".zhuan").hide()
                    }
                }, error: function (data) {
                    alert("系统繁忙")
                    $(".zhuan").hide()
                }
            })

        }

    })
});

function zhifu(data) {//支付判断
    if (payWay == '00') {
        weixin(JSON.parse(data.data.payInfo))
    } else if (payWay == '01') {
        if (JSON.parse(data.data.payInfo).status == '0') {
            moubao(JSON.parse(data.data.payInfo).tradeNO)
        }
    } else if (payWay == '02') {
        var payInfo = JSON.parse(data.data.payInfo);
        $("#version").val(payInfo.version);
        $("#merchant").val(payInfo.merchant);
        $("#jdAmount").val(payInfo.amount);
        $("#tradeNum").val(payInfo.tradeNum);
        $("#tradeName").val(payInfo.tradeName);
        $("#tradeTime").val(payInfo.tradeTime);
        $("#tradeType").val(payInfo.tradeType);
        $("#currency").val(payInfo.currency);
        $("#notifyUrl").val(payInfo.notifyUrl);
        $("#ip").val(payInfo.ip);
        $("#sign").val(payInfo.sign);
        $("#device").val(payInfo.device);
        $("#callbackUrl").val(payInfo.callbackUrl);
        $("#expireTime").val(payInfo.expireTime);
        $("#orderType").val(payInfo.orderType);
        $("#payMerchant").val(payInfo.payMerchant);
        $("#riskInfo").val(payInfo.riskInfo);
        $("#jdForm").submit();
    } else if (payWay == '03') {
        var payInfo = JSON.parse(data.data.payInfo);
        location.href = payInfo.url;
    }
}
function weixin(data) {//微信接口
    WeixinJSBridge.invoke('getBrandWCPayRequest', data, function (res) {
        if (res.err_msg == "get_brand_wcpay_request:ok") {
            window.location.href = "html/Success.html"
        } // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
        else if (res.err_msg == "get_brand_wcpay_request:cancel") {
            window.location.href = "html/Success.html"
        } else if (res.err_msg == "get_brand_wcpay_request:fail") {
            alert(JSON.stringify(res));
            window.location.href = "html/Success.html"
        }
    });
}
function moubao(data) {//支付宝接口
    if (window.AlipayJSBridge) {
        callback && callback();
    } else {
        // 如果没有注入则监听注入的事件
        document.addEventListener('AlipayJSBridgeReady', callback, false);
    }
    function callback() {
        AlipayJSBridge.call('tradePay', {
            tradeNO: data
        }, function (result) {
            window.location.href = "html/Success.html"
        });
    }
}

