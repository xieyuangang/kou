myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/pay");

	$stateProvider.state('pay' , {
		url : '/pay',
		templateUrl : url+'/pay/html/pay.html',
	}).state('result' , {
		url : '/result',
		templateUrl : url+'/pay/html/result.html',
	});
});