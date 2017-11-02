myApp.factory("Interface" , function($http , tool){
	return {
		pay:function(amount , fn){
			var This = this;
			$http({
	    		url:pathUrl+'/wechat/prepay',
	    		method:'post',
	    		data:JSON.stringify({
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
	    				This.onBridgeReady(JSON.parse(json.data.payInfo));
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
		
		query:function(fn){
			try{
				$http({
		    		url:pathUrl+'/wechat/query',
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
			}catch(e){
				alert(e.message);
			}
			
		},
		
		comments:function(fn){
			$http({
				/*url:url+'/shop/comments?shopQRCode='+localStorage.getItem("shopQRCode"),*/
	    		url:pathUrl+'/shop/comments?shopQRCode='+localStorage.getItem("shopQRCode"),
	    		method:'get',
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
		
		consumeIntegral : function(param , fn){
			$http({
	    		url:pathUrl+'/integral/consumeIntegral',
	    		method:'post',
	    		data:JSON.stringify(param),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		fn(json);
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		addIntegral:function(param,fn){
			$http({
	    		url:pathUrl+'/integral/addIntegral',
	    		method:'post',
	    		data:JSON.stringify(param),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='00') {
	    			fn(json);
				}else {
					alert(json.msg);
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		produceIntergral:function(param , fn){
			$http({
	    		url:pathUrl+'/integral/produceIntergral',
	    		method:'post',
	    		data:JSON.stringify(param),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='00') {
	    			fn(json);
				}else {
					alert(json.msg);
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		getIntergralBalance:function(param , fn){
			$http({
	    		url:pathUrl+'/integral/getIntergralBalance?'+param,
	    		method:'get',
	    	}).success(function(json){
	    		if(json.code=='00') {
	    			fn(json);
				}else {
					alert(json.msg);
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		getIntergralAppointBalance:function(param , fn){
			$http({
	    		url:pathUrl+'/integral/getIntergralAppointBalance?'+param,
	    		method:'get',
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
		
		getIntegralCustomer:function(param , fn){
			$http({
				/*url:url+'/integral/getIntegralCustomer?'+param,*/
	    		url:pathUrl+'/integral/getIntegralCustomer?'+param,
	    		method:'get',
	    	}).success(function(json){
	    		fn(json);
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		consumeIntergralWechatPay:function(param , fn){
			$http({
	    		url:pathUrl+'/integral/consumeIntergralWechatPay',
	    		method:'post',
	    		data:JSON.stringify(param),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='00') {
	    			localStorage.setItem("outTradeNo" , json.data.outTradeNo);
    				This.onBridgeReady(JSON.parse(json.data.payInfo));
				}else {
					fn();
					alert(json.msg);
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		getIntegralExchangeDetail:function(param , fn){
			$http({
	    		url:url+'/integral/getIntegralExchangeDetail?'+param,
	    		method:'get',
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='0000') {
	    			fn(json.data);
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		getIntegralDeductionDetail:function(param , fn){
			$http({
	    		url:url+'/integral/getIntegralDeductionDetail?'+param,
	    		method:'get',
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		fn(json);
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		}
	};
});
