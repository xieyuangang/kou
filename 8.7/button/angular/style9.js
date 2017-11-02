var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style9');
    $stateProvider.state('style9', {
        url: '/style9',
        templateUrl: './html/style9.html'
    })
});
myApp.controller("homo",function ($scope, $http, $rootScope) {
      $scope.names=name;
      $scope.Show=false;
      $scope.$watch('name',function (name) {//监控当name的值发生变化就会触发这个事件
          console.log(name);
              if(name=='0'){
                  $scope.Show=true
              }
          //alert(0)
      });

    $scope.submitForm = function(isValid) {
        alert(0);
        console.log(isValid);
        if (!isValid) {
            alert('验证失败');
        }
    };

    $scope.getMessage = function() {
        setTimeout(function() {
            $scope.$apply(function () {
                //$scope.message = 'Fetched after 3 seconds';
                console.log('message:'+$scope.message);
            })
        }, 2000);
    };
    $scope.getMessage();
});