myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/pay");

	$stateProvider.state('pay' , {
		url : '/pay',
		templateUrl :'Template.html',
	}).state('result' , {
		url : '/result',
		templateUrl : url+'/xiaochi/html/result.html',
	}).state('shareSuccess' , {
		url : '/shareSuccess',
		templateUrl : url+'/xiaochi/html/shareSuccess.html',
	}).state('page1' , {
		url : '/page1',
		templateUrl : url+'/xiaochi/pages/page1.html',
	}).state('page2' , {
		url : '/page2',
		templateUrl : url+'/xiaochi/pages/page2.html',
	});
});