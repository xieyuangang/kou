<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp"  ng-init="ctx='${ctx}';custMd5='${custMd5 }';typeText='红码收款';operType='1';title='红码收款明细';custId='${custId }'">
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
	    	$urlRouterProvider.otherwise("/detailList");
	
	    	$stateProvider.state('detailList' , {
	    		url : '/detailList',
	    		templateUrl : url+'/hm/html/detailList.html',
	    	});
	    });
	    
	    myApp.controller("detailListCtrl" , function($scope , $http , tool , Home){
	    	document.getElementById("listBox").style.height = document.body.clientHeight - 100 + "px";
	    	
	    	tool.createIscroll("listBox");
	    	
	    	$scope.successCount = 0;
			$scope.successSum = 0;
	    	
	    	initTime($scope , Home);
	    	
	    	$scope.$watch('timeSelect' , function(newValue,oldValue, scope){
	    		if(newValue){
	    			var date = new Date(newValue);
	    			var year = date.getFullYear();
	    	    	var month = date.getMonth()+1;
	    	    	var day = date.getDate();
	    	    	var m = month.toString().length == 2?month:"0"+month.toString();
	    	    	var d = day.toString().length == 2?day:"0"+day.toString();
	    	    	document.getElementById("timeText").innerHTML = year+"年"+m+"月"+d+"日";
	    	    	Home.getOrderList(year+""+m+""+d, $scope.custId , $scope);
	    		}
	    	});
	    	
	    });
	    
	    function initTime($scope , obj){
	    	var date = new Date();
	    	var year = date.getFullYear();
	    	var month = date.getMonth()+1;
	    	var day = date.getDate();
	    	var m = month.toString().length == 2?month:"0"+month.toString();
	    	var d = day.toString().length == 2?day:"0"+day.toString();
	    	document.getElementById("timeText").innerHTML = year+"年"+m+"月"+d+"日";
	    	obj.getOrderList(year+""+m+""+d, $scope.custId , $scope);
	    };
    </script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>