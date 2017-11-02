var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
  /*  var Jump = '';
    if (pt == '1') {//判断值然后跳转页面
        Jump = '/nav'
    } else if (pt == '2') {
        Jump = '/name'
    }*/
    $urlRouterProvider.otherwise('/nav');
    $stateProvider.state('nav', {
        url: '/nav',
        templateUrl: './html/nav.html'
    })
        .state("name", {
            url: "/name",
            templateUrl: "./html/name.html"
        })
        .state("name.Embedded", {
            url:"/Embedded",
            templateUrl: "./html/Embedded.html"
        });
});
myApp.controller('map', function ($scope, $http, $rootScope) {
    $http({
        method: 'get',
        url: 'html/tsconfig.json'
        //data : JSON.stringify(param),
        //headers: { 'Content-Type': 'application/json;charset=UTF-8'}
    }).success(function (data) {//请个成功
        //  $scope.nane = data.result;
        $rootScope.nane = data.result; //全局都可获取的变量
    }).error(function (data) {//请求失败
         alert("失败")
    });

    $scope.setColor = function (port_status) {//判断当前这个标签的port_status的值改变颜色
        var p = "";
        var ps = "";
        if (3 == port_status) {
            p = '#eee';
            ps = "#999"
        } else if (5 == port_status) {
            p = '#eee';
            ps = "#999"
        }
        return {"background-color": p, "color": ps};//button背景
    };
    $scope.$watch("shou", function (newValue, oldValue, scope) {
        if (newValue) {
            if (!(/^1[3,4,5,7,8]\d{9}$/.test(newValue))) {//手机号码验证
                $(".text").css("background", "red");
                //localStorage.setItem("openId", newValue); 存input的val
            } else {
                $(".text").css("background", "#60ff00");
            }
        }
    });
    $scope.call = function () { //点击事件
        $scope.kou = true;//显示隐藏
        //console.log($scope.nane); //得到上面返回的值
        //console.log($scope.shou);//获取input里面的值
        //var pp= $scope.shou;  //把值定义成变量
        //console.log(pp);
        if (this.a.port_status == '3') {//当前标签里面的值

        } else if (this.a.port_status == '5') {

        } else {
            var pp = $scope.shou;//获取input值
            if (!(/^1[3,4,5,7,8]\d{9}$/.test(pp))) {//手机号码验证
                alert("错");
                return false;
            } else {
                alert(1);
                alert("发送成功")
            }
        }
    };
    $scope.callS = function () {
        $scope.kou = false;
    }

});