var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/name');
    $stateProvider.state('name', {
        url: '/name',
        templateUrl: './html/name.html'
    })
});
myApp.controller("homo",function ($scope, $http, $rootScope) {

    $scope.data=new Date();

  /*  setInterval(function () {
          $scope.$apply(function () {//触发事件
              $scope.data=new Date();
          })
      });*/
    $scope.cone=0;
    $scope.data= {
        name: '5556',
        get:10
    };

    $scope.$watch('name',function (newValue,oldValue) {//监听变化
        ++$scope.cone;
         if($scope.cone>10){
             $scope.name="不变了"
         }

    },true)//为真就会检查上面data里面的每个值的变化
});