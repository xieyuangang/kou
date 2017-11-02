var myApp = angular.module('myApp', ['ui.router']);

myApp.factory("Data", function () {//公用数据
    return [
        {
            title: '标题1',
            content: '暗示法UI舒服撒好烦  '
        },
        {
            title: '标题2',
            content: '暗示法UI舒服撒好烦   '
        },
        {
            title: '标题3',
            content: '暗示法UI舒服撒好烦  '
        }
    ]
});

myApp.controller("homo", ['$scope', 'Data', function ($scope, Data) {
    $scope.data = Data;
}]);

myApp.directive("kittencupGroup", function () {
    return {
        restrict: 'ECA ',
        replace: true,
        controllerAs: 'kittencupGroupGroup',
        controller: function () {
            this.groups = [];
            this.appmap = function (nowScope) {
                angular.forEach(this.groups, function (scope) {//循环
                    if (scope !== nowScope) {//两个对比
                        scope.status = false;//其余的隐藏
                    }
                })
            }
        },
        template: '<div class="panel-group" ng-transclude></div>',
        transclude: true//加载到div里面
    }
});
myApp.directive("kittencupCollapse", function () {
    return {
        restrict: 'ECA ',
        replace: true,
        require: '^kittencupGroup',//找上面那个公园数据
        templateUrl: './html/ZeDie1.html',
        scope: {
            heading: '@'
        }, //作用域  找到heading里面的标题用在ZeDie1.html页面上面  @ 就是heading
        transclude: true, //加载到哪里 为真就把内容放在 ZeDie1.html页面上面去了
        link: function (scope, iEelement, iAttrs, kittencupGroupGroup) {
            scope.status = false; //默认显示隐藏
            scope.app = function () {
                scope.status = !scope.status; //取反显示隐藏
                kittencupGroupGroup.appmap(scope)//点击事件传参数
            };
            kittencupGroupGroup.groups.push(scope) // push当前的数组
        }
    }
});
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/ZeDie');
    $stateProvider.state('ZeDie', {
        url: '/ZeDie',
        templateUrl: './html/ZeDie.html'
    })
});



