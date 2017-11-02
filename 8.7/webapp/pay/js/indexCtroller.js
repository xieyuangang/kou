/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("payCtrl" , function($scope , $http , tool , $rootScope , Interface){
	tool.updateTitle(localStorage.getItem('shopName'));
	
	$(".ad").height($(window).height() - 398);
	
	$scope.inputNum = function(amount){
        $scope.amount = ($scope.amount ? $scope.amount : "") + amount;
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
    		alert("请输入0元以上的支付金额");
    	}else{
    		$scope.surePay = null;
    		Interface.pay(money , function(){
    			$scope.surePay = surePay;
    		});
    	}
    };
    
    Interface.comments(function(json){
    	$scope.commentAvgScore = json.data.commentAvgScore;
    });
});

myApp.controller("resultCtrl" , function($scope , $http , tool , $rootScope , Interface){
	tool.updateTitle(localStorage.getItem('shopName'));
	tool.createIscroll("result");
	
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
	
	Interface.comments(function(json){
    	$scope.commentAvgScore = json.data.commentAvgScore;
    	$scope.commentSum = json.data.commentSum;
    });
	
	Interface.query(function(json){
		try{
			var rg = /成功/g;
			if(rg.test(json.data.stateMsg)){
				$scope.urlImg = $scope.url +"/pay/images/success.png";
			}else{
				$scope.urlImg = $scope.url +"/pay/images/error.jpg";
			}
			$scope.stateMsg = json.data.stateMsg;
			$scope.amount = json.data.amount / 100;
			$scope.transTime = json.data.transTime;
			$scope.coupon = json.data.coupon / 100;
			$scope.payAmount = json.data.payAmount / 100;
		}catch(e){alert(e)};
	});
});


