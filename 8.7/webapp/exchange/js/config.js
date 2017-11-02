myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/pay");

	$stateProvider.state('pay' , {
		url : '/pay',
		templateUrl : url+'/exchange/html/pay.html',
	}).state('result' , {
		url : '/result',
		templateUrl : url+'/exchange/html/result.html',
	});
});