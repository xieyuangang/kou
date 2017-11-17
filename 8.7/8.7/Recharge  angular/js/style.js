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
myApp.controller('Statistics', function ($scope, $http, $timeout, $state) {//这个里面
    dateName("demo1");
    var calendar = new lCalendar();
    calendar.init({
        'trigger': '#demo1',
        'type': 'date'
    });

    function dateName(data) {
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth() + 1;
        var date = myDate.getDate();
        var now = year + '年' + month + "月";
        document.getElementById(data).value = now;
    }


    var mescroll = new MeScroll("mescroll", {
        up: {
            clearEmptyId: "dataList", //1.下拉刷新时会自动先清空此列表,再加入数据; 2.无任何数据时会在此列表自动提示空
            callback: getListData, //上拉回调,此处可简写; 相当于 callback: function (page) { getListData(page); }
            toTop: { //配置回到顶部按钮
                src: "res/img/mescroll-totop.png" //默认滚动到1000px显示,可配置offset修改
                //offset : 1000
            }
        }
    });

    function getListData(page) {
        $scope.getListDataFromNet(page.num, page.size, function (curPageData) {
            //方法四 (不推荐),会存在一个小问题:比如列表共有20条数据,每页加载10条,共2页.如果只根据当前页的数据个数判断,则需翻到第三页才会知道无更多数据,如果传了hasNext,则翻到第二页即可显示无更多数据.
            mescroll.endSuccess(curPageData.length);
            //设置列表数据,因为配置了emptyClearId,第一页会清空dataList的数据,所以setListData应该写在最后;
            $scope.setListData(curPageData);
        }, function () {
            //联网失败的回调,隐藏下拉刷新和上拉加载的状态;
            mescroll.endErr();
        });
    }

    $('#demo1').bind('input propertychange', function () {//点击input获取值操作  这里不晓得怎么调了
        var dateL = $(this).val().replace(/年/, "").replace(/月/, "").replace(/日/, "");//这里是要给后台传的日这怎么写

        getListData({num: 1, size: 10})
    });
    $scope.setListData = function (curPageData) {
        var listDom = document.getElementById("dataList");
        for (var i = 0; i < curPageData.length; i++) {
            var pd = curPageData[i];
            var str = '<div class="col-xs-2"><h5 style="margin:5px 0; ">' + pd.linksId + '</h5><p>' + pd.linksName + '</p></div><div class="col-xs-4"><h4>话费充值</h4></div><div class="col-xs-6"><h5 style="margin:5px 0; ">' + pd.linksUrl + '</h5><p>给' + pd.masterEmail + '充值</p></div>';
            var liDom = document.createElement("li");
            liDom.innerHTML = str;
            listDom.appendChild(liDom);
        }
    };
    /*联网加载列表数据*/
    $scope.getListDataFromNet = function (pageNum, pageSize, successCallback, errorCallback) {//进入页面调的
        $http({//数据请求
            method: 'get',
            url: 'newsLists.json',
            date: ''//参数定义全局改变可用
        }).success(function (data) {
            var listData = [];
            for (var i = (pageNum - 1) * pageSize; i < pageNum * pageSize; i++) {
                if (i == data.length) break;
                listData.push(data[i]);
            }
            successCallback(listData);
            $scope.totalprice = function () {//计算总价
                var total = 0;
                angular.forEach(data, function (i) {
                    total += parseInt(i.linksUrl);
                });
                return total;
            };
        })
    };
    //禁止PC浏览器拖拽图片,避免与下拉刷新冲突;如果仅在移动端使用,可删除此代码
    document.ondragstart = function () {
        return false;
    };
    $scope.apps = function () {
        $state.go('dome');
    }
});
myApp.controller('dome', function ($scope, $http, $rootScope) {

    var mescroll = new MeScroll('mescroll', {
        up: {
            clearEmptyId: "dataList",
            callback: getListData,
            toTop: {
                src: "res/img/mescroll-totop.png",
                offset: 100
            },
            htmlNodata:'没得数据啦。。别再拉了......',
            empty: {//没得数据时显示的
                //列表第一页无任何数据时,显示的空提示布局; 需配置warpId或clearEmptyId才生效;
                warpId:null, //父布局的id; 如果此项有值,将不使用clearEmptyId的值;
                icon: "res/img/mescroll-empty.png", //图标,默认null
                tip: "暂无相关数据~", //提示
                btntext: "去逛逛 >", //按钮,默认""
                btnClick: function(){//点击按钮的回调,默认null
                    alert("点击了按钮,具体逻辑自行实现");
                }
            }
        }
    });
    function getListData(page) {
        getListDataFromNet(page.num, page.size, function (curPageData) {
            mescroll.endSuccess(curPageData.length);
             setListData(curPageData);
        }, function () {
            mescroll.endErr();
        })
    }
    function setListData(curPageData){
        var listDom=document.getElementById("dataList");
        for (var i = 0; i < curPageData.length; i++) {
            var pd=curPageData[i];

            var str='<img class="pd-img" src="'+pd.pdImg+'"/>';
            str+='<p class="pd-name">'+pd.pdName+'</p>';
            str+='<p class="pd-price">'+pd.pdPrice+' 元</p>';
            str+='<p class="pd-sold">已售'+pd.pdSold+'件</p>';

            var liDom=document.createElement("li");
            liDom.innerHTML=str;
            listDom.appendChild(liDom);
        }
    }
    function getListDataFromNet(pageNum, pageSize, successCallback, errorCallback) {
        setTimeout(function () {
            $.ajax({
                type: 'GET',
                url: 'pdlist1.json',
                //url: '../res/pdlist1.json?num='+pageNum+"&size="+pageSize,
                dataType: 'json',
                success: function (data) {
                    var listData = [];
                    for (var i = (pageNum - 1) * pageSize; i < pageNum * pageSize; i++) {
                        if (i == data.length) break;
                        listData.push(data[i]);
                    }
                    successCallback(listData);
                },
                error: errorCallback
            });
        }, 1000)
    }
    document.ondragstart = function () {
        return false;
    }
});
