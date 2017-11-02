myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/currPoint");

	$stateProvider.state('currPoint' , {
		url : '/currPoint',
		templateUrl : url+'/exchange/html/currPointDeduction.html',
	})
});