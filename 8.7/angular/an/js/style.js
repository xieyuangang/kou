var animateApp = angular.module("animateApp", ['ngRoute', 'ngAnimate']);
animateApp.config(function ($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: './html/activity.html',
            controller: 'mainController'
        })

});
animateApp.controller('mainController', function($scope) {
    $scope.pageClass = 'page-home';
});
