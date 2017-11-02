myApp.config(function($stateProvider , $urlRouterProvider){
	$urlRouterProvider.otherwise("/goodsList");

	$stateProvider.state('goodsList' , {
		url : '/goodsList',
		templateUrl : url+'/xunzhang/html/goodsList.html',
	}).state('order' , {
		url : '/order',
		templateUrl : url+'/xunzhang/html/order.html',
	}).state('address' , {
		url : '/address',
		templateUrl : url+'/xunzhang/html/address.html',
	}).state('record' , {
		url : '/record',
		templateUrl : url+'/xunzhang/html/record.html',
	}).state('addressList' , {
		url : '/addressList',
		templateUrl : url+'/xunzhang/html/addressList.html',
	}).state('result' , {
		url : '/result',
		templateUrl : url+'/xunzhang/html/result.html',
	});
});