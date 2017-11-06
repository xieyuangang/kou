var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/nav');
    $stateProvider.state('nav', {
        url: '/nav',
        templateUrl: './html/donm1.html'
    })
        .state('producer', {
            url: '/producer',
            templateUrl: './html/ShoppingCart.html',
            controller: 'ProducersCtrl'
        })
        .state('payment', {
            url: '/payment',
            templateUrl: './html/ment.html'//不带参数跳页面
        })
        .state('con', {
            url: '/con',
            templateUrl: './html/confirm.html'//不带参数跳页面
        })
});
myApp.controller('indeX', function ($scope, $state) {


});
