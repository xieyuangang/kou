<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="format-detection" content="email=no"/>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./font/iconfont.css">
    <script type="text/javascript" src="./js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="./js/index.js"></script>
    <title>${shopName}</title>
    <script>
        var ua = navigator.userAgent.toLowerCase();//获是什么取浏览器
        var bankType = '${bankType}';
        var shopName = '${shopName}';
        var outTradeNo = '${outTradeNo}';
        var license = '${license}';
        var toPage = '${toPage}';
        //var customerPhone = '${customerPhone}';
        //var customerName = '${customerName}';
        
        localStorage.setItem("customerPhone", '${customerPhone}');
        localStorage.setItem("customerName", '${customerName}');
        localStorage.setItem("workNo", '${workNo}');
        localStorage.setItem("shopActCode", '${shopActCode}');
        localStorage.setItem("shopQRCode", '${shopQRCode}');
        localStorage.setItem("shopName", '${shopName}');//标题
        localStorage.setItem("outTradeNo", outTradeNo);
        localStorage.setItem("bankType", bankType);
        var newCode = '${code}';//获取新code
        var oldCode = localStorage.getItem("code");//获取旧code
/* alert(newCode+";"+oldCode+";"+(newCode != oldCode)); */
        if (newCode != oldCode) {
            localStorage.setItem("code", newCode);
            if (ua.match(/micromessenger/i) == "micromessenger") {//微信
                payWay = "00";
                var code = localStorage.getItem("code");
                call();
            } else if (ua.match(/alipayclient/i) == "alipayclient") {//支付宝
                payWay = "01";
                var code = localStorage.getItem("code");
                call();
            } else if (ua.match(/jdpay/i) == "jdpay") {//京东
                payWay = "02";
            }
        }
/*         localStorage.clear(); */
        if (toPage == "Success") {
            window.location.href = "./html/Success.html";
        } else if (toPage == "orderReport") {
            window.location.href = "./page_one.html";
        }
    </script>
</head>
<body class="bei">
<section class="products">
    <div class="nav">
        <div>
            <div style="float: right" id="Se"><b></b>
                <p id="Selected" style="display: none"></p></div>
        </div>
        <h3 class="Title">活动商品</h3>
        <div class="commodiTY">
        <ul class="commodity">
              <!--  <li class="X-xiao">
                <img src="./img/yan.png" alt="">
                <h5>小熊猫烟</h5>
                <p><span>原价:<s>￥50.99</s></span><b>￥30.99</b></p>
            </li>
            <li class="X-xiao1">
                <img src="./img/yan.png" alt="">
                <h5>小熊猫烟</h5>
                <p><span>原价:<s>￥50.99</s></span><b>￥30.99</b></p>
            </li>
            <li class="X-xiao2">
                <img src="./img/yan.png" alt="">
                <h5>小熊猫烟</h5>
                <p><span>原价:<s>￥50.99</s></span><b>￥30.99</b></p>
            </li>  -->
        </ul>
         </div>
        <p class="Prompt">不参加活动可点击“ 去付款 ”直接付款</p>
        <button id="pay" class="button">去付款</button>
    </div>
</section>

<div class="Bomb">
    <div>
        <p>
            <input type="number" placeholder="请输入手机号码" id="number">
            <button class="Bname">确认</button>
        </p>
    </div>
</div>
</body>
</html>