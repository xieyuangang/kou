myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/course");

	$stateProvider.state('course' , {
		url : '/course',
		templateUrl : '../html/course.html',
	}).state('register' , {
		url : '/register',
		templateUrl : '../html/pages/register.html',
	}).state('addShop' , {
		url : '/addShop',
		templateUrl : '../html/pages/addShop.html',
	}).state('addClerk' , {
		url : '/addClerk',
		templateUrl : '../html/pages/addClerk.html',
	}).state('eAccount' , {
		url : '/eAccount',
		templateUrl : '../html/pages/eAccount.html',
	}).state('payee' , {
		url : '/payee',
		templateUrl : '../html/pages/payee.html',
	});
});