/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("homeCtrl" , function($scope , $http , tool , $rootScope , Interface){
    tool.updateTitle($scope.shopName);

    localStorage.setItem('isTouchA',false);

    var ua = navigator.userAgent.toLowerCase();

    if(ua.match(/bestpay/i) == "bestpay") {//易支付
        $scope.bestpay = true;
        $("#ad").height($(window).height() - 200);
        $("#adCont").height($(window).height() - 277);
        $("#buyBtn").attr("disabled",true);
        $("#buyBtn").css("background","#BFBFBF")
    }else{
        document.getElementById("ad").style.height = document.body.clientHeight - 135 + "px";
        document.getElementById("adCont").style.height = document.body.clientHeight - 215 + "px";
        tool.createIscroll("adCont");
    }

    $scope.$watch('regPhone',function(newValue,oldValue, scope){
        if(newValue){
            if(/^1[34578]\d{9}$/.test(newValue)){
                $("#buyBtn").attr("disabled",false);
                $("#buyBtn").css("background","#bf0040");
                localStorage.setItem("openId",newValue);
            }else{
                $("#buyBtn").attr("disabled",true);
                $("#buyBtn").css("background","#BFBFBF");
                localStorage.removeItem("openId");
            }
        }
    });

    $scope.$watch('amount',function(newValue,oldValue, scope){
        if(newValue){
            if(!/^\d+(\.\d{0,2})?$/.test(newValue)){
                $scope.amount = oldValue;
            }
        };
    });

    Interface.getUnclaimed(function(){
        $(".notPrompt").show();
    });

    if($scope.isActived == 1){
        $scope.isActivedBox = true;
    }else{
        $scope.isActivedBox = false;
    }

    $scope.propt = false;
    $scope.inputMoney = true;

    $scope.toShopping = function(){
        window.location.hash = "/shopping";
    };


    $scope.toMore = function(){
        window.location.hash = "/more";
    };

    $scope.toNot = function(){
        location.hash = "/notReceived";
    };


    //支付事件
    $scope.sure = sure;

    function sure(){
        try{
            //实际金额
            var totalAmount = $scope.amount;
            var payWay = "00";
            if(ua.match(/micromessenger/i) == "micromessenger"){//微信
                payWay = "00";
            }else if (ua.match(/alipayclient/i) == "alipayclient"){//支付宝
                payWay = "01";
            }else if(ua.match(/jdpay/i) == "jdpay") {//京东
                payWay = "02";
            }else if(ua.match(/bestpay/i) == "bestpay") {//易支付
                payWay = "03";
            }
            if(!totalAmount||isNaN(totalAmount)){
                if(payWay == "00"){
                    alert("请输入0元以上的支付金额");
                }else{
                    alert("请输入0元以上的支付金额");
                }
                return false;
            }else{
                var amount = parseFloat(totalAmount).toFixed(2);
                if(payWay == "00"){
                    if(amount<0.01){
                        alert("请输入0.01元以上的支付金额");
                        return false;
                    }
                }else{
                    if(amount<0){
                        alert("请输入0元以上的支付金额");
                        return false;
                    }
                }
            }
            //判断是否使用抵扣券，京东不能使用
            if(payWay != '02'){
                Interface.checkIsDeductible({	//获取抵扣券
                    'payWay' : payWay,
                    'amount' :totalAmount.toString(),//支付金额，分
                    'openId' : localStorage.getItem("openId"),
                    "qrCode":localStorage.getItem("shopQRCode"),
                    'num':0,
                    'staffMId':localStorage.getItem('staffMId'),
                    'payType':'00',
                    'activityCode' : activityCode,
                },function(data){	//有抵扣券
                    location.hash = '/couponPay';
                    $rootScope.coupon = data;
                },function(){	//没有抵扣券，直接支付
                    $("#loading").show();
                    $scope.sure = null;
                    createOrder(totalAmount,payWay);
                });
            }else{
                $("#loading").show();
                $scope.sure = null;
                createOrder(totalAmount,payWay);
            }
        }catch (e) {
            alert(e.message);
        }
    }

    //支付，调用微信，支付宝支付控件
    function createOrder(totalAmount,payWay) {

        Interface.ynPrepay({
            'payWay' : payWay,
            'amount' :totalAmount.toString(),//支付金额，分
            'openId' : localStorage.getItem("openId"),
            "qrCode":localStorage.getItem("shopQRCode"),
            'num':0,
            'staffMId':localStorage.getItem('staffMId'),
            'payType':'00',
            'activityCode' : activityCode,
        },function(data){
            localStorage.setItem("outTradeNo" , data.outTradeNo);
            if(payWay == '00'){
                Interface.onBridgeReady(JSON.parse(data.payInfo));
            }else if(payWay == '01'){
                if(JSON.parse(data.payInfo).status == '0'){
                    Interface.alipay(JSON.parse(data.payInfo).tradeNO);
                }else{
                    window.location.hash = "/success";
                }

            }else if(payWay == '02'){
                var payInfo = JSON.parse(data.payInfo);
                $("#version").val(payInfo.version);
                $("#merchant").val(payInfo.merchant);
                $("#jdAmount").val(payInfo.amount);
                $("#tradeNum").val(payInfo.tradeNum);
                $("#tradeName").val(payInfo.tradeName);
                $("#tradeTime").val(payInfo.tradeTime);
                $("#tradeType").val(payInfo.tradeType);
                $("#currency").val(payInfo.currency);
                $("#notifyUrl").val(payInfo.notifyUrl);
                $("#ip").val(payInfo.ip);
                $("#sign").val(payInfo.sign);
                $("#device").val(payInfo.device);
                $("#callbackUrl").val(payInfo.callbackUrl);
                $("#expireTime").val(payInfo.expireTime);
                $("#orderType").val(payInfo.orderType);
                $("#payMerchant").val(payInfo.payMerchant);
                $("#riskInfo").val(payInfo.riskInfo);
                $("#jdForm").submit();
            }else if(payWay == '03'){
                var payInfo = JSON.parse(data.payInfo);
                location.href=payInfo.url;
            }

        },function(){
            $("#loading").hide();
            $scope.sure = sure;
        });
    }

    Interface.getActgoods(function(json){
        $scope.actgoods = json;
    });

    $scope.toActivity = function(somkeName , amount , goodsCode){
        if(this.a){
            somkeName = this.a.name;
            amount = this.a.price / 100;
            goodsCode = this.a.code;
        }
        $rootScope.somkeName = somkeName;
        $rootScope.amount = amount;
        $rootScope.goodsCode = goodsCode;
        localStorage.setItem('isTouchA',true);
        window.location.hash = "/activityPay";
    };
});

myApp.controller("couponPayCtrl" , function($rootScope , $scope , $http , tool , Interface){
    $scope.totalAmt = $rootScope.coupon.totalAmt/100;
    $scope.actualUse = $rootScope.coupon.actualUse;
    $scope.minPayAmount = $rootScope.coupon.minPayAmount/100;
    $scope.eachPrice = $rootScope.coupon.eachPrice/100;
    $scope.actaulAmt = $rootScope.coupon.actaulAmt/100;

    //支付事件
    $scope.sub = sub;

    function sub(){
        try{
            var ua = navigator.userAgent.toLowerCase();
            var payWay = "00";
            if(ua.match(/micromessenger/i) == "micromessenger"){//微信
                payWay = "00";
            }else if (ua.match(/alipayclient/i) == "alipayclient"){//支付宝
                payWay = "01";
            }else if(ua.match(/jdpay/i) == "jdpay") {//京东
                payWay = "02";
            }else if(ua.match(/bestpay/i) == "bestpay") {//易支付
                payWay = "03";
            }
            //判断是否使用抵扣券，京东不能使用
            $("#loading").show();
            $scope.sure = null;
            createOrder($scope.totalAmt,payWay);
        }catch (e) {
            alert(e.message);
        }
    };

    //支付，调用微信，支付宝支付控件
    function createOrder(totalAmount,payWay) {

        Interface.ynPrepay({
            'payWay' : payWay,
            'amount' :totalAmount.toString(),//支付金额，分
            'openId' : localStorage.getItem("openId"),
            "qrCode":localStorage.getItem("shopQRCode"),
            'num':0,
            'staffMId':localStorage.getItem('staffMId'),
            'payType':'00',
            'activityCode' : activityCode,
        },function(data){
            localStorage.setItem("outTradeNo" , data.outTradeNo);
            if(payWay == '00'){
                Interface.onBridgeReady(JSON.parse(data.payInfo));
            }else if(payWay == '01'){
                if(JSON.parse(data.payInfo).status == '0'){
                    Interface.alipay(JSON.parse(data.payInfo).tradeNO);
                }else{
                    window.location.hash = "/success";
                }

            }else if(payWay == '02'){
                var payInfo = JSON.parse(data.payInfo);
                $("#version").val(payInfo.version);
                $("#merchant").val(payInfo.merchant);
                $("#jdAmount").val(payInfo.amount);
                $("#tradeNum").val(payInfo.tradeNum);
                $("#tradeName").val(payInfo.tradeName);
                $("#tradeTime").val(payInfo.tradeTime);
                $("#tradeType").val(payInfo.tradeType);
                $("#currency").val(payInfo.currency);
                $("#notifyUrl").val(payInfo.notifyUrl);
                $("#ip").val(payInfo.ip);
                $("#sign").val(payInfo.sign);
                $("#cert").val(payInfo.cert);
                $("#jdForm").submit();
            }

        },function(){
            $("#loading").hide();
            $scope.sure = sure;
        });
    }
});

myApp.controller("shoppingCtrl" , function($scope , $http , tool){
    tool.updateTitle("积分兑换");

    initList();

    function initList(){
        $http({
            url:url+"/goods/getGoodsList",
            data:{"openId":localStorage.getItem("openId")},
            method:'post',
        }).success(function(json){
            $scope.goodsList = json.goodsList;
            if(json.data){
                $scope.userMsg = true;
                $scope.cellPhone = json.data.cellphone;
                $scope.point = json.data.point != null ? json.data.point : 0;
            }else{
                $scope.inputPhone = true;
            }
        });
    }


    $scope.back = function(){
        window.location.hash = "/home";
    };

    $scope.pointChange = function(){
        document.getElementById("dialog").style.display = "block";
        $scope.imgUrl = this.g.imgUrl;
        $scope.goodName = this.g.goodName;
        $scope.goodPoint = this.g.point;
        $scope.goodId = this.g.id;
    };

    $scope.jian = function(){
        if(Number($scope.num) > 0){
            $scope.num = Number($scope.num) - 1;
        }
        $scope.needPoint = $scope.num*$scope.goodPoint;
    };

    $scope.jia = function(){
        $scope.num = Number($scope.num) + 1;
        $scope.needPoint = $scope.num*$scope.goodPoint;
    };

    $scope.sub = sub;
    function sub(){
        if($scope.num > 0){
            $scope.sub = null;
            $http({
                url:url+"/pointchange/pointChange",
                data:{"custCellphone":$scope.cellPhone,"goodId":$scope.goodId,"goodsNum":$scope.num,"custId":$scope.custId},
                method:'post',
            }).success(function(json){
                if(json.code == 200){
                    alert("兑换成功");
                    initList();
                    document.getElementById("dialog").style.display = "none";
                }else{
                    alert("兑换异常");
                };
                $scope.sub = sub;
            });
        }else{
            alert("请选择数量");
        }

    };

    bind($scope , $http , function(json , bindPhone){
        if(json.data){
            $scope.userMsg = true;
            $scope.inputPhone = false;
            $scope.point = json.data.point != null ? json.data.point : 0;
            $scope.cellPhone = json.data.cellphone;
        }else{
            alert(json.msg);
            $scope.bindPhone = bindPhone;
        }
    });


});

myApp.controller("moreCtrl" , function($scope , $http , tool){
    tool.updateTitle("我的更多");

    init();

    function init(){
        $http({
            url:url+"/customer/getCustomer",
            data:{"openId":localStorage.getItem("openId"),"alipayId":localStorage.getItem("userId")},
            method:"post",
        }).success(function(json){
            if(json.data){
                $scope.myCont = true;
                $scope.point = json.data.point != null ? json.data.point : 0;
            }else{
                $scope.inputPhone = true;
            }
        });
    }

    $scope.back = function(){
        window.location.hash = "/home";
    };

    $scope.toMyOrder = function(){
        window.location.hash = "/myOrder";
    };

    $scope.toPointDetail = function(){
        window.location.hash = "/pointDetail";
    };

    bind($scope , $http , function(json , bindPhone){
        if(json.data){
            $scope.myCont = true;
            $scope.inputPhone = false;
            $scope.point = json.data.point != null ? json.data.point : 0;
        }else{
            alert(json.msg);
            $scope.bindPhone = bindPhone;
        }
    });

});

myApp.controller("myOrderCtrl" , function($scope , $http , tool , Order){
    tool.updateTitle("我的账单");

    document.getElementById("listBox").style.height = document.body.clientHeight  - 50 + "px";

    tool.createIscroll("listBox");

    $scope.back = function(){
        window.location.hash = "/more";
    };

    initTime($scope , Order , "1");

    $scope.select = function(){
        var times = $scope.timeSelect.split("-");
        document.getElementById("timeText").innerHTML = times[1];
        Order.getOrderList(times[0] , localStorage.getItem("openId") , $scope);
    };

});

myApp.controller("pointDetailCtrl" , function($scope , $http , tool , PointDetail){
    tool.updateTitle("积分兑换明细");

    document.getElementById("listBox").style.height = document.body.clientHeight  - 50 + "px";

    tool.createIscroll("listBox");

    $scope.back = function(){
        window.location.hash = "/more";
    };

    $scope.toPointDetail = function(){
        window.location.hash = "/pointDetail";
    };

    $scope.back = function(){
        window.location.hash = "/more";
    };

    initTime($scope , PointDetail , "2");

    $scope.select = function(){
        var times = $scope.timeSelect.split("-");
        document.getElementById("timeText").innerHTML = times[1];
        PointDetail.getPointdetailList(times[0] , localStorage.getItem("openId") , $scope);
    };

});

myApp.controller("deductibleCtrl" , function($scope , $http , tool , $rootScope){
    tool.updateTitle("积分抵扣买单");

    $scope.totalMoney = $rootScope.totalAmount;

    var ua = navigator.userAgent.toLowerCase();

    $http({
        url:url+"/customer/getCustomer",
        data:{"openId":localStorage.getItem("openId"),"alipayId":localStorage.getItem("userId")},
        method:"post",
    }).success(function(json){
        if(json.data){
            var point = json.data.point;
            var mPoint = $scope.totalMoney * 100;
            $scope.userPhone = json.data.cellphone;
            $scope.point = point;

            $http({
                url:url+"/payment/searchPointDeductionSetting",
                method:"post",
            }).success(function(json){
                if(json.code == 2000){
                    var data = json.data.split(",");
                    var min = data[0];
                    var max = data[1];
                    if(point > min){
                        if(point - mPoint >= 0){
                            $scope.kyPoint = mPoint;
                        }else{
                            if(point < mPoint-101){
                                $scope.kyPoint = point;
                            }else{
                                $scope.kyPoint = mPoint-100;
                            }
                        }

                        if($scope.kyPoint > max){
                            $scope.kyPoint = max;
                        }
                    }else{
                        $scope.kyPoint = 0;
                    }

                    $scope.dkMoney = $scope.kyPoint / 100;
                    $scope.realMoney = ($scope.totalMoney - $scope.dkMoney).toFixed(2);
                    $scope.dkhPoint = point - $scope.kyPoint;
                };
            }).error(function(){
                alert("错误");
            });
        }else{
            $scope.point = 0;
            $scope.dkMoney = 0;
            $scope.realMoney = $scope.totalMoney;
            $scope.dkhPoint = 0;
        }
    });

    $scope.notPay = function(){
        location.hash="/home";
    };

    $scope.addOrder = addOrder;

    function addOrder(){
        $scope.addOrder = null;
        var totalAmount = $scope.totalMoney;
        var payWay = "00";
        if(ua.match(/micromessenger/i) == "micromessenger"){
            payWay = "00";
        }else if (ua.match(/alipayclient/i) == "alipayclient"){
            payWay = "01";
        }else if(ua.match(/baiduwallet/i) == "baiduwallet") {
            payWay = "02";
        }
        createOrder(totalAmount,payWay);
    };

    function createOrder(totalAmount,payWay) {
        try {
            $http({
                url:url+'/payment/pointDeduction',
                method:'post',
                data:JSON.stringify({
                    'amount' : totalAmount.toString(),//支付金额，分
                    'custMd5' : ($scope.custMd5).toString(),//微信公众号支付
                    'payWay' : payWay.toString(),//商品名称
                    'openId' : localStorage.getItem("openId"),
                    'userPhone' : ($scope.userPhone).toString(),
                    "alipayUserId":localStorage.getItem("userId"),
                }),
                headers: { 'Content-Type': 'application/json;charset=UTF-8'}
            }).success(function(json){
                if(json.code==2000) {
                    json = JSON.parse(json.data);
                    if(json.code == 200){
                        var data = json.data;
                        var goodsName = data.goodsName;
                        var goodsDescription = data.goodsDescription;
                        document.getElementById("merchantCode").value = data.merchantCode;
                        document.getElementById("outOrderId").value = data.outOrderId;
                        document.getElementById("totalAmount1").value = data.totalAmount;
                        if(goodsName){
                            document.getElementById("goodsName").value = goodsName.substring(0,20);
                        }
                        if(goodsDescription){
                            document.getElementById("goodsDescription1").value = goodsDescription.substring(0,50);
                        }
                        document.getElementById("merchantOrderTime").value = data.merchantOrderTime;
                        document.getElementById("latestPayTime").value = data.latestPayTime;
                        document.getElementById("merUrl").value = data.merUrl;
                        document.getElementById("notifyUrl").value = data.notifyUrl;
                        document.getElementById("randomStr").value = data.randomStr;
                        document.getElementById("payWay").value = payWay;
                        document.getElementById("ext").value = data.ext;
                        document.getElementById("sign").value = data.sign;

                        document.getElementById("from").submit();
                    }
                }else if(json.code == 00){
                    location.replace(url+'/notifyPage?orderNum='+json.data+'&forward=/payment/pointDeductionResult&pageType=0');
                }else {
                    $scope.addOrder = addOrder;
                    alert(json.msg);
                }
            }).error(function(msg){
                $scope.addOrder = addOrder;
                alert(msg);
            });
        } catch (e) {
            // TODO: handle exception
            alert(e.message);
        }
    }

});

myApp.controller("activityCtrl" , function($rootScope , $scope , $http , tool , Interface){
    tool.updateTitle("活动支付");
    clearInterval($scope.iTimer);

    var ua = navigator.userAgent.toLowerCase();

    $scope.addOrder = addOrder;

    function addOrder(){
        var payWay = "00";
        if(ua.match(/micromessenger/i) == "micromessenger"){
            payWay = "00";
        }else if (ua.match(/alipayclient/i) == "alipayclient"){
            payWay = "01";
        }else if(ua.match(/jdpay/i) == "jdpay") {//京东
            payWay = "02";
        }else if(ua.match(/bestpay/i) == "bestpay") {
            payWay = "03";
        }
        var reg = /^[1-9]*[1-9][0-9]*$/;
        if(!$scope.num || !reg.test($scope.num)){
            alert("请输入有效的数量");
            return false;
        }
        var totalAmount =  $scope.num * $rootScope.amount;
        $("#loading").show();
        $scope.addOrder = null;
        createOrder(totalAmount,payWay);
    };

    function createOrder(totalAmount,payWay) {
        Interface.ynPrepay({
            'payWay' : payWay,
            'amount' :totalAmount.toString(),//支付金额，分
            'openId' : localStorage.getItem("openId"),
            "qrCode":localStorage.getItem("shopQRCode"),
            'num':$scope.num,
            'payType':'01',
            'staffMId':localStorage.getItem('staffMId'),
            'goodsCode':$rootScope.goodsCode,
            'activityCode' : activityCode,
        },function(data){
            localStorage.setItem("outTradeNo" , data.outTradeNo);
            if(payWay == '00'){
                Interface.onBridgeReady(JSON.parse(data.payInfo));
            }else if(payWay == '01'){
                if(JSON.parse(data.payInfo).status == '0'){
                    Interface.alipay(JSON.parse(data.payInfo).tradeNO);
                }else{
                    window.location.hash = "/success";
                }

            }
        },function(){
            $("#loading").hide();
            $scope.addOrder = addOrder;
        });
    }

});

myApp.controller("paySuccess" , function($scope , $http , tool){
    if($scope.state == 1){
        $scope.title = "支付成功!";
        $scope.prompt = true;
    }else{
        $scope.title = "支付失败!";
    }

    if($scope.pageType == 0){
        $scope.text = "抵扣";
        $scope.money = parseFloat($scope.freezingPoints/100).toFixed(2);
    }else{
        $scope.text = "减免";
        $scope.money = parseFloat($scope.randomDecreasing).toFixed(2);
    }

    $scope.back = function(){
        location.href=url+"/initPay?custId="+$scope.custMd5;
    };
});

myApp.controller("successCtrl" , function($rootScope , $scope , $http , tool , Order , Interface){
    try{
        tool.updateTitle("支付结果");

        $scope.cont = true;

        $('#shave').wScratchPad({
            fg: url+'/test/images/shaveAfter.jpg',
            size:20,
            scratchDown:function(){
                $("#shaveBox").show();
            },
            scratchUp : function(e , percent){
                if(percent > 30){
                    this.clear();
                    if($scope.isDraw){
                        $scope.bindPrompt = '请输入手机号领取奖品';
                    }else{
                        $scope.bindPrompt = '绑定手机号可再抽奖一次';
                    }
                    Interface.getBound(function(json){
                        if(json.code == '0000'){
                            localStorage.setItem("cellphone" , json.data.cellphone);
                            toSubSuccess(true , function(){});
                        }else{
                            if($scope.isDraw){
                                $scope.toAward = function(){
                                    $scope.draw = false;
                                    $("#bindBox").show();
                                };
                            }else{
                                setTimeout(function(){
                                    $scope.draw = false;
                                    $("#bindBox").show();
                                }, 2000);
                            }

                            bind($scope , $http , function(json , bindPhone){
                                if(json.code == '0000'){
                                    $("#bindBox").hide();
                                    localStorage.setItem("cellphone" , $scope.phone);
                                    toSubSuccess(false , function(){
                                        location.reload();
                                    });
                                }else{
                                    alert(json.msg);
                                    $scope.bindPhone = bindPhone;
                                }
                            } , Interface);
                        }
                    });
                }
            }
        });

        function toSubSuccess(type , fn){
            if($scope.isDraw && type){
                $scope.toAward = function(){
                    if(localStorage.getItem("isPost") == 0){
                        if(localStorage.getItem("isCoupon") == 1){
                            Interface.receiveAward({
                                customerPhone : localStorage.getItem("cellphone"),
                                recordCode : localStorage.getItem("recordCode"),
                                openId : localStorage.getItem("openId"),
                            },function(){
                                location.hash="/subSuccess";
                            })
                        }else{
                            location.hash="/subSuccess";
                        };

                    }else{
                        localStorage.setItem("awardVerificationUrl" , pathUrl+'/ynAward/receiveAward');
                        location.hash = '/address';
                    }
                };
            }else if($scope.isDraw && !type){
                if(localStorage.getItem("isPost") == 0){
                    Interface.receiveAward({
                        customerPhone : localStorage.getItem("cellphone"),
                        recordCode : localStorage.getItem("recordCode"),
                        openId : localStorage.getItem("openId"),
                    },function(){
                        location.hash="/subSuccess";
                    })
                }else{
                    localStorage.setItem("awardVerificationUrl" , pathUrl+'/ynAward/receiveAward');
                    location.hash = '/address';
                }
            }else{
                if(fn){fn()};
            }
        }
    }catch(e){
        alert(e.message);
    }
    try {
        query();
        function query(){
            Interface.query({
                'outTradeNo' : localStorage.getItem("outTradeNo"),
                'qrCode' : localStorage.getItem("shopQRCode"),
            },function(data){
                $scope.amount_s = data.payAmount / 100;
                $scope.deductibleAmount = data.coupon / 100;
                $scope.shopName_s = data.shopName;
                $scope.payAmount = data.amount / 100;
                if(data.coupon > 0){
                    $scope.scoreAmt = true;
                    $scope.minPayAmount = data.minPayAmount / 100;
                    $scope.couponUse = data.couponUse;
                    $scope.eachPrice = data.eachPrice / 100;
                }
                if(data.state == '0001'){

                    $(".successIcon").empty().append("<i class='iconfont icon-zhifuchenggong'></i>")
                    $(".success_type").empty().append("<span style='font-size: 20px; font-weight: 800;'>支付成功</span>")
                    if(data.isParticipated == 1){
                        Interface.lottery({	//抽奖
                            'billNo' : localStorage.getItem("outTradeNo"),	//订单号
                            'openId' : localStorage.getItem("openId"),	//唯一标识
                        },function(data){	//有奖品
                            $scope.draw = true;
                            if(toPage == 'tobacco'){	//判断是重庆还是四川活动（tobacco代表四川、chongqing代表重庆）
                                $scope.lotteryMsg = "恭喜您！刮出了"+data.award.name+"！";
                                $scope.oneTs = "一天一次  天天好运";
                            }else{
                                $scope.lotteryMsg = "恭喜您！刮出了"+data.award.name+"！";
                            }
                            //奖品信息
                            localStorage.setItem("isCoupon" , data.award.isCoupon);
                            localStorage.setItem("name" , data.award.name);
                            localStorage.setItem("awardId" , data.award.awardId);
                            localStorage.setItem("imgUrl" , data.award.imgUrl);
                            localStorage.setItem("isPost" , data.award.isPost);
                            localStorage.setItem("arrivalTime" , data.award.arrivalTime);
                            localStorage.setItem("recordCode" , data.recordCode);
                            $(".toAward").show();
                            $scope.isDraw = true;	//代表抽奖成功
                        },function(){	//有没有奖品
                            $scope.draw = true;
                            $scope.isDraw = false;
                            Interface.getBound(function(json){	//绑定手机号
                                if(json.code == '0000'){	//code == 0000代表绑定了手机号
                                    if(toPage == 'tobacco'){
                                        $scope.lotteryMsg = "没HOLD住，奖品溜嘎了";
                                        $scope.oneTs = "一天一次  天天好运";
                                    }else{
                                        $scope.lotteryMsg = "很遗憾没中奖，谢谢惠顾！";
                                    }

                                }else{
                                    $scope.lotteryMsg = "没有中奖喔，再刮一次吧！";
                                }
                            });
                        },function(msg){	//代表本次购买不参与活动
                            $(".toAward").hide();
                            $scope.isDraw = false;
                            $scope.draw = false;
                        },function(msg){	//不参与活动
                            $(".toAward").hide();
                            $scope.isDraw = false;
                            $scope.draw = false;
                            $("#tishi").val(msg);
                        });
                    }else{
                        $scope.draw = false;
                    }
                    $scope.wait = false;
                }else if(data.state != '0002' && data.state != '0003'){
                    $scope.wait = true;
                    $scope.draw = false;
                    setTimeout(function(){
                        query();
                    }, 3000);

                    $(".successIcon").empty().append("<span class='Close'>X</span>")
                    $(".success_type").empty().append("<span style='font-size: 20px; font-weight: 800;'>支付失败</span>")

                }else{
                    $scope.draw = false;
                    $scope.wait = false;

                    $(".successIcon").empty().append("<span class='Close'>X</span>")
                    $(".success_type").empty().append("<span style='font-size: 20px; font-weight: 800;'>支付失败</span>")
                }
                $scope.type_msg = data.stateMsg;
                $scope.crtDate_s = data.transTime;
                if(data.thirdTrascationId){
                    $scope.orderNum_s = data.thirdTrascationId;
                }else{
                    $scope.orderNum_s = localStorage.getItem("outTradeNo");
                }

            });
        }

    } catch (e) {
        alert(e.message);
        // TODO: handle exception
    };
});

myApp.controller("addressCtrl" , function($rootScope , $scope , $http , tool , Order , Interface){
    $scope.timer = null;
    tool.updateTitle("商品领取");
    tool.createIscroll("iscroll");

    /*document.querySelector('body').addEventListener('touchstart', function (ev) {
        event.preventDefault();
    });*/

    $scope.telphone = localStorage.getItem("cellphone");

    Interface.getHistoricalAddress(function(data){
        $(".gotAddress").show();
        $scope.adds = data;

        setTimeout(function(){
            $(".gotAddress label").click(function(){
                var src = $(this).find("img").attr("src").split("/");
                var imgPic = src[src.length-1];
                if(imgPic == 'check-pic.png'){
                    $(this).parent().siblings().find("img").attr("src",url+'/test/images/check-pic.png');
                    $(this).parent().siblings().find("input").attr("checked",false);
                    $(this).find("img").attr("src",url+'/test/images/checked-pic.png');
                }else{
                    $(this).find("img").attr("src",url+'/test/images/check-pic.png');
                }
            });
        }, 100);
    });

    Interface.getArea(1 , function(data){
        $scope.provinces = data;
    });

    $scope.changeP = function(){
        $scope.citys = "";
        $scope.areas = "";
        Interface.getArea($scope.province , function(data){
            $scope.citys = data;
        });
    };

    $scope.changeC = function(){
        $scope.areas = "";
        Interface.getArea($scope.city , function(data){
            $scope.areas = data;
        });
    };

    $scope.getCode = getCode;

    function getCode(){
        $scope.getCode = null;
        var minutes = 60;
        $("#getCodeBtn").val(minutes+"s后重新获取");
        Interface.sendMsg(localStorage.getItem("cellphone"));
        $scope.timer = setInterval(function(){
            minutes--;
            if(minutes <= 0){
                clearInterval($scope.timer);
                $("#getCodeBtn").val("获取验证码");
                $scope.getCode = getCode;
            }else{
                $("#getCodeBtn").val(minutes+"s后重新获取");
            }
        }, 1000);
    };

    $scope.sub = sub;

    function sub(){
        var id = $(".gotAddress input[type='checkbox']:checked").val();

        if(!$scope.province && !id){
            alert("请选择省份");
        }else if(!$scope.city && !id){
            alert("请选择地市");
        }else if(!$scope.area && !id){
            alert("请选择区域");
        }else if(!$scope.detailAddress && !id){
            alert("请输入详细地址");
        }else if(!$scope.userName && !id){
            alert("请输入收件人");
        }else if(!$scope.telphone && !id){
            alert("请输入联系电话");
        }else if(!$scope.code){
            alert("请输入验证码");
        }else{
            $scope.sub = null;

            var province = $("#province").find("option:selected").text();
            var city = $("#city").find("option:selected").text();
            var area = $("#area").find("option:selected").text();
            Interface.awardVerification(localStorage.getItem("awardVerificationUrl") , {
                "address" : {
                    "contacts" : $scope.userName,
                    "cellphone" : $scope.telphone,
                    "addressId" : id,
                    'detailAddress' : province+city+area+$scope.detailAddress,
                },
                "customerPhone" : localStorage.getItem("cellphone"),
                "smsCode" : $scope.code,
                'recordCode':localStorage.getItem("recordCode"),
                'openId':localStorage.getItem("openId"),
            },function(data){
                clearInterval($scope.timer);
                $("#getCodeBtn").val("获取验证码");
                $scope.getCode = getCode;
                location.hash="/subSuccess";
            },function(){
                $scope.sub = sub;
            });
        }
    };

});

myApp.controller("subSuccessCtrl" , function($rootScope , $scope , $http , tool){
    $scope.imgUrl = localStorage.getItem("imgUrl");
    $scope.name = localStorage.getItem("name");
    $scope.arrivalTime = localStorage.getItem("arrivalTime");
});

myApp.controller("notReceivedCtrl" , function($rootScope , $scope , $http , tool , Interface){
    try{
        $(".cont").height($(window).height()*0.85);
        Interface.getUnclaimed(function(data){
            $scope.not = data;
            /*tool.createIscroll("listBox");*/
        });

        $scope.receive = function(){
            var This = this;
            Interface.getBound(function(json){
                if(json.code == '0000'){
                    award(This);
                    localStorage.setItem("cellphone" , json.data.cellphone);
                }else{
                    $("#bindBox").show();
                    bind($scope , $http , function(json , bindPhone){
                        if(json.code == '0000'){
                            $("#bindBox").hide();
                            localStorage.setItem("cellphone" , $scope.phone);
                            award(This);
                        }else{
                            alert(json.msg);
                            $scope.bindPhone = bindPhone;
                        }
                    } , Interface);
                }
            });


            function award(obj){
                localStorage.setItem("awardId" , obj.n.award.id);
                localStorage.setItem("imgUrl" , obj.n.award.imgUrl);
                localStorage.setItem("name" , obj.n.award.name);
                localStorage.setItem("arrivalTime" , obj.n.award.arrivalTime);
                localStorage.setItem("outTradeNo",obj.n.outTradeNo);
                localStorage.setItem("recordCode",obj.n.recordCode);
                localStorage.setItem("isCoupon",obj.n.isCoupon);
                if(obj.n.award.isPost == 0){
                    if(obj.n.award.isCoupon == 1){
                        Interface.receiveAward({
                            customerPhone : localStorage.getItem("cellphone"),
                            recordCode : localStorage.getItem("recordCode"),
                            openId : localStorage.getItem("openId"),
                        },function(){
                            location.hash="/subSuccess";
                        })
                    }else{
                        location.hash="/subSuccess";
                    }
                }else{
                    localStorage.setItem("awardVerificationUrl" , pathUrl+'/ynAward/receiveAward');
                    location.hash = '/address';
                }
            };

        };
    }catch(e){
        alert(e.message);
    }
});

function initTime($scope , obj , type){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth()+1;
    var select = document.getElementsByClassName("timeSelect")[0];
    var options = "";
    for(var i = month;i > 0; i--){
        var m = i.toString().length == 2?i:"0"+i.toString();
        var v = year+""+m+"-"+year+"年"+m+"月";
        options += "<option value='"+v+"'>"+year+"年"+m+"月</option>";
        if(i == month){
            document.getElementById("timeText").innerHTML = year+"年"+m+"月";
            if(type == 1){
                obj.getOrderList(year+""+m , localStorage.getItem("openId") , $scope);
            }else{
                obj.getPointdetailList(year+""+m , localStorage.getItem("openId") , $scope);
            }

        };
    }
    select.innerHTML = options;
};

function bind($scope , $http , fn , Interface){
    var timer = null;
    var time = 60;

    $scope.getCodeBtn = getCodeBtn;

    function getCodeBtn(){
        if(!$scope.phone){
            alert("请输入手机号");
        }else{
            $scope.getCodeBtn = "";
            var obj = document.getElementById("getCodeBtn");
            obj.innerHTML = time+"s重新获取";
            obj.value = time+"s重新获取";
            timer = setInterval(function(){
                if(time > 0){
                    time--;
                    obj.innerHTML = time+"s重新获取";
                    obj.value = time+"s重新获取";
                }else{
                    obj.innerHTML = "获取验证码";
                    obj.value = time+"获取验证码";
                    time = 60;
                    clearInterval(timer);
                    $scope.getCodeBtn = getCodeBtn;
                }
            }, 1000);

            Interface.sendMsg($scope.phone);

        }
    };

    $scope.bindPhone = bindPhone;

    function bindPhone(){
        try{
            $scope.bindPhone = null;
            if(!$scope.vacode){
                alert('请输入验证码');
                $scope.bindPhone = bindPhone;
            }else{
                $http({
                    url : pathUrl+'/ynCustomer/bind',
                    method:'post',
                    data:JSON.stringify(
                        {"cellphone":$scope.phone,
                            "smsCode":$scope.vacode,
                            "openId":localStorage.getItem("openId"),
                        }),
                    headers: { 'Content-Type': 'application/json;charset=UTF-8'}
                }).success(function(json){
                    fn(json , bindPhone);
                }).error(function(){
                    alert("错误");
                });
            };
        }catch(e){
            alert(e.message);
        }
    };
}

/*<form method="post" action="http://h5pay.jd.com/jdpay/customerPay" id="jdForm">
	    <input type="hidden" name="version" id="version"/>
	    <input type="hidden" name="merchant" id="merchant"/>
	    <input type="hidden" name="device" id="device"/>
	    <input type="hidden" name="tradeNum" id="tradeNum"/>
	    <input type="hidden" name="tradeName" id="tradeName"/>
	    <input type="hidden" name="tradeTime" id="tradeTime"/>
	    <input type="hidden" name="currency" id="currency"/>
	    <input type="hidden" name="amount" id="jdAmount"/>
	    <input type="hidden" name="callbackUrl" id="callbackUrl"/>
	    <input type="hidden" name="notifyUrl" id="notifyUrl"/>
	    <input type="hidden" name="ip" id="ip"/>
	    <input type="hidden" name="expireTime" id="expireTime"/>
	    <input type="hidden" name="orderType" id="orderType"/>
	    <input type="hidden" name="sign" id="sign"/>
	    <input type="hidden" name="payMerchant" id="payMerchant"/>
	    <input type="hidden" name="tradeType" id="tradeType"/>
	    <input type="hidden" name="riskInfo" id="riskInfo" />
	</form>*/

