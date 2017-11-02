var animateApp = angular.module("animateApp", ["ui.router"]);
animateApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.when("", "/course");
    $stateProvider
        .state("course", {
            url: "/course",
            templateUrl: "./html/TONG.html"
        })
        .state("courses", {
            url: "/courses",
            templateUrl: "./html/sst.html"
        })
});


animateApp.controller('mainController', function ($scope, $http, $rootScope) {

    $http({
        method: 'get',
        url: 'http://gank.io/api/search/query/listview/category/%E7%A6%8F%E5%88%A9/count/10/page/1'
        // params    :{bookName:$scope.book.bookName}// 传递数据作为字符串，从前台传到后台
    }).success(function (data) {

       var result = [];
        for (var i = 0, len = data.results.length; i < len; i += 3) {
            result.push(data.results.slice(i, i + 3));
        }
        $scope.names = result[0];
        $scope.names1 = result[1];
        $scope.names2 = result[2];
        $scope.names3 = result[3];

        /* if($scope.names.length == 3){ //通过获取到的值判断显示隐藏  ng-show="isActivedBox" ng-if="names.length == 3" 写在标签内的
             $scope.isActivedBox = true;
          }else{
             $scope.isActivedBox = false;
          }*/
    });
    $scope.toActivity = function () {
        $rootScope.somkeName = '2222';
        alert(this.pa.url); //当前的内容
        window.location.hash = "/courses";
    };
});
/*animateApp.controller('main',function ($scope,$http) {

    $scope.number = 0;
    $scope.count = function(newValue,oldValue,scope){
        $scope.result = $scope.number*3;
        console.log(newValue);
        console.log(oldValue);
        console.log(scope);
        return $scope.result
    };
    $scope.$watch('number',$scope.count,false)
});*/
animateApp.controller('main', function ($scope, $http) {

    $scope.$watch("number", function (newValue, oldValue, scope) {
        if (newValue) {
            if (/^1[34578]\d{9}$/.test(newValue)) {//手机号码验证
                $(".button").css("background", "#bf0040");
                localStorage.setItem("openId", newValue);
            } else {
                $(".button").attr("disabled", false);
                $(".button").css("background", "#BFBFBF");
            }
        }
    });
    $scope.vatt = function () {
        var la = localStorage.getItem("openId");
        console.log(la);
    };
    var st=0;
    $scope.vast = function () {
        st++;
     console.log(st)
    };
});
