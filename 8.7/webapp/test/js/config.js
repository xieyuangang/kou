myApp.config(function($stateProvider , $urlRouterProvider){
	var provider = "";
	if(toPage == 'tobacco'){
		provider = "/home/activity_one";
	}else if(toPage == 'chongqing'){
		provider = "/home/activity_two";
	}else if(toPage == 'scCoupon'){
		provider = "/home/activity_three";
	}else if(toPage == 'scCoupon2'){
		provider = "/home/activity_Four";
	}
	$urlRouterProvider.otherwise(provider);
	$stateProvider.state('home' , {
		url : '/home',
		templateUrl : url+'/test/html/home.html',
	}).state('more' , {
		url : '/more',
		templateUrl : url+'/test/html/more.html',
	}).state('myOrder' , {
		url : '/myOrder',
		templateUrl : url+'/test/html/myOrder.html',
		cache: false,
	}).state('pointDetail' , {
		url : '/pointDetail',
		templateUrl : url+'/test/html/pointDetail.html',
	}).state('shopping' , {
		url : '/shopping',
		templateUrl : url+'/test/html/shopping.html',
	}).state('success' , {
		url : '/success',
		templateUrl : url+'/test/html/success.html',
	}).state('deductible' , {
		url : '/deductible',
		templateUrl : url+'/test/html/deductible.html',
	}).state('activityPay' , {
		url : '/activityPay',
		templateUrl : url+'/test/html/activityPay.html',
	}).state('paySuccess' , {
		url : '/paySuccess',
		templateUrl : url+'/test/html/paySuccess.html',
	}).state('discount' , {
		url : '/discount',
		templateUrl : url+'/test/html/discount.html',
	}).state('address' , {
		url : '/address',
		templateUrl : url+'/test/html/address.html',
	}).state('subSuccess' , {
		url : '/subSuccess',
		templateUrl : url+'/test/html/subSuccess.html',
	}).state('notReceived' , {
		url : '/notReceived',
		templateUrl : url+'/test/html/notReceived.html',
	}).state('home.activity_one' , {
		url : '/activity_one',
		templateUrl : url+'/test/activity/activity_one.html',
	}).state('home.activity_two' , {
		url : '/activity_two',
		templateUrl : url+'/test/activity/activity_two.html',
	}).state('couponPay' , {
		url : '/couponPay',
		templateUrl : url+'/test/html/couponPay.html',
	}).state('home.activity_three' , {
		url : '/activity_three',
			templateUrl : url+'/test/activity/activity_three.html',
	}).state('home.activity_Four' , {
		url : '/activity_Four',
		templateUrl : url+'/test/activity/activity_Four.html',
	});
});