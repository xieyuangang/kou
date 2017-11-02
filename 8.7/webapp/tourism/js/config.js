myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/pay");

	$stateProvider.state('pay' , {
		url : '/pay',
		templateUrl : url+'/tourism/html/pay.html',
	}).state('result' , {
		url : '/result',
		templateUrl : url+'/tourism/html/result.html',
	}).state('shareSuccess' , {
		url : '/shareSuccess',
		templateUrl : url+'/tourism/html/shareSuccess.html',
	}).state('page1' , {
		url : '/page1',
		templateUrl : url+'/tourism/pages/page1.html',
	}).state('page2' , {
		url : '/page2',
		templateUrl : url+'/tourism/pages/page2.html',
	});
});