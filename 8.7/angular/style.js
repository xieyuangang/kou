// app.js

// define our application and pull in ngRoute and ngAnimate
var animateApp = angular.module('animateApp', ['ngRoute', 'ngAnimate']);

// ROUTING ===============================================
// set our routing for this application
// each route will pull in a different controller
animateApp.config(function($routeProvider) {

    $routeProvider

    // home page
        .when('/', {
            templateUrl: '../pay/dom1.html',
            controller: 'mainController'
        })

        // about page
        .when('/la', {
            templateUrl: '../pay/la.html',
            controller: 'aboutController'
        })

        // contact page
        .when('/contact', {
            templateUrl: '../pay/contact.html',
            controller: 'contactController'
        });

});


// CONTROLLERS ============================================
// home page controller
animateApp.controller('mainController', function($scope) {
    $scope.pageClass = 'page-home';
});

// about page controller
animateApp.controller('aboutController', function($scope) {
    $scope.pageClass = 'page-about';
});

// contact page controller
animateApp.controller('contactController', function($scope) {
    $scope.pageClass = 'page-contact';
});