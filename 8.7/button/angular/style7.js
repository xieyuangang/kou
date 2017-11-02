var myApp = angular.module('myApp', ['ui.router']);
myApp.directive('customTags', function () {
    return {
        restrict: 'ECA ',
        controller: function ($scope) {//controller 里面写操作
            console.log($scope);
        },
        scope:false,//为理解待研究
        controllerAs: 'bookListController',//别名
        template: '<div><ul><li ng-repeat="a in app">{{a.id}}</li></ul></div>',//把原始数据放在p标签里面
        replace: true
    }
});


myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style7');
    $stateProvider.state('style7', {
        url: '/style7',
        templateUrl: './html/style7.html'
    })
});

myApp.controller("homo", function ($scope) {
   // console.log($scope);
    $scope.app = [{id: 10}, {id: 14}, {id: 16}, {id: 18}];//数组
});

