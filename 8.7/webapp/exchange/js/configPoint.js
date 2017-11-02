myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/currPoint");

	$stateProvider.state('currPoint' , {
		url : '/currPoint',
		templateUrl : url+'/exchange/html/currPoint.html',
	}).state('more' , {
		url : '/more',
		templateUrl : url+'/exchange/html/more.html',
	});
});