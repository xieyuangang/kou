var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/name');
    $stateProvider.state('name', {
        url: '/name',
        templateUrl: './html/name.html'
    })
});
myApp.controller("homo", function ($scope, $http, $rootScope) {//购物车
    $scope.cart = [
        {
            id: '100',
            name: '电视',
            quantity: 3,
            price: '200'
        },
        {
            id: '500',
            name: '冰箱',
            quantity: 1,
            price: '800'
        },
        {
            id: '120',
            name: '洗衣机',
            quantity: 6,
            price: '200'
        }
    ];
    $scope.totalprice = function () {//计算总价
        var total = 0;
        angular.forEach($scope.cart, function (a) {
            total += a.quantity * a.price;//数量*单价
        });
        return total;
    };
    $scope.totalpriceX = function () {//计算总购买数
        var total = 0;
        angular.forEach($scope.cart, function (a) {
            total += parseInt(a.quantity);
        });
        return total;
    };

    var findIndex = function (id) {//循环遍历函数
        var indx = -1;
        angular.forEach($scope.cart, function (a, key) {
            if (a.id === id) {
                indx = key;
                return;
            }
        });
        return indx;//返回出去
    };

    $scope.add = function (id) {//加
        var indx = findIndex(id);//调用上面那个遍历函数
        if (indx !== -1) {
            ++$scope.cart[indx].quantity
        }
    };

    $scope.reduce = function (id) {//减
        var indx = findIndex(id);//调用上面那个遍历函数
        if (indx !== -1) {
            --$scope.cart[indx].quantity;
            if ($scope.cart[indx].quantity == '0') {
                var ryte = confirm("你确定要删除这个商品吗？");
                if (ryte) {
                    $scope.remove(id);//调用移除函数
                    // $scope.cart.splice(indx, 1)
                }
            }
        }
    };

    $scope.remove = function (id) {//移除
        var indx = findIndex(id);//调用上面那个遍历函数
        if (indx !== -1) {
            $scope.cart.splice(indx, 1)
        }
    };

    $scope.$watch('cart', function (newValue, oldValue){//监听变化    //oldValue返回的  //newValue要改变的

        angular.forEach(newValue, function (a, key){ //key相当于i当前 a是要循环的
             if(a.quantity<1){
                 var ryte = confirm("你确定要删除这个商品吗？");
                 if (ryte) {
                     $scope.remove(a.id);
                 }else {
                    a.quantity=oldValue[key].quantity;//删除取消的话就返回原来的值   值等于返回当前的值
                 }
             }
        });
    }, true)//为真就会检查上面data里面的每个值的变化

});
