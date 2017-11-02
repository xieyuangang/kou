var myApp = angular.module('myApp', []);

myApp.controller('orderListCtrl', ['$scope', '$location', '$window', '$http', function($scope, $location, $window, $http){

//	var host = 'http://test.jike8.com.cn/wxyh/wechatPay';
	var host = 'http://rjyh.jike8.com.cn/order-channel';
	
	// 测试返回json
	// var returnJson = {"code":"0000","msg":"操作成功","data":{"id":null,"mchNo":null,"deviceNo":null,"orderNo":"20170905041123","outTradeNo":"SY20170905163039053ycFTjW5QF","payQRCodeUrl":null,"amt":1,"empNo":null,"empName":null,"activityNo":null,"goodsDesc":"[{\"goodsName\":\"测试烟\",\"goodsQuantity\":1,\"goodsBarCode\":\"6901028316989\",\"goodsPrice\":\"22.00\",\"goodsTotalAmt\":\"22.00\",\"goodsDesc\":\"\"}]","state":null,"createTime":null,"updateTime":null,"isDel":null,"random":null}};


	// 测试订单号
	var data = {
		// outTradeNo : 'SY20170905163039053ycFTjW5QF'
        // outTradeNo : $location.search().outTradeNo
        outTradeNo : localStorage.getItem("outTradeNo")
	};

	//获取订单信息
	$http({
		url: host + '/order/pageSearch',
		method: 'GET',
		headers: {
             'Content-Type': 'application/json;charset=UTF-8',
             'Accept': 'application/json;charset=UTF-8'
         },
		params: data
	}).success(function(data){
		// console.log(data);
        //显示订单号
		if(data.code=='0000') {
			 $scope.outTradeNo = data.data.outTradeNo;
	        //赋值给goods进行repeat
	        $scope.goods = JSON.parse(data.data.goodsDesc);

	        //计算商品总价
	        $scope.sum = function(){
	            var totle = 0;
	            $scope.goods.forEach(function(good){
	                totle += parseFloat(good.goodsTotalAmt);
	            });
	            return totle.toFixed(2);
	        };
		}else{
			alert(data.msg);
		}
		
	}).error(function(err){
		console.log(err);
	});
	
	//选择支付
	$scope.surePay = function(){
		 $(".zhuan").show()
		 var ua = navigator.userAgent.toLowerCase();//获是什么取浏览器
		 var payway;
		 if (ua.match(/micromessenger/i) == "micromessenger") {//微信
			 	payway = "00";
            } else if (ua.match(/alipayclient/i) == "alipayclient") {//支付宝
            	payway = "01";
            } else if (ua.match(/jdpay/i) == "jdpay") {//京东
            	payway = "02";
            } else if (ua.match(/bestpay/i) == "bestpay") {//易支付
            	payway = "03";
            }
   		// console.log(payway);			//'00'是微信，'01'是支付宝
		/*alert("openId:"+localStorage.getItem("openId"));*/
        if(!localStorage.getItem("openId")) {
        	alert("openId不存在");
        	return;
        }
		var requestObj = {
			outTradeNo: $scope.outTradeNo,
			payWay: payway,
			openId: localStorage.getItem("openId")
		};
		$http({
			url: host + '/order/confirmPayment',
			method:'post',
			data: JSON.stringify(requestObj),
			dataType: "json",
			headers: {
                'Content-Type': 'application/json;charset=UTF-8',
                'Accept': 'application/json;charset=UTF-8'
            },
		}).success(function(data){
			// console.log(data);
			if(data.code=='0000') {
				 $(".zhuan").hide()
				 zhifu(data);//调用支付判断

	             localStorage.setItem("outTradeNo", data.data.outTradeNo);
			}else{
     			alert(data.msg);
     			$(".zhuan").hide()
     		}
		}).error(function(err){
			console.log(err);
			$(".zhuan").hide()
		});

        // //跳转至结果页
        // function toResult(isOk){
        //     if(isOk){
        //         $window.location.href = './page_two.html';
        //         $window.localStorage['isOk'] = 'true';
        //     } else {
        //         $window.location.href = './page_two.html';
        //         $window.localStorage['isOk'] = 'false';
        //     }
        // }
        // toResult(false);
	};
	
	function zhifu(data) {//支付判断
		var ua = navigator.userAgent.toLowerCase();//获是什么取浏览器
		if (ua.match(/micromessenger/i) == "micromessenger") {//微信
            payWay = "00";
		 } else if (ua.match(/alipayclient/i) == "alipayclient") {//支付宝
             payWay = "01";
		 } else if (ua.match(/jdpay/i) == "jdpay") {//京东
             payWay = "02";
         } else if (ua.match(/bestpay/i) == "bestpay") {//易支付
             payWay = "03";
         }
	    if (payWay == '00') {

	        weixin(JSON.parse(data.data.payInfo))

	    } else if (payWay == '01') {

	        if (JSON.parse(data.data.payInfo).status == '0') {
	            moubao(JSON.parse(data.data.payInfo).tradeNo)
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
}]);


