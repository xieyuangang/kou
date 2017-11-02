$(function () {

     localStorage.setItem("outTradeNo" , data.outTradeNo);
    if(payWay == '00'){
        weixin(JSON.parse(data.payInfo))
    }else if(payWay == '01'){

        if(JSON.parse(data.payInfo).status == '0'){
            moubao(JSON.parse(data.payInfo).tradeNO)
        }else{
            window.location.hash = "/success";
        }
    }else if(payWay == '02'){
        var payInfo = JSON.parse(data.payInfo);
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
    }else if(payWay == '03'){
        var payInfo = JSON.parse(data.payInfo);
        location.href=payInfo.url;
    }
});


function weixin(data){//微信接口

    WeixinJSBridge.invoke('getBrandWCPayRequest', data, function (res) {
        if (res.err_msg == "get_brand_wcpay_request:ok") {

            //window.location.hash = "/success";
        } // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
        else if (res.err_msg == "get_brand_wcpay_request:cancel") {

            // window.location.hash = "/success";
        } else if (res.err_msg == "get_brand_wcpay_request:fail") {

            // window.location.hash = "/success";
        }
    });
}

function moubao(data){//支付宝接口
    if (window.AlipayJSBridge) {
        callback && callback();
    } else {
        // 如果没有注入则监听注入的事件
        document.addEventListener('AlipayJSBridgeReady', callback, false);
    }
    function callback(){
        AlipayJSBridge.call('tradePay' , {
            tradeNO : data,
        } ,  function(result){
            window.location.hash = "/success";
        });
    }
}
