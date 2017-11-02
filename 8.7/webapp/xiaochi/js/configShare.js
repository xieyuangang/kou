myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/share");

	$stateProvider.state('share' , {
		url : '/share',
		templateUrl : url+'/tourism/share/share.html',
	}).state('evaluate' , {
		url : '/evaluate',
		templateUrl : url+'/tourism/share/evaluate.html',
	}).state('images' , {
		url : '/images',
		templateUrl : url+'/tourism/share/images.html',
	});
});