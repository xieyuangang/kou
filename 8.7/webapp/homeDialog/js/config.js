myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/home");

	$stateProvider.state('home' , {
		url : '/home',
		templateUrl : url+'/homeDialog/html/home.html',
	}).state('detail' , {
		url : '/detail',
		templateUrl : url+'/homeDialog/html/detail.html',
	});
});