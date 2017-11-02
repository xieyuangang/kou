$(function () {
	
    var shopName = localStorage.getItem("shopName");//标题
    $("title").html(shopName);
    
    var shopQRCode = localStorage.getItem("shopQRCode");
    var outTradeNo = localStorage.getItem("outTradeNo");
    var data = JSON.stringify({
        "qrCode": shopQRCode,
        'outTradeNo': outTradeNo
    });
    $.ajax({
        url: '../pay/query',
        type: "post",
        data: data,
        dataType: "json",
        headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Accept': 'application/json;charset=UTF-8'
        },
        success: function (data) {
            var name = data.data.payAmount / 100;
            var Cla = "";
            var Cttl = "";
            if (data.code == '0000') {
                if (data.data.stateMsg == "待支付") {
                    Cla += " <i class='iconfont icon-zhifushibai' style='color:red;'></i> <span>￥" + name + "</span><p>支付失败</p><ul><li>" + data.data.random[0] + "</li><li>" + data.data.random[1] + "</li><li>" + data.data.random[2] + "</li><li>" + data.data.random[3] + "</li></ul>"
                } else {
                    Cla += " <i class='iconfont icon-ziyuan'></i> <span>￥" + name + "</span><p>支付成功</p><ul><li>" + data.data.random[0] + "</li><li>" + data.data.random[1] + "</li><li>" + data.data.random[2] + "</li><li>" + data.data.random[3] + "</li></ul>"
                }
            } else {
                Cla += " <i class='iconfont icon-zhifushibai' style='color:red'></i> <span>￥" + name + "</span><p>支付失败</p><ul><li>" + data.data.random[0] + "</li><li>" + data.data.random[1] + "</li><li>" + data.data.random[2] + "</li><li>" + data.data.random[3] + "</li></ul>"
            }
            if(data.data.coupon==0){
                Cttl += "<tr><td style='width:30%'>店铺名称</td><td style='width:70%'>" + data.data.shopName + "</td></tr>" +
                    "<tr><td style='width:30%'>商品名</td><td style='width:70%'>" + data.data.goodsName + "</td></tr>" +
                    "<tr><td style='width:30%'>交易日期</td><td style='width:70%'>" + data.data.transTime + "</td></tr>";
            }else{
                Cttl += "<tr><td style='width:30%'>店铺名称</td><td style='width:70%'>" + data.data.shopName + "</td></tr>" +
                    "<tr><td style='width:30%'>商品名</td><td style='width:70%'>" + data.data.goodsName + "</td></tr>" +
                    "<tr><td style='width:30%'>交易日期</td><td style='width:70%'>" + data.data.transTime + "</td></tr>" +
                    "<tr><td style='width:30%'>抵扣券</td><td style='width:70%'>" + data.data.coupon + "</td></tr>";
            }
            $(".payment1").prepend(Cla);
            $(".tab2").append(Cttl);
        }, error: function (data) {
            console.log(data)
        }
    });
    
    /*   var zhi = "";
    $('#function-demo').raty({
        number: 5,//多少个星星设置
        targetType: 'hint',//类型选择，number是数字值，hint，是设置的数组值
        path: '../img',
        hints: ['差', '一般', '好', '非常好', '全五星'],
        cancelOff: 'cancel-off-big.png',
        cancelOn: 'cancel-on-big.png',
        size: 24,
        starHalf: 'star-half-big.png',
        starOff: 'star-off-big.png',
        starOn: 'star-on-big.png',
        target: '#function-hint',
        cancel: false,
        targetKeep: true,
        targetText: '请选择评分',

        click: function (score, evt) {
            //console.log('ID: ' + $(this).attr('id') + "\nscore: " + score + "\nevent: " + evt.type);
            zhi = score;
        }
    });
   $("#button").click(function () {//关闭浏览器

        var ua = navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == "micromessenger") {

            WeixinJSBridge.call('closeWindow');

        } else if (ua.indexOf("alipay") != -1) {

            AlipayJSBridge.call('closeWebview');

        }
    })*/
});