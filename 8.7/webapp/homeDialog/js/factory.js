myApp.factory("Interface" , function($http , tool){
	return {
		pay:function(amount , fn){
			var This = this;
			var payWay = "00";
    		var payUrl = "";
    		var ua = navigator.userAgent.toLowerCase();
    		
    		/*if(ua.match(/micromessenger/i) == "micromessenger"){
    			payUrl = "/wechat/prepay";
    			payWay = "00";
    		}else if (ua.match(/alipayclient/i) == "alipayclient"){
    			payUrl = "/alipay/prepay";
    			payWay = "01";
    		}*/
    		
    		if(ua.match(/micromessenger/i) == "micromessenger"){//微信
				payWay = "00";
			}else if (ua.match(/alipayclient/i) == "alipayclient"){//支付宝
				payWay = "01";
			}else if(ua.match(/jdpay/i) == "jdpay") {//京东
				payWay = "02";					
			}else if(ua.match(/bestpay/i) == "bestpay") {//易支付
				payWay = "03";					
			}
    		
			$http({
	    		url:url+payUrl,
	    		method:'post',
	    		data:JSON.stringify({
	    				'payWay' : payWay,
	    				'amount' :amount.toString(),//支付金额，分
	    				'openId' : localStorage.getItem("openId"),
	    				"qrCode":localStorage.getItem("shopQRCode"),
	    				'staffMId':localStorage.getItem("staffMId")
	    		}),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='0000') {
	    			try{
	    				localStorage.setItem("outTradeNo" , json.data.outTradeNo);
	    				if(payWay == '00'){
	    					This.onBridgeReady(JSON.parse(json.data.payInfo));
	    				}else if(payWay == '01'){
	    					if(JSON.parse(json.data.payInfo).status == '0'){
	    						This.alipay(JSON.parse(json.data.payInfo).tradeNO);
	    					}else{
	    						window.location.hash = "/result";
	    					}
	    					
	    				}
	    			}catch(e){
	    				alert(e);
	    			}
				}else {
					fn();
					alert(json.msg);
				}
	    	}).error(function(msg){
	    		fn();
	    		alert(msg);
	    	});	
		},
		
		onBridgeReady:function(data){
			WeixinJSBridge.invoke('getBrandWCPayRequest', data, function(res) {
				if (res.err_msg == "get_brand_wcpay_request:ok") {
					window.location.hash = "/result";
				} // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
				else if (res.err_msg == "get_brand_wcpay_request:cancel") {
					window.location.hash = "/result";
				} else if (res.err_msg == "get_brand_wcpay_request:fail") {
					window.location.hash = "/result";
				}
			});
		},
		
		alipay : function(data){
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
					window.location.hash = "/result";
				});
			}
		},
		
		query:function(fn){
			$http({
	    		url:url+'/wechat/query',
	    		method:'post',
	    		data:JSON.stringify({
	    			'outTradeNo' : localStorage.getItem("outTradeNo"),
	    			/*'outTradeNo' :'WP20170209171732711nvDAtSJ9h',*/
	    		}),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='0000') {
	    			fn(json);
				}else {
					alert(json.msg);
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		comments:function(fn){
			$http({
	    		url:url+'/shop/comments?shopQRCode='+localStorage.getItem("shopQRCode"),
	    		method:'get',
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json){
	    			if(json.code=='0000') {
		    			fn(json);
					}else {
						alert(json.msg);
					}
	    		}else{
	    			json.data.commentAvgScore = 0;
	    			json.data.commentSum = 0;
	    			fn(json);
	    		}
	    		
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		evaluate:function(commentScore , fn){
			$http({
	    		url:url+'/shop/evaluate',
	    		method:'post',
	    		data:JSON.stringify({
	    			'shopQRCode' : localStorage.getItem("shopQRCode"),
	    			'commentScore' : commentScore,
	    		}),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='0000') {
	    			fn(json);
				}else {
					alert(json.msg);
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
	};
});
