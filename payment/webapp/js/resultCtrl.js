var myApp = angular.module('myApp', []);

myApp.controller('resultCtrl', ['$scope', '$location', '$window', function($scope, $location, $window){

	let isOk = $window.localStorage['isOk'];
	if(isOk === 'true'){
		$scope.isOk = true;
	} else if(isOk === 'false') {
		$scope.isOk = false;
	}

	//确定付款按钮
	$scope.backBtn = function(){
		$window.location.href = './page_one.html';
	};

	
}])