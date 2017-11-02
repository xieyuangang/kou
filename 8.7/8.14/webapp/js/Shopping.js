$(function () {
    var shopName = localStorage.getItem("shopName");// 标题
    $("title").html(shopName);
    
    window.alert = function(name){  //去掉弹框路径
        var iframe = document.createElement("IFRAME");  
       iframe.style.display="none";  
       iframe.setAttribute("src", 'data:text/plain,');  
       document.documentElement.appendChild(iframe);  
       window.frames[0].window.alert(name);  
       iframe.parentNode.removeChild(iframe);  
   };
    
    var shopGoodsCodes = localStorage.getItem("Sparam");
    var shopQRCode = localStorage.getItem("shopQRCode");//获取shopQRCode
    $.ajax({//获取商品列表
        url: '../../activity-channel/shopgoods/list',
        type: "get",
        data: {'shopQRCode': shopQRCode, "shopGoodsCodes": shopGoodsCodes},
        dataType: "json",
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        async: false,
        success: function (data) {
            var clats = "";
            for (var i = 0; i < data.data.length; i++) {
                var nameS = data.data[i].price;
                var nameM = nameS / 100;
                clats += "<li class='one-goods' lay-tt='" + data.data[i].shopGoodsCode + "'><div class='delete' style='width: 15%;line-height: 100px;color: red;text-align: center;'>删除</div><input type='checkbox' class='GoodsCheck' style='display: none'> <div style='width: 31%;' class='lists'><img src='" + data.data[i].actGoods.imgUrl + "'><p class='smoke'><b style='width:69px;overflow: hidden;text-overflow: ellipsis;'>" + data.data[i].actGoods.name + "</b><b>￥ <span class='GoodsPrice'>" + nameM + "</span></b></p></div><div style='width: 26%;' class='list'><a href='javascript:;' class='reduce'><input type='button' value='-'></a><span><input type='tel' value='1' class='number'></span><a href='javascript:;' class='plus'><input type='button' value='+'></a></div><div style='margin-top:35px;white-space: nowrap;width: 28%;overflow: hidden;box-sizing: border-box;padding-left:6px;'>总计:<br/>&nbsp &nbsp &nbsp ￥ <b class='single'>" + nameM + "</b></div></li>"
            }
            $(".one-shop").prepend(clats);
        }, error: function (data) {
            alert("系统繁忙")
        }
    });

    TotalPrice();

    $(".number").blur(function () {//输入
        var hh = $(this);
        if ($(".number").val() == "" || $(".number").val() == 0) {
            $(".number").val(1);
            hei(hh);
            TotalPrice();
        }
        hei(hh);
        TotalPrice();
    });

    $(".delete").click(function () {// 删除
        $(this).parent().remove();
        $(".one-goods").each(function () {
            TotalPrice()
        });
        var hh = $(this);
        if ($("li").length == 0) {//没得商品
            $(".ShopTotal").html("00.00");
            $("#AllTotal").html("00.00")
        }
    });

    $(".reduce").click(function () {// 减
        var hh = $(this);
        var currNum = $(this).siblings("span").find(".number");
        currNum.val(parseInt(currNum.val()) - 1);
        if (currNum.val() <= 1) {
            currNum.val(1);
        }
        hei(hh);
        TotalPrice();
    });

    $(".plus").click(function () {// 加
        var hh = $(this);
        var currNum = $(this).siblings("span").find(".number");
        currNum.val(parseInt(currNum.val()) + 1);
        if (currNum.val() <= 1) {
            currNum.val(1);
        }
        hei(hh);
        TotalPrice();
    });

    function hei(obj) {// 总计函数
        var numberNam = obj.parents('.list').find(".number").val();
        var singleNam = obj.parents('.list').siblings(".lists").find(
            '.GoodsPrice').html();
        var TotalNam = numberNam * singleNam;
        var ZZi = Number(TotalNam).toFixed(2);
        obj.parents('.list').siblings('div').find('.single').html(ZZi);
    }

    function TotalPrice() {

        $(".one-shop").each(
            function () { // 循环每个店铺
                var oprice = 0; // 店铺总价
                $(this).find(".GoodsCheck").each(
                    function () { // 循环店铺里面的商品
                        var num = parseInt($(this)
                            .parents(".one-goods").find(".number")
                            .val()); // 得到商品的数量
                        var price = parseFloat($(this).parents(
                            ".one-goods").find(".GoodsPrice")
                            .text()); // 得到商品的单价
                        var total = price * num; // 计算单个商品的总价
                        oprice += total; // 计算该店铺的总价
                        $(this).closest(".one-shop").find(".ShopTotal")
                            .text(oprice.toFixed(2)); // 显示被选中商品的店铺总价
                        var Ynam = $(".Ynam").html();
                        var z = oprice - Ynam;// 优费卷减
                        var Zi = Number(z).toFixed(2);
                        $("#AllTotal").html(Zi)

                    });
            });
    }


    var ua = navigator.userAgent.toLowerCase();// 获是什么取浏览器
    var n = 0;
    $(".button").on("touchend", function () {// 付款
    	 $(".zhuan").show()
        if (n == 0) {
            n++;
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
        }
    });

    function call(payWay) {
        var and = $("#AllTotal").html();
        var amountL = and * 100;// 金额
        var amount = Number(amountL).toFixed(0);

       // var memberIdL = decodeURI(window.location.href);// 获取memberIdL
       // var openId = memberIdL.split('?')[1];
        var openId = localStorage.getItem("openId");
       
        var staffMId = localStorage.getItem("staffMId");// 店员id
        var shopActCode = localStorage.getItem("shopActCode");// 活动编码
        var shopQRCode = localStorage.getItem("shopQRCode");// 店铺编码
        var payType = "01";// 普通支付

        var orderDetailList = [];
        var name;
        $(".one-shop").find("li").each(function () {

            var quantityL = $(this).find(".number").eq(0).val();
            var quantity = parseInt(quantityL);

            var totalAmtM = $(this).find(".single").eq(0).html();
            var totalAmtML = totalAmtM * 100;
            var totalAmtMLe = Number(totalAmtML).toFixed(0);
            var totalAmt = parseInt(totalAmtMLe);

            name = {
                quantity: quantity,
                totalAmt: totalAmt,
                shopGoodsCode: $(this).eq(0).attr("lay-tt")
            };
            orderDetailList.push(name)
        });

        var data = JSON.stringify({
            'amount': amount,
            'openId': openId,
            'payWay': payWay,
            'staffMId': staffMId,
            'activityCode': shopActCode,
            "qrCode": shopQRCode,
            "payType": payType,
            "orderDetailList": orderDetailList
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
                try {
                	 $(".zhuan").hide()
                    //alert(JSON.stringify(data))
                    zhifu(data); //调用支付判断
                    localStorage.setItem("outTradeNo", data.data.outTradeNo);
                } catch (e) {
                    //alert(e.message);
                	 $(".zhuan").hide()
                    alert("系统繁忙");
                    //alert(JSON.stringify(data.msg))
                }
            },
            error: function (data) {
            	 $(".zhuan").hide()
                alert("系统繁忙")
            }
        })
    }

    function zhifu(data) {// 支付判断
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

    function weixin(data) {// 微信接口
        WeixinJSBridge.invoke('getBrandWCPayRequest', data, function (res) {
            if (res.err_msg == "get_brand_wcpay_request:ok") {
                window.location.href = "html/Success.html"
            } // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回 ok，但并不保证它绝对可靠。
            else if (res.err_msg == "get_brand_wcpay_request:cancel") {
                window.location.href = "html/Success.html"
            } else if (res.err_msg == "get_brand_wcpay_request:fail") {
                window.location.href = "html/Success.html"
            }
        });
    }

    function moubao(data) {// 支付宝接口
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
});