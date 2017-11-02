/*var animateApp = angular.module('animateApp', ['ngRoute', 'ngAnimate']);
animateApp.config(function($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: './html/TONG.html',
            controller: 'mainController'
        })
        .when('/msx', {
            templateUrl: './html/max.html',
            controller: 'mainController'
        })
        .when('/sst', {
            templateUrl: './html/sst.html',
            controller: 'savsvas'
        })
});*/
animateApp.controller('mainController',function ($scope,$http) {

   /* $scope.att = att;
   function att() { //显示隐藏
       $scope.kou=true;
   }
    $scope.atts = atts;
    function atts() { //显示隐藏
        $scope.kou=false;
    }
    $scope.reset = function(){
        $scope.email = "yiibai.com@gmail.com";
    };
    $scope.reset();*/


   $scope.pageClass='page-home';
    $http({
        method  : 'get',
        url     : 'http://gank.io/api/search/query/listview/category/%E7%A6%8F%E5%88%A9/count/10/page/1'
       // params    :{bookName:$scope.book.bookName}// 传递数据作为字符串，从前台传到后台
    }).success(function(data) {
        console.log(data.results);
        $scope.names = data.results;
    }).error(function(data,status,headers,config){
      //  alert(data);
    });
});
var animateApp = angular.module("animateApp", ["ui.router"]);
//这里叫做App模块，这将告诉HTML页面这是一个AngularJS作用的页面，并把ui-router注入AngularJS主模块，它的内容由AngularJS引擎来解释。
animateApp.config(function ($stateProvider, $urlRouterProvider) {
    //这一行声明了把 $stateProvider 和 $urlRouteProvider 路由引擎作为函数参数传入，这样我们就可以为这个应用程序配置路由了.
    $urlRouterProvider.when("", "/course");//默认的页面
    //如果没有路由引擎能匹配当前的导航状态，默认将路径路由至 PageTab.html, 那它就像switch case语句中的default选项.就是一个默认的视图选项
    $stateProvider
    //这一行定义了会在main.html页面第一个显示出来的状态（就是进入页面先加载的html），作为页面被加载好以后第一个被使用的路由.
        .state("course", {
            url: "/course",
            templateUrl: "./html/sta.html"
        })
        .state("PageTab", {
            url: "/PageTab",
            templateUrl: "./html/TONG.html"
        })

    /*   .state("PageTab", {
           url: "/PageTab",//#+标识符，这里就是url地址栏上面的标识符，通过标识符，进入不同的html页面
           templateUrl: "html/TONG.html"//这里是html的路径，这是跟标识符相对应的html页面
       })
       .state("PageTab.Page1", {//引号里面代表Page1是PageTab的子页面，用.隔开
           url:"/Page1",
           templateUrl: "./html/sst.html"
       })
       .state("PageTab.Page2", {//需要跳转页面的时候，就是用这双引号里面的地址
           url:"/Page2",
           templateUrl: "./html/max.html"
       })*/
});
animateApp.directive("hello", function () {//js模块加载
    return {
        restrict: 'E',
        template: '<div>Hi everyone!</div>',
        replace: true
    }
});
animateApp.controller("homeCtrl", function ($scope, $http) {
    $http({
        url: "../tsconfig.json",
        method: "post",
        // data : {"pageSize":20,"pageNumber":pageNumber,"crtDate":$scope.time,"custId":$scope.custId}
    }).success(function (data) {
        // console.log(data[0].RollNo);
    });
});
animateApp.controller("appl", function ($scope) {
    $scope.log = function () {
        alert("你好")
    };
    $scope.gou = function () {
        alert("你ssssss好")
    }
});
animateApp.directive("enter", function () {
    return function (scope, element, attrs) {
        console.log(element);
        /*  element.bind('mouseenter',function () {//调用上面的方法 事件
              scope.$apply(attrs.enter);
          })*/
        var ppt = 2;
        if (ppt == 1) {
            element.html("我是改过的")
        } else {
            element.html("我是改过的0000")
        }
    }
});













