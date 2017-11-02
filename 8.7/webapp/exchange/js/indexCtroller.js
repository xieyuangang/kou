/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("payCtrl" , function($scope , $http , tool , $rootScope , Interface){
	tool.updateTitle(localStorage.getItem('shopName'));
	
	$(".ad").height($(window).height() - 438);

	Interface.getIntegralCustomer('openId='+localStorage.getItem("openId"),function(json){
		if(json.code == '00' && json.data){
			$scope.account = json.data.cellphone;
			Interface.getIntergralAppointBalance("payId="+localStorage.getItem("openId")+"&qrCode="+localStorage.getItem("shopQRCode"),function(json){
				$scope.point = json.data.personAllIntegralNum;
				$scope.receiveSuccess = true;
			});
		}else{
			$scope.account = "未绑定";
			$scope.point = 0;
		}
	});
	
	$scope.inputNum = function(amount){
		var rg = /^([1-9]\d{0,9}|0)([.]?|(\.\d{1,2})?)$/;
		var val = ($scope.amount ? $scope.amount : "") + amount;
		if(!rg.test(val)){return;}
        $scope.amount = val;
    };

    $scope.del = function(){
        var money = $scope.amount;
        if(money != ''){
        	$scope.amount = money.substring(0 , money.length-1);
        };
    };
    
    $scope.surePay = surePay;
    
    function surePay(){
    	var money = $scope.amount;
    	
    	if(!money && money<=0){
    		alert("请输入积分");
    	}else if($scope.integralNum < money){
    		alert("积分余额不足");
    	}else{
    		$scope.surePay = null;
    		Interface.consumeIntegral({
    			'integralPoint':money,
    			"qrCode" : localStorage.getItem("shopQRCode"),
    			'openId':localStorage.getItem("openId"),
    		} , function(json){
    			if(json.code == '00'){
    				$rootScope.urlImg = $scope.url +"/pay/images/success.png";
    				$rootScope.stateMsg = '兑换成功';
    				$rootScope.amount = money;
    			}else{
    				$rootScope.urlImg = $scope.url +"/pay/images/error.jpg";
    				$rootScope.stateMsg = '兑换失败,'+json.msg;
    				$rootScope.amount = '0';
    			}
    			location.hash = '/result';
    		});
    	}
    };
    
});

myApp.controller("resultCtrl" , function($scope , $http , tool , $rootScope , Interface){
	tool.updateTitle(localStorage.getItem('shopName'));
	tool.createIscroll("result");

	Interface.getIntegralCustomer('openId='+localStorage.getItem("openId"),function(json){
		if(json.code == '00'){
			Interface.getIntergralAppointBalance("payId="+localStorage.getItem("openId")+"&qrCode="+localStorage.getItem("shopQRCode"),function(json){
				$scope.point = json.data.personAllIntegralNum;
				$scope.receiveSuccess = true;
			});
		}
	});
	
	var ua = navigator.userAgent.toLowerCase();
	if(ua.match(/micromessenger/i) == "micromessenger"){
		$scope.wxShow = true;
		$scope.alipayShow = false;
	}else if (ua.match(/alipayclient/i) == "alipayclient"){
		$scope.wxShow = false;
		$scope.alipayShow = true;
	}
	
	$scope.num = 0;
	if($rootScope.stateMsg == '兑换成功'){
		$("#repayment").hide();
		$("#btn").show();
	}else{
		$("#repayment").show();
		$("#btn").hide();
		$("#getPointBox").hide();
		$("#settlementList").hide();
		$("#evaluateBox").hide();
	}
	
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
			Interface.evaluate($scope.num , function(){
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
	};
	
	/*Interface.comments(function(json){
    	$scope.commentAvgScore = json.data.commentAvgScore;
    	$scope.commentSum = json.data.commentSum;
    });*/
	
	$scope.repayment = function(){
		location.hash = '/pay';
	};
	
});