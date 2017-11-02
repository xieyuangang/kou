var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style3');
    $stateProvider.state('style3', {
        url: '/style3',
        templateUrl: './html/style3.html'
    })
});
myApp.service("prList", function () {
    return [
        {
            id: 162,
            name: '苹果',
            Price: 30,
            min: "Apple"
        },
        {
            id: 25,
            name: '梨子',
            Price: 60,
            min: "Pear"
        },
        {
            id: 396,
            name: '西瓜',
            Price: 50,
            min: "watermelon"
        },
        {
            id: 46,
            name: '猕猴桃',
            Price: 40,
            min: "Kiwifruit"
        }
    ]
});
myApp.controller("homo", function ($scope, prList) {
    $scope.prList = prList;

    $scope.orderType = 'id';
    $scope.order = '-';  //为空时升序  -是降序
    $scope.sort = '降序';
    $scope.changOeder = function (type) {
        $scope.orderType = type;
        if ($scope.order === '') {
            $scope.order = '-';
            $scope.sort = '升序';
        } else {
            $scope.order = '';
            $scope.sort = '降序';
        }
    }


});
