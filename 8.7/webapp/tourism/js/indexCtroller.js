/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("payCtrl" , function($scope , $http , tool , $rootScope , Interface){
	tool.updateTitle(localStorage.getItem('shopName'));
	
	$(".ad").height($(window).height() - 398);
	
	Interface.getIntergralAppointBalance("payId="+localStorage.getItem("openId")+"&qrCode="+localStorage.getItem("shopQRCode"),function(json){
		$scope.prompt = json.data.meesage;
		$scope.personAllIntegralNum = json.data.personAllIntegralNum;
		$scope.floorIntegral = json.data.floorIntegral;
		$scope.usable = json.data.usable;
		$scope.floorSum = json.data.floorSum;
	});
	
	
	var watch = $scope.$watch('amount',function(newValue,oldValue, scope){//方法调用页面
		var rg = /^([1-9]\d{0,9}|0)([.]?|(\.\d{1,2})?)$/;
		if(newValue != null){
			if(!rg.test(newValue)){
				$scope.amount = oldValue;
			}
		}
		
		if(newValue){
			var personAllIntegralNum = Number($scope.personAllIntegralNum);
			var floorIntegral = Number($scope.floorIntegral);
			var a = Math.floor($scope.amount / $scope.floorSum);
			var syIntegral = floorIntegral*a;
			if(personAllIntegralNum >= syIntegral){
				$scope.total = Number($scope.amount) -(syIntegral/100);
				$scope.useIntegral = syIntegral;
			}else{
				var num = Math.floor(personAllIntegralNum / floorIntegral);
				$scope.total = Number($scope.amount) -((floorIntegral*num)/100);
				$scope.useIntegral = floorIntegral*num;
			}
		}else{
			$scope.total = '0.00';
		}
		
	});

    $scope.surePay = surePay;
    
    function surePay(){//----
    	var money = $scope.amount;
    	if(!money && money<0){
    		alert("请输入0元以上的支付金额");
    	}else{
    		$scope.surePay = null;
    		var payWay = "00";
    		var payUrl = "/pay/prepay";
    		var ua = navigator.userAgent.toLowerCase();
    		
    		/*if(ua.match(/micromessenger/i) == "micromessenger"){
    			payWay = "00";
    		}else if (ua.match(/alipayclient/i) == "alipayclient"){
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
    		
    		Interface.pay(money , payUrl , payWay , $scope.activityCode , $scope.usable , '00' , $scope.useIntegral , function(){
    			$scope.surePay = surePay;
    		});
    	}
    };
});

myApp.controller("resultCtrl" , function($scope , $http , tool , $rootScope , Interface){
	Interface.config();
	
	tool.updateTitle(localStorage.getItem('shopName'));
	tool.createIscroll("result");
	
	var ua = navigator.userAgent.toLowerCase();
	if(ua.match(/micromessenger/i) == "micromessenger"){
		$scope.wxShow = true;
		$scope.alipayShow = false;
	}else if (ua.match(/alipayclient/i) == "alipayclient"){
		$scope.wxShow = false;
		$scope.alipayShow = true;
	}
	
	$scope.num = 0;
	
	$(".scoreImg").click(function(){
		var index = $(this).index();
		$scope.num = index+1;
		$(".scoreImg").each(function(){
			if($(this).index() <= index){
				$(this).attr("src",$scope.url+"/pay/images/score_choose.png");
			}else{
				$(this).attr("src",$scope.url+"/pay/images/score.png");
			}
		});
	});
	
	$scope.evaluate = evaluate;
	
	function evaluate(){
		if($scope.num == 0){
			alert("请选择分数");
		}else{
			$scope.evaluate = null;
			Interface.evaluate($scope.num , $scope.id , function(){
				$("#btn").css("background","#89D6E9");
				alert("提交成功");
				Interface.comments(function(json){
			    	$scope.commentAvgScore = json.data.commentAvgScore;
			    	$scope.commentSum = json.data.commentSum;
			    });
			});
		}
	}
	
	$scope.close = function(){
		$scope.getPoint = false;
		$("#getPointBox").hide();
	};
	
	Interface.comments(function(json){
    	$scope.commentAvgScore = json.data.commentAvgScore;
    	$scope.commentSum = json.data.commentSum;
    });
	
	Interface.query(function(json){
		try{
			var rg = /成功/g;
			if(rg.test(json.data.stateMsg)){
				Interface.getIntegralCustomer('openId='+localStorage.getItem("openId"),function(json){
					if(json.data){
						$scope.btn2 = true;
						$scope.cellphone = json.data.cellphone;
					}else{
						$scope.btn1 = true;
					}
				});
				
				Interface.produceIntergral({
					"qrCode" : localStorage.getItem("shopQRCode"),
					"orderNum" : localStorage.getItem("outTradeNo"),
					"type" : "1",
				},function(json){
					if(json.data.status == '1' && json.data.integralPoint != 0){
						$("#getPointBox").show();
						$scope.getPoint = true;
						$scope.receivePoint = true;
					}
					$scope.id = json.data.id;
					$scope.integralPoint = json.data.integralPoint;
				});
				
				$scope.urlImg = $scope.url +"/pay/images/success.png";
				$("#repayment").hide();
				$("#btn").show();
			}else{
				$("#repayment").show();
				$("#btn").hide();
				$("#getPointBox").hide();
				$("#settlementList").hide();
				$("#evaluateBox").hide();
				$scope.urlImg = $scope.url +"/pay/images/error.jpg";
			}
			$scope.stateMsg = json.data.stateMsg;
			$scope.amount = json.data.amount / 100;
			$scope.transTime = json.data.transTime;
			$scope.coupon = json.data.coupon / 100;
			$scope.payAmount = json.data.payAmount / 100;
		}catch(e){alert(e)};
	});
	
	$scope.receive = receive;
	
	function receive(type){
		var payType = "";
		var ua = navigator.userAgent.toLowerCase();
		if(ua.match(/micromessenger/i) == "micromessenger"){
			payType = "0";
		}else if (ua.match(/alipayclient/i) == "alipayclient"){
			payType = "1";
		}
		var rg = /^1[3|4|5|8][0-9]\d{8}$/;
		if(!$scope.cellphone && type=='phone' || !rg.test($scope.cellphone) && type=='phone'){
			alert("请输入正确的手机号后领取");
		}else{
			$scope.receive = null;
			Interface.addIntegral({
				"cellphone" : $scope.cellphone,
				"openId" : localStorage.getItem("openId"),
				"qrCode" : localStorage.getItem("shopQRCode"),
				"qrName" : localStorage.getItem("shopName"),
				"id" : $scope.id,
				"payType" : payType,
			},function(json){
				$scope.receivePoint = false;
				Interface.getIntergralAppointBalance("payId="+localStorage.getItem("openId")+"&qrCode="+localStorage.getItem("shopQRCode"),function(json){
					$scope.integralNum = json.data.personAllIntegralNum;
					$scope.receiveSuccess = true;
				});
			});
		}
	}
	
	var shareUrl = location.protocol+'//'+location.hostname+'/shop/integral/getMerchantQrCodeUrl?qrCode='+localStorage.getItem("shopQRCode");
	Interface.onMenuShareTimeline({
		link:shareUrl,
		title:localStorage.getItem('shopName'),
		success:function(){
			location.hash = '/shareSuccess';
		},
		cancel:function(){
			
		}
	});
	
	$scope.repayment = function(){
		location.hash = '/pay';
	};
});

myApp.controller("shareCtrl" , function($scope , $http , tool , $rootScope , Interface){
	try{
		tool.updateTitle(localStorage.getItem('shopName'));
		tool.createIscroll("sharescroll");
		
		var ua = navigator.userAgent.toLowerCase();
		if(ua.match(/micromessenger/i) == "micromessenger"){
			$scope.wxShow = true;
			$scope.alipayShow = false;
		}else if (ua.match(/alipayclient/i) == "alipayclient"){
			$scope.wxShow = false;
			$scope.alipayShow = true;
		}
		
		Interface.produceIntergral({
			"qrCode" : localStorage.getItem("shopQRCode"),
			"orderNum" : localStorage.getItem("outTradeNo"),
			"type" : "2",
		},function(json){
			if(json.data.status == '1' && json.data.integralPoint != 0){
				$("#getPointBox").show();
				$scope.getPoint = true;
				$scope.receivePoint = true;
			}else{
				$("#getPointBox").hide();
			}
			$scope.id = json.data.id;
			$scope.integralPoint = json.data.integralPoint;
		});
		
		Interface.getIntegralCustomer('openId='+localStorage.getItem("openId"),function(json){
			if(json.data){
				$scope.btn2 = true;
				$scope.cellphone = json.data.cellphone;
			}else{
				$scope.btn1 = true;
			}
		});
		
		$scope.receive = receive;
		
		function receive(type){
			var payType = "";
			var ua = navigator.userAgent.toLowerCase();
			if(ua.match(/micromessenger/i) == "micromessenger"){
				payType = "0";
			}else if (ua.match(/alipayclient/i) == "alipayclient"){
				payType = "1";
			}
			var rg = /^1[3|4|5|8][0-9]\d{8}$/;
			if(!$scope.cellphone && type=='phone' || !rg.test($scope.cellphone) && type=='phone'){
				alert("请输入正确的手机号后领取");
			}else{
				$scope.receive = null;
				Interface.addIntegral({
					"cellphone" : $scope.cellphone,
					"openId" : localStorage.getItem("openId"),
					"qrCode" : localStorage.getItem("shopQRCode"),
					"qrName" : localStorage.getItem("shopName"),
					"id" : $scope.id,
					"payType" : payType,
				},function(json){
					$scope.receivePoint = false;
					Interface.getIntergralAppointBalance("payId="+localStorage.getItem("openId")+"&qrCode="+localStorage.getItem("shopQRCode"),function(json){
						$scope.integralNum = json.data.personAllIntegralNum;
						$scope.receiveSuccess = true;
					});
				});
			}
		}
		
		$scope.close = function(){
			$scope.getPoint = false;
			$("#getPointBox").hide();
		};
	}catch(e){
		alert(e.message);
	}
});


