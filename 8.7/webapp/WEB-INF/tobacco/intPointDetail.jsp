<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp"  ng-init="ctx='${ctx}';custMd5='${custMd5 }';typeText='积分兑换';operType='1';title='积分兑换明细';custId='${custId }'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title>红码</title>
    <link href="${ctx }/hm/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${ctx }/hm/css/index.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx }/hm/js/angular.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/angular-ui-router.js"></script>
    <script type="text/javascript">
    	var url = '${ctx}';
    </script>
    <script type="text/javascript" src="${ctx }/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/app.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/factory.js"></script>
    <script type="text/javascript">
	    myApp.config(function($stateProvider , $urlRouterProvider){
	    	$urlRouterProvider.otherwise("/intPointDetail");
	
	    	$stateProvider.state('intPointDetail' , {
	    		url : '/intPointDetail',
	    		templateUrl : url+'/hm/html/intPointDetail.html',
	    	});
	    });
	    
	    myApp.controller("detailListCtrl" , function($scope , $http , tool , Home){
	    	document.getElementById("listBox").style.height = document.body.clientHeight - 50 + "px";
	    	
	    	tool.createIscroll("listBox");
	    	
	    	initTime($scope , Home);
	    	
	    	$scope.select = function(){
	    		var times = $scope.timeSelect.split("-");
	    		document.getElementById("timeText").innerHTML = times[1];
	    		Home.retailPoint(times[0] , $scope.custId , $scope);
	    	};
	    	
	    });
	    
	    function initTime($scope , obj){
	    	var date = new Date();
	    	var year = date.getFullYear();
	    	var month = date.getMonth()+1;
	    	var select = document.getElementsByClassName("timeSelect")[0];
	    	var options = "";
	    	for(var i = month;i > 0; i--){
	    		var m = i.toString().length == 2?i:"0"+i.toString();
	    		var v = year+""+m+"-"+year+"年"+m+"月";
	    		options += "<option value='"+v+"'>"+year+"年"+m+"月</option>";
	    		if(i == month){
	    			document.getElementById("timeText").innerHTML = year+"年"+m+"月";
	    			obj.retailPoint(year+""+m , $scope.custId , $scope);
	    			
	    		};
	    	}
	    	select.innerHTML = options;
	    };
    </script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>