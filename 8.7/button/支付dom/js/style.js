var myApp = angular.module('myApp', ['ui.router']);
myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/nav');
    $stateProvider.state('nav', {
        url: '/nav',
        templateUrl: './html/donm1.html'
    })
        .state('producer', {
            url: '/producer',
            templateUrl: './html/ShoppingCart.html',
            controller: 'ProducersCtrl'
        })
        .state('payment', {
            url: '/payment',
            templateUrl: './html/ment.html'//不带参数跳页面
        })
        .state('con', {
            url: '/con',
            templateUrl: './html/confirm.html'//不带参数跳页面
        })

});
myApp.controller('indeX', function ($scope, $state) {
    $scope.winowHeight = document.body.clientHeight;
    $scope.myObj = {'height': $scope.winowHeight + 'px'};
    $scope.json = [
        {
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            lou: 1
        },
        {
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            lou: 2
        },
        {
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            lou: 3
        },
        {
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            lou: 4
        },
        {
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            lou: 5
        }
    ];
    $scope.clickStatus = function (a) { //点击选择
        //console.log(a);
        a.isHover = !a.isHover
    };
    $scope.goPay = function (producerId) {
        var param = [];
        $('.row').find(".Sele").each(function (i) {
            var smoke = $(this).attr("hideName");
            param.push(smoke);
        });
        var Sparam = param.join(",");

        if (Sparam == "") {
            $state.go('payment');//不带参数跳页面
        } else {
            var producerId = '30';//带走的参数
            $state.go('producer', {producerId: producerId}); //跳转页面带参数
        }
    }

    /* $(".X").find(".XA").each(function () {
            alert(0)
     })*/
    /*     $(".X").find(".XA").each(function (i) {//选中 取消
             var pt = 0;
             $(this).click(function () {
                 if (pt == 0) {
                     $(this).addClass("Sele");
                     pt = 1;
                 } else {
                     $(this).removeClass("Sele");
                     pt = 0;
                 }
                 jump = $(this).attr('class');
             });
         });*/
    /* $scope.Selected = function ($event) {
         console.log($event);




         //;$index.css({background:'red'})
         //$scope.focuA = !$scope.focuA;
         //$scope.focus = $index;
         f(n==0){
               n++;
               $($event.target).css({background:'red'})
           }else if(n==1){
              $($event.target).css({background:''});
               n=0;
           }
         // console.log($scope.selected = $event)
     }*/
});
myApp.controller('ProducersCtrl', function ($scope, $state, $stateParams) {//$stateParams 跳页面传参数
    var producerId = $stateParams.producerId;//接收参数
    //console.log(producerId);
    $scope.json = [
        {
            id: "2",
            img: 'img/yan.png',
            name: '小熊猫香',
            ke: '30.03',
            Number: 2
        },
        {
            id: "5",
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            Number: 1
        },
        {
            id: "8",
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            Number: 4
        },
        {
            id: "10",
            img: 'img/yan.png',
            name: '小熊猫香烟',
            ke: '30.3',
            Number: 2
        }
    ];
    $scope.Total = function () {//合计
        var Tota = 0;
        angular.forEach($scope.json, function (a) {
            Tota += a.Number * a.ke;
        });
        return Tota;
    };
    var findIndex = function (id) {//循环遍历函数
        var indeX = -1;
        angular.forEach($scope.json, function (a, key) {
            if (a.id === id) {
                indeX = key;
                return;
            }
        });
        return indeX;//返回出去
    };
    $scope.add = function (id) {//加
        var indeX = findIndex(id);
        if (indeX !== -1) {
            ++$scope.json[indeX].Number;
        }
    };
    $scope.reduce = function (id) {//减
        var indeX = findIndex(id);
        if (indeX !== -1) {
            --$scope.json[indeX].Number;
            if ($scope.json[indeX].Number == '0') {
                var ryte = confirm("是否要删除这个物品");
                if (ryte) {
                    $scope.remove(id)
                }
            }
        }
    };
    $scope.remove = function (id) {//移除
        var indeX = findIndex(id);//调用上面那个遍历函数
        if (indeX !== -1) {
            $scope.json.splice(indeX, 1)
        }
    };
    $scope.$watch('json', function (newValue, oldValue) {
        angular.forEach(newValue, function (a, key) {
            if (a.Number < 1) {
                var ryte = confirm("是否要删除这个物品");
                if (ryte) {
                    $scope.remove(a.id)
                } else {
                    a.Number = oldValue[key].Number;
                }
            }
        })
    }, true);
    $scope.app=function () {//确认付款
        $state.go('con');
    }
});
myApp.controller('ment', function ($scope, $state, $stateParams) {
    $("td input").on("touchstart", function () {
        $(this).css({background: '#eee'})
    });
    $("td input").on("touchend", function () {
        $(this).css({background: '#fff'})
    });

    $("td input").on("click", function () {
        var name = $(this).val();
        $("#Nme").append(name)
    });

    $scope.myVar = false;
    var timer = null;
    $scope.app = function () {
        var cname = document.getElementById('Nme').innerHTML;
        var nameP = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
        if (cname == "") {
            alert("请输入金额！");
            return false;
        } else if (!nameP.test(cname)) {
            alert("请输入正确金额！");
            document.getElementById('Nme').innerHTML = "";
            return false;
        } else {
            $scope.myVar = true;
            console.log($scope.myVar);
            var nowTime = new Date().getTime();//防止用户重复点击
            var clickTime = $(this).attr("ctime");
            if (clickTime != 'undefined' && (nowTime - clickTime < 5000)) {
                alert('操作过于频繁，稍后再试');
                timer = setInterval(function () {
                    $scope.myVar = false;
                    clearInterval(timer);
                }, 1000);
                return false;
            } else {
                $(this).attr("ctime",nowTime);
                console.log(cname);
                timer = setInterval(function () {
                    $scope.$apply(function () {//脏检查加了这个下面的false在页面才起效果 不然控制台执行了页面也不会执行
                        $scope.myVar = false;
                        alert('提交成功');
                        clearInterval(timer);
                    });
                }, 5000);
               // $state.go('con');
            }
        }
    }

});
myApp.controller('con', function ($scope, $state, $stateParams,$http) {

    $http({//数据请求
        method: 'get',
        url: 'html/tsconfig.json'
        //data : JSON.stringify(param),
        //headers: { 'Content-Type': 'application/json;charset=UTF-8'}
    }).success(function (data) {
       console.log(data)
    }).error(function () {
        alert("失败")
    });
    $scope.json={
          "img":'img/ok.png',
          "price":30.30,
           "state":"付款成功",
          "random":[
              3,6,9,1
          ]
    };
    $scope.jsonp={
        "img":'img/no.png',
        "price":30.99,
        "state":"付款失败",
        "random":[
            3,9,9,9
        ]
    };
    var num = GetRandomNum(1,10);
    if((num%2 ==0)){
        $scope.a=$scope.json;
    }else{
        $scope.a=$scope.jsonp;
    }
});
function GetRandomNum(Min,Max){
    var Range = Max - Min;
    var Rand = Math.random();
    return(Min + Math.round(Rand * Range));
}