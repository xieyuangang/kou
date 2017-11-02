var animateApp = angular.module("animateApp", [ 'ui.router' ]);

animateApp.config(function ($stateProvider, $urlRouterProvider) {


    $urlRouterProvider.otherwise("Embedded");
    $stateProvider.state('nav', {
        url: '/nav',
        templateUrl : "./html/RouteTE.html"
    })
        .state("Embedded", {
            url:"/Embedded",
            templateUrl : "./html/RouteTE_One.html"
        });
});