myApp.factory("Interface" , function($http , tool){//交互页面
	return {
		pay:function(amount , payUrl , payWay , activityCode , usable , payType , useIntegral , fn){
			var This = this;
			$http({
	    		url:pathUrl+payUrl,
	    		method:'post',
	    		data:JSON.stringify({
	    				'payWay' : payWay,
	    				'amount' :amount.toString(),//支付金额，分
	    				'openId' : localStorage.getItem("openId"),
	    				"qrCode":localStorage.getItem("shopQRCode"),
	    				'staffMId':localStorage.getItem("staffMId"),
	    				'activityCode' : activityCode,
	    				'usable' : usable,
	    				'num' : 0,
	    				'payType' : payType,
	    				'useIntegral' : useIntegral,
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
				/*url:url+'/wechat/query',*/
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
		},
		
		comments:function(fn){
			$http({
				/*url:url+'/shop/comments?shopQRCode='+localStorage.getItem("shopQRCode"),*/
	    		url:pathUrl+'/integral/comments?shopQRCode='+localStorage.getItem("shopQRCode"),
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
		
		evaluate:function(commentScore , recordId , fn){
			$http({
	    		url:pathUrl+'/shopIntroduction/createShopEvaluate',
	    		method:'post',
	    		data:JSON.stringify({
	    			'shopQRCode' : localStorage.getItem("shopQRCode"),
	    			'commentScore' : commentScore,
	    			'recordId' : recordId
	    		}),
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
	    		/*url:url+'/integral/produceIntergral',*/
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
		
		getMerchantQrCodeUrl:function(fn){
			$http({
				/*url:url+'/integral/getMerchantQrCodeUrl?qrCode='+localStorage.getItem("shopQRCode"),*/
	    		url:pathUrl+'/integral/getMerchantQrCodeUrl?qrCode='+localStorage.getItem("shopQRCode"),
	    		method:'get',
	    	}).success(function(json){
	    		if(json.code == '00'){
	    			fn(json.data);
	    		}
	    		
	    	}).error(function(msg){
	    		alert(msg);
	    	});	
		},
		
		config:function(){
			var func = ['scanQRCode' , 'onMenuShareTimeline'];
			var ticket = null;
			var noncestr = null;
			var timestamp = null;
			var sign = null;
			var appId = null;
			var Url = location.href.split('#')[0];
			$http({
				url:pathUrl+"/weixin/getSdkSign",
				method:'post',
				data:{"url":Url, "shopQRCode":localStorage.getItem("shopQRCode")}
			}).success(function(data){
				try {
					if(data.code == '0000'){
						ticket = data.data.ticket;
						noncestr = data.data.noncestr;
						timestamp = data.data.timestamp;
						sign = data.data.sign;
						appId = data.data.appId;
						// 注册config
						wx.config({
							debug : false,
							appId : appId,
							timestamp : timestamp,
							nonceStr : noncestr,
							signature : sign,
							jsApiList : func
						});
						wx.error(function(res){
							alert("wx.error:"+JSON.stringify(res));
						});
					}
				} catch (e) {
					alert(e.message);
				}
				
			}).error(function(){
				alert("错误");
			});
		},
		
		onMenuShareTimeline:function(obj){
			wx.ready(function(){
				wx.onMenuShareTimeline({
				    title: obj.title, // 分享标题
				    link: obj.link, // 分享链接
				    imgUrl: '', // 分享图标
				    success: function () { 
				        // 用户确认分享后执行的回调函数
				    	obj.success();
				    },
				    cancel: function () { 
				        // 用户取消分享后执行的回调函数
				    	obj.cancel();
				    },
				    fail :function(json){
				    	alert(json.errMsg);
				    }
				});
			});
		}
		
	};
});
