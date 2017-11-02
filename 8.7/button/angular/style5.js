var myApp = angular.module('myApp', ['ui.router']/*,['$compileProvider',function ($compileProvider) {
    $compileProvider.directive('customTags',function () {
    return{
        restrict:'ECA ',
        template:'<div>你好我是自定义指令</div>'
    }
})
}]*/);

/*myApp.directive('customTags',function () {//简便写法
    return{
        restrict:'ECA ',
        templateUrl:'html/name.html',
        replace:true
    }
});*/
myApp.directive('customTags',function () {//简便写法
    return{
        restrict:'ECA ',
        template:'<div>新数据  <p ng-transclude></p></div>',//把原始数据放在p标签里面
        replace:true,
        transclude:true  //保留原始数据
    }
});
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style5');
    $stateProvider.state('style5', {
        url: '/style5',
        templateUrl: './html/style5.html'
    })
});

myApp.controller("homo", function ($scope) {

});

