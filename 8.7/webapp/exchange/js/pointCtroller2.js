/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("currPointCtrl" , function($scope , $http , tool , $rootScope , Interface){
	
	document.getElementById("wapper").style.height = document.body.offsetHeight - 218 + "px";
	var currTime = new Date();
	$scope.y = currTime.getFullYear();
	$scope.m = (currTime.getMonth()+1)>9?currTime.getMonth()+1:"0"+(currTime.getMonth()+1);
	$scope.d = currTime.getDate() > 9 ? currTime.getDate() : "0"+(currTime.getDate());
	$scope.timeText = $scope.y+"年"+$scope.m+"月"+$scope.d+"日";
	showList($scope.y+"-"+$scope.m+"-"+$scope.d);
	
	$scope.toMore = function(){
		location.hash = '/more';
	}
	
	
	$("#date").change(function(){//点击时间改变值
		var v = $(this).val()
		var s = v.split("-");
		var v = $("input[name='radioTime']:checked").val();
		if(v == 0){
			$scope.y = s[0];
			$scope.m = s[1];
			$scope.d = s[2];
			$scope.timeText = s[0]+"年"+s[1]+"月"+s[2]+"日";
			showList(s[0]+"-"+s[1]+"-"+s[2])
		}else{
			$scope.y = s[0];
			$scope.m = s[1];
			$scope.timeText = s[0]+"年"+s[1]+"月";
			showList(s[0]+"-"+s[1])
		}
	});
	
	
	function showList(date){//数据交互
		Interface.getIntegralDeductionDetail("memberId="+$scope.memberId+"&date="+date,function(json){
			if(json.code == '0000'){
				$scope.rows = json.data.list.rows;
				$scope.tradeNum = json.data.tradeNum + "笔";
				$scope.totalAmtCount = json.data.totalAmtCount || 0;
				$scope.actualAmtCount = json.data.actualAmtCount;
				$scope.integralTotal = json.data.integralTotal ;
			}else{
				$scope.rows = [];
				$scope.tradeNum = "0笔";
				$scope.totalAmtCount = 0;
				$scope.actualAmtCount = 0;
				$scope.integralTotal = 0;
			}
			setTimeout(() => {
				tool.createIscroll("wapper");
			}, 10);
			//console.log(json)
	
		});
	}
	
	$scope.ha=function(data){//月份点击改变
		if(data==0){
			$scope.timeText = $scope.y+"年"+$scope.m+"月"+$scope.d+"日";
			showList($scope.y+"-"+$scope.m+"-"+$scope.d);
		}else{
			$scope.timeText = $scope.y+"年"+$scope.m+"月";
			showList($scope.y+"-"+$scope.m);
		}
	}
	
});