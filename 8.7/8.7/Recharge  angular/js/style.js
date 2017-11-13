myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/nav');
    $stateProvider.state('nav', {
        url: '/nav',
        templateUrl: './html/Bill.html'
    })
        .state('Statistics', {
            url: '/Statistics',
            templateUrl: './html/Statistics.html'
        })
        .state('dome', {
            url: '/dome',
            templateUrl: './html/dom.html'
        })
});
myApp.controller('indeX', function ($scope, $state, $http) {

    $scope.myFunc = function () {
        var name = document.getElementById("name").value;
        var MobileNumber = /^(134|135|136|137|138|139|150|151|152|157|158|159|182|183|184|187|188)[0-9]{8}$/;
        var UnicomNumber = /^(130|131|132|145|155|156|185|186)[0-9]{8}$/;
        var telecomNumber = /^(133|153|180|181|189)[0-9]{8}$/;
        $scope.Operate = '';
        if (MobileNumber.test(name)) {
            $scope.Operate = '中国移动';
        } else if (UnicomNumber.test(name)) {
            $scope.Operate = '中国联通';
        } else if (telecomNumber.test(name)) {
            $scope.Operate = '中国电信';
        }
        $scope.address = '四川成都';
        $scope.Fname = '李小铭';
        // var data=JSON.stringify({name: name, destNo: destNo});

        $http({//数据请求
            method: 'get',
            url: 'newsList.json'
            //data : JSON.stringify(param),
            //headers: { 'Content-Type': 'application/json;charset=UTF-8'}
        }).success(function (data) {

            $scope.json = data.linksTime;

        }).error(function () {
            alert("失败")
        });

    };

    $scope.app = function ($event, a) {

        $scope.tase = true;
        var name = document.getElementById("name").value;
        console.log(a);
        // console.log(pats);
        //var date = {destNo: destNo, productSize: productSize};
        $http({//数据请求
            method: 'get',
            url: 'newsList.json'
            //data : JSON.stringify(param),
            //headers: { 'Content-Type': 'application/json;charset=UTF-8'}
        }).success(function (data) {
            $scope.linksUrl = data.linksUrl;
            $scope.linksName = data.linksName;
        }).error(function () {

            alert("失败")
        });
    };
    $scope.jump = function () {
        $state.go('Statistics');
    }
});
/*
*
*
*
*
*
          .----.
       _.'__    `.
   .--($)($$)---/#\
 .' @          /###\
 :         ,   #####
  `-..__.-' _.-\###/
        `;_:    `"'
      .'"""""`.
     /,  ya ,\\
    //  404!  \\
    `-._______.-'
    ___`. | .'___
   (______|______)
*
* */

myApp.controller('Statistics', function ($scope, $http, $timeout,$state) {

    $http({//数据请求
        method: 'get',
        url: 'newsLists.json'
        //data : JSON.stringify(param),
        //headers: { 'Content-Type': 'application/json;charset=UTF-8'}
    }).success(function (data) {

        $scope.data = data;
        $scope.totalprice = function () {//计算总价
            var total = 0;
            angular.forEach($scope.data, function (i) {
                total += parseInt(i.linksUrl);
            });
            return total;
        };

    }).error(function () {

        alert("失败")
    });

    dateName("demo1");
    var calendar = new lCalendar();
    calendar.init({
        'trigger': '#demo1',
        'type': 'date'
    });

    $('#demo1').bind('input propertychange', function () {//点击input获取值操作
        var dateL = $(this).val().replace(/年/, "").replace(/月/, "").replace(/日/, "");
        console.log(dateL)
    });

    function dateName(data) {
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth() + 1;
        var date = myDate.getDate();
        var now = year + '年' + month + "月";
        document.getElementById(data).value = now;
    }
    $scope.apps = function () {
        $state.go('dome');
    }
});


myApp.controller('dome', function ($scope, $http) {


    var mescroll = new MeScroll("mescroll", { //第一个参数"mescroll"对应上面布局结构div的id
        down: {
            callback: downCallback //下拉刷新的回调,别写成downCallback(),多了括号就自动执行方法了
        },
        up: {
            callback: upCallback //上拉加载回调,简写callback:function(page){upCallback(page);}
        }
    });








    $http({//数据请求
        method: 'get',
        url: 'newsLists.json'
        //data : JSON.stringify(param),
        //headers: { 'Content-Type': 'application/json;charset=UTF-8'}
    }).success(function (data) {

        $scope.data = data;
        $scope.totalprice = function () {//计算总价
            var total = 0;
            angular.forEach($scope.data, function (i) {
                total += parseInt(i.linksUrl);
            });
            return total;
        };

    }).error(function () {

        alert("失败")
    });






});




