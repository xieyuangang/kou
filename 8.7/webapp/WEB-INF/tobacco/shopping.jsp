<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp"  ng-init="ctx='${ctx}';custId='${custId }';point='${point }';cellPhone='${cellphone }'">
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
	    	$urlRouterProvider.otherwise("/shopping");
	
	    	$stateProvider.state('shopping' , {
	    		url : '/shopping',
	    		templateUrl : url+'/hm/kfdPage/shopping.html',
	    		cache: false,
	    	});
	    });
	    
	    myApp.controller("shoppingCtrl" , function($scope , $http , tool){
	    	initList();
	    	
	    	function initList(){
	    		$http({
	    			url:url+"/goods/getGoodsList",
	    			method:'post',
	    		}).success(function(json){
	    			$scope.goodsList = json.goodsList;
	    			if(json.customer){
	    				$scope.userMsg = true;
	    				$scope.cellPhone = json.customer.cellphone;
	    				$scope.point = json.customer.point != null ? json.customer.point : 0;
	    			}else{
	    				$scope.inputPhone = true;
	    			}
	    		});
	    	}
	    	
	    	
	    	$scope.pointChange = function(){
	    		alert("暂未开通，敬请期待！");
	    		/* document.getElementById("dialog").style.display = "block";
	    		$scope.imgUrl = this.g.imgUrl;
	    		$scope.goodName = this.g.goodName;
	    		$scope.goodPoint = this.g.point;
	    		$scope.goodId = this.g.id; */
	    	};
	    	
	    	$scope.jian = function(){
	    		if(Number($scope.num) > 0){
	    			$scope.num = Number($scope.num) - 1;
	    		}
	    		$scope.needPoint = $scope.num*$scope.goodPoint;
	    	};
	    	
	    	$scope.jia = function(){
	    		$scope.num = Number($scope.num) + 1;
	    		$scope.needPoint = $scope.num*$scope.goodPoint;
	    	};
	    	
	    	$scope.sub = sub;
	    	function sub(){
	    		if($scope.num > 0){
	    			$scope.sub = null;
	    			$http({
	    				url:url+"/pointchange/pointChange",
	    				data:{"custCellphone":$scope.cellPhone,"goodId":$scope.goodId,"goodsNum":$scope.num,"custId":$scope.custId},
	    				method:'post',
	    			}).success(function(json){
	    				if(json.code == 200){
	    					alert("兑换成功");
	    					document.getElementById("dialog").style.display = "none";
	    				}else{
	    					alert("兑换异常");
	    				};
	    				$scope.sub = sub;
	    			});
	    		}else{
	    			alert("请选择数量");
	    		}
	    		
	    	};
	    });
    </script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>