var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style4');
    $stateProvider.state('style4', {
        url: '/style4',
        templateUrl: './html/style4.html'
    })
});

myApp.controller("homos", function ($scope) {

});
myApp.controller("homo", ['$scope', function (a) {
    //console.log(a);
    a.chang = function (event) {
      //  console.log(event.target);//当前的元素
        a.status = !a.status;
        //通过element转换成jquery对象 这可以写css val html
        if (a.status == true) {
            angular.element(event.target).css({background: "red"})
        } else {
            angular.element(event.target).css({background: ""})
        }
    };
    a.max = {background: "red", fontSize: "50px"};
    a.ste="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1107171961,4267974444&fm=27&gp=0.jpg"
}]);
