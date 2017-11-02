var myApp = angular.module('myApp', ['ui.router'],function ($provide) {
    //$provide自定义服务  在里面也可以定义多个服务
    $provide.provider("Customserv",function () {
        this.$get=function () {
            return{
                names:'你好我是Customserv'
            }
        }
    });
    $provide.factory("Customserv1",function () {
        //自定义工厂是上面的一个简便方法 可以返回字符串
        return{
            names:'你好我是factory Customserv',
            namesg:0
        }
    });
    $provide.service("Customserv2",function () {
        //自定义服务  返回必须是个对象
        return{
            names:'00'
        }
    })
    
});
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style2');
    $stateProvider.state('style2', {
        url: '/style2',
        templateUrl: './html/style2.html'
    })
});
myApp.factory("Data",function () {
   return{
       masg:"数据共享"
   }
});
myApp.controller("homo", function ($scope,Customserv,Customserv1,Customserv2,Data,$filter) {//过滤器在js中的用法
     $scope.time=new Date;
     var lou=$filter('number')(3000)//过滤器在js中的用法 var 变量名=$filter('过滤器')(值)
   //console.log(Customserv);
   //console.log(Customserv1);
  //console.log(Customserv2);
});
myApp.controller("modex1", function ($scope,Data) {//数据共享
    console.log($scope);
       $scope.data={ name:'张三'};
        $scope.Data=Data;
});
myApp.controller("modex2", function ($scope,Data) {//数据共享
   $scope.data=$scope.$$prevSibling.data;
    $scope.Data=Data;
});