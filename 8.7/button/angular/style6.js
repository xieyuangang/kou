var myApp = angular.module('myApp', ['ui.router']);
myApp.directive('customTags', function () {
    return {
        restrict: 'ECA ',
        controller: function ($scope) {//controller 里面写操作
            $scope.app = [{id: 10}, {id: 14}, {id: 16}, {id: 18}];//数组
             this.addBook = function () {//点击事件
                 angular.element(event.target).css({background: "red"})
             };
            this.addBooks = function () {
                $scope.$apply(function () {//脏检查触发事件
                    $scope.app.push({//往数组里面添加内容
                        id: 101
                    })
                })
            }
        },
        controllerAs: 'bookListController',//别名
        template: '<div><ul><li ng-repeat="a in app">{{a.id}}</li></ul><book-add></book-add></div>',//把原始数据放在p标签里面
        replace: true,//替换标签写上没得报错 符合w3c规范
        link: function (scope, iEelement, iAttrs, bookListController) {
             iEelement.on("click", bookListController.addBook)//iEelement当前元素 bookListController定义的一个名字 addBook调用函数
         }
    }
});

myApp.directive('bookAdd', function () {
    return {
        restrict: 'ECA ',
        require: '^customTags',//找到对应的添加
        template: '<button>添加</button>',
        replace: true,
        link: function (scope, iEelement, iAttrs, bookListController) {
            iEelement.on("click", bookListController.addBooks)
        }
    }
});

myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style6');
    $stateProvider.state('style6', {
        url: '/style6',
        templateUrl: './html/style6.html'
    })
});

myApp.controller("homo", function ($scope) {

});

