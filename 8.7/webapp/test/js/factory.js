myApp.factory("Order" , function($http , tool){
	return {
		getOrderList:function(date,openId,scope){
			$http({
				url:url+"/order/getOrderList",
				data:{"date":date,"openId":openId},
				method:'post',
			}).success(function(json){
				if(!json.orderList){
					$("#promptBox").fadeIn("slow");
					setTimeout(function(){$("#promptBox").fadeOut("slow");}, 2000);
					scope.prompt = "无账单记录";
				}
				scope.list = json.orderList;
			});
		}
	};
});

myApp.factory("Home" , function($http , tool){
	return {
		getOrderList:function(date,custId,scope){
			$http({
				url:url+"/pointDetail/getPayOrderList",
				data:{"date":date,"custId":custId},
				method:'post',
			}).success(function(json){
				if(json.data){
					scope.list = json.data.orderList;
					scope.successCount = json.data.orderCount.successCount;
					scope.successSum = json.data.orderCount.successSum;
				}else{
					scope.list = [];
					scope.successCount = 0;
					scope.successSum = 0;
				}
				
			});
		},
		retailPoint:function(date,custId,scope){
			$http({
				url:url+"/pointDetail/pointDetail",
				data:{"date":date,"custId":custId},
				method:'post',
			}).success(function(json){
				scope.list = json.data;
			});
		}
	};
});

myApp.factory("PointDetail" , function($http , tool){
	return {
		getPointdetailList:function(date,openId,scope){
			$http({
				url:url+"/pointdetail/getPointdetailList",
				data:{"date":date,"openId":openId},
				method:'post',
			}).success(function(json){
				scope.list = json.detailList;
			});
		}
	};
});

myApp.factory("Interface" , function($http , tool){
	return {
		prepay : function(param , fn , error){
			var ua = navigator.userAgent.toLowerCase();
			var payUrl = "/pay/prepay";
			/*if(ua.match(/micromessenger/i) == "micromessenger"){
				payUrl = "/pay/prepay";
			}else if (ua.match(/alipayclient/i) == "alipayclient"){
				payUrl = "/pay/prepay";
			}*/
			$http({
				url : pathUrl+payUrl,
				data : JSON.stringify(param),
				method : 'post',
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				if(json.code == '0000'){
					if(fn){fn(json.data);}
				}else{
					error();
					alert(json.msg);
				}
				
			}).error(function(msg){
				alert(msg);
			});
		},
		
		ynPrepay : function(param , fn , error){
			var ua = navigator.userAgent.toLowerCase();
			var payUrl = "/pay/prepay";
			/*if(ua.match(/micromessenger/i) == "micromessenger"){
				payUrl = "/ynWechat/prepay";
			}else if (ua.match(/alipayclient/i) == "alipayclient"){
				payUrl = "/ynAlipay/prepay";
			}*/
			$http({
				url : pathUrl+payUrl,
				data : JSON.stringify(param),
				method : 'post',
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				if(json.code == '0000'){
					if(fn){fn(json.data);}
				}else{
					error();
					alert(json.msg);
				}
				
			}).error(function(msg){
				alert(msg);
			});
		},
		
		query : function(param , fn , error){
			$http({
				/*url:url+'/ynWechat/query',*/
				url:pathUrl+'/pay/query',
				method:'post',
				data:JSON.stringify(param),
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				if(json.code == '0000'){
					if(fn){fn(json.data);}
				}else{
					alert(json.msg);
				}
			}).error(function(msg){
				alert(msg);
			});	
		},
		
		onBridgeReady : function(data){
			WeixinJSBridge.invoke('getBrandWCPayRequest', data, function(res) {
				if (res.err_msg == "get_brand_wcpay_request:ok") {
					window.location.hash = "/success";
				} // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
				else if (res.err_msg == "get_brand_wcpay_request:cancel") {
					window.location.hash = "/success";
				} else if (res.err_msg == "get_brand_wcpay_request:fail") {
					window.location.hash = "/success";
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
					window.location.hash = "/success";
				});
			}
		},
		
		lottery : function(param , fn , not , error , checkIsLottery){
			$http({
				/*url:url+'/ynActivity/lottery',*/
	    		url:pathUrl+'/ynActivity/lottery',
	    		method:'post',
	    		data:JSON.stringify(param),
	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
	    	}).success(function(json){
	    		if(json.code=='0000') {
	    			if(fn){fn(json.data);}
				}else if(json.code == '2109' || json.code == '2103'){
					error(json.msg);
				}else if(json.code == '2001-0009'){
					checkIsLottery(json.msg);
				}else {
					not();
				}
	    	}).error(function(msg){
	    		alert(msg);
	    	});
		},
		
		getArea : function(id , fn){
			$http({
				url:pathUrl+"/ynAddress/getZoneByParentId?parentId="+id,
				method:'get',
			}).success(function(json){
				if(json.code=='0000'){
					fn(json.data);
				}else{
					alert(json.msg);
				}
			});
		},
		
		getHistoricalAddress : function(fn){
			$http({
				/*url:url+"/ynAddress/getHistorical?openId=oYwB5tyECaXd9dTqukcIhjQOGnRY",*/
				url:pathUrl+"/ynAddress/getHistorical?openId="+localStorage.getItem("openId"),
				method:'get',
			}).success(function(json){
				if(json.code == '0000'){
					if(fn){fn(json.data);}
				}else{
					/*alert(json.msg);*/
				}
			});
		},
		
		sendMsg : function(cellphone){
			$http({
				url:pathUrl+"/ynCustomer/sendSmsCode",
				data:JSON.stringify({'cellphone':cellphone,"openId":localStorage.getItem("openId")}),
				method:'post',
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				if(json.code != 0000){
					alert(json.msg);
				}
			});
		},
		
		getBound : function(fn){
			$http({
				url:pathUrl+"/ynCustomer/getBound?openId="+localStorage.getItem("openId"),
				method:'get',
			}).success(function(json){
				try{
					if(fn){fn(json);}
				}catch(e){
					alert(e.message);
				}
				
			});
		},
		
		awardVerification : function(awardVerificationUrl , param , fn , errorFn){
			$http({
				url:awardVerificationUrl,
				data:JSON.stringify(param),
				method:'post',
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				if(json.code == 0000){
					if(fn){fn(json.data);}
				}else{
					errorFn();
					alert(json.msg);
				}
			});
		},
		
		getUnclaimed : function(fn){
			$http({
				/*url:url+"/ynAward/getUnclaimed?openId=oYwB5t_JblWHsohwSfZXEHUSUFNo",*/
				url:pathUrl+"/ynAward/getUnclaimed?openId="+localStorage.getItem("openId"),
				method:'get',
			}).success(function(json){
				if(json.code == '0000'){
					if(fn){fn(json.data);}
				}
			});
		},
		
		getActgoods : function(fn){
			$http({
				url:pathUrl+"/actgoods/getActgoods?qrCode="+localStorage.getItem("shopQRCode"),
				method:'get',
			}).success(function(json){
				try{
					if(fn){fn(json);}
				}catch(e){
					alert(e.message);
				}
				
			});
		},
		
		checkIsLottery : function(billNo,fn){
			$http({
				url:pathUrl+"/scActivity/checkIsLottery?billNo="+billNo+"&openId="+localStorage.getItem("openId"),
				method:'get',
			}).success(function(json){
				if(json.code == '2001-0009'){
					fn(json.msg);
				}
				
			});
		},
		
		receiveAward : function(param , fn){
			$http({
				url:pathUrl+"/scAward/receiveAward",
				data:JSON.stringify(param),
				method:'post',
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				if(json.code == 0000){
					if(fn){fn();}
				}else{
					alert(json.msg);
				}
			});
		},
		
		checkIsDeductible : function(param , success , fn){
			$http({
				url:pathUrl+"/scCoupon/checkIsDeductible",
				data:JSON.stringify(param),
				method:'post',
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				if(json.code == 0000){
					if(success){success(json.data);}
				}else{
					if(fn){fn();}
				}
			});
		}
		
	};
});
