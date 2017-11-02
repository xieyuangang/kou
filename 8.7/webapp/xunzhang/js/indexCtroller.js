/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("goodsListCtrl" , function($scope , $http , tool , $rootScope , Interface){
    document.getElementById("iscroll").style.height = document.body.offsetHeight - 44 +"px";

    tool.createIscroll('iscroll');

    Interface.getGoodsList({
        success : function(data){
            $scope.goodsList = data;
        }
    });
    
    Interface.balance(function(data){
    	$scope.balance = data;
    });

    $scope.toOrder = function(){
        localStorage.setItem("id" , this.g.id);
        localStorage.setItem("name" , this.g.name);
        localStorage.setItem("stockNum" , this.g.stockNum);
        localStorage.setItem("url" , this.g.url);
        localStorage.setItem("price" , this.g.price);
        localStorage.setItem("scoreNum" , this.g.scoreNum);
        location.hash = '/order';
    };

    $scope.toRecord = function(){
        location.hash = '/record';
    };
    
    $scope.toBack = function(){
    	backClickListener.back();
    };


});

myApp.controller("orderCtrl" , function($scope , $http , tool , $rootScope , Interface){
    $scope.addressBox = true;
    $scope.detailAddress = $rootScope.detailAddress;
	$scope.contacts = $rootScope.contacts;
	$scope.cellphone = $rootScope.cellphone;
	$scope.addressId = $rootScope.id;
    $scope.name = localStorage.getItem("name");
    $scope.stockNum = localStorage.getItem("stockNum");
    $scope.price = localStorage.getItem("price");
    $scope.scoreNum = localStorage.getItem("scoreNum");
    $scope.urlImg = localStorage.getItem("url");

    Interface.balance(function(data){
    	$scope.balance = data;
    });
    
    Interface.getHistoricalAddress({
    	success:function(data){
    		if(!$scope.addressId && !$scope.cellphone){
    			$scope.detailAddress = data[0].detailAddress;
        		$scope.contacts = data[0].contacts;
        		$scope.cellphone = data[0].cellphone;
        		$scope.addressId = data[0].addressId;
    		}
    		$scope.addBtn = false;
    		$scope.addressBox = true;
    	},
    	error:function(){
    		if($rootScope.isShow){
    			$scope.addressBox = true;
    		}else{
    			$scope.addBtn = true;
    		}
    	},
    });
    
    $scope.toBack = function(){
        history.back();
    };

    $scope.toAddressList = function(){
        location.hash = '/addressList';
    };

    $scope.toAddress = function(){
        location.hash = '/address';
    };
    
    $scope.exchange = exchange;

    function exchange(){
    	$scope.exchange = null;
        Interface.exchange({
            param : {
                "memberId" : localStorage.getItem("memberId"),
                "giftId" : localStorage.getItem("id"),
                "number" : 1,
                "addressId" : $scope.addressId,
                "contacts" : $scope.contacts,
                "cellphone" : $scope.cellphone,
                "detailAddress" :$scope.detailAddress,
            },
            success : function(json){
            	if(json.code == '0000'){
            		$rootScope.prompt = "恭喜您，兑换成功！";
            	}else{
            		$rootScope.prompt = "很抱歉，兑换失败！";
            	}
            	$rootScope.name = $scope.name;
        		$rootScope.urlImg = $scope.urlImg;
                location.hash = '/result';
            },
        });
    };
});

myApp.controller("recordCtrl" , function($scope , $http , tool , $rootScope , Mui , Interface){
    document.getElementById("iscroll").style.height = document.body.offsetHeight - 100 + "px";
    var timeResult = document.getElementById("timeResult");
    
    tool.createIscroll('iscroll');

    $scope.toBack = function(){
    	Mui.hide();
        history.back();
    };
    
    var date = new Date();
    var currentYear = date.getFullYear();
    var currentMonth = date.getMonth()+1;
    timeResult.innerText = currentYear+"年"+currentMonth+"月";
    Interface.records({
    	"memberId":localStorage.getItem("memberId"),
    	"startDate": currentYear+'-'+currentMonth,
    	"success":function(data){
    		$scope.records = data;
    	}
    });
    var month = [{value:"1",text:"1"},{value:"2",text:"2"},{value:"3",text:"3"},{value:"4",text:"4"},{value:"5",text:"5"},{value:"6",text:"6"},{value:"7",text:"7"},{value:"8",text:"8"},{value:"9",text:"9"},{value:"10",text:"10"},{value:"11",text:"11"},{value:"12",text:"12"}]
    var data  =[];
    for(var i = 0;i < 10;i++){
        var obj = {value : currentYear,text : currentYear,children:month};
        data.push(obj);
        currentYear--;
    }
    Mui.PopPicker({
        layer : 2,
        buttons : ['取消' , '确定'],
        data : data,
    });

    $scope.showSelect = function(){
        Mui.show(function(data){
        	timeResult.innerText = data[0].value+"年"+data[1].value+"月";
        	Interface.records({
            	"memberId":localStorage.getItem("memberId"),
            	"startDate": data[0].value+'-'+data[1].value,
            	"success":function(data){
            		$scope.records = data;
            	}
            });
        });
    };
});

myApp.controller("addressListCtrl" , function($rootScope , $scope , $http , tool , $rootScope , Interface){
    document.getElementById("addressIscroll").style.height = document.body.offsetHeight - 88 +"px";

    $scope.toBack = function(){
        history.back();
    };

    $scope.toAddress = function(){
        location.hash = '/address';
    };
    
    Interface.getHistoricalAddress({
    	success:function(data){
    		$scope.list = data;
    	},
    	error:function(){},
    });
    
    $scope.toOrder = function(){
    	$rootScope.id = this.a.addressId;
    	$rootScope.detailAddress = this.a.detailAddress;
    	$rootScope.contacts = this.a.contacts;
    	$rootScope.cellphone = this.a.cellphone;
    	location.hash = '/order';
    };
    
});

myApp.controller("addressCtrl" , function($scope , $http , tool , $rootScope , Mui , Interface){
	var areaResult = document.getElementById("areaResult");
	
	$scope.detailAddress = "";
	$scope.contacts = "";
	$scope.cellphone = "";
	
    $scope.toBack = function(){
    	Mui.hide();
        history.back();
    };
    
    var province = new Array();
    var area = new Array();
    var city = new Array();
    Interface.getArea(0 , function(data){
    	for(var i = 0;i < data.length;i++){
    		var objP = new Object;
    		objP.value = data[i].id;
    		objP.text = data[i].name;
    		objP.children = [];
    		province.push(objP);
    		Interface.getArea(data[i].id , function(data , areaN){
    			for(var j = 0;j < data.length;j++){
    				var objA = new Object;
    	    		objA.value = data[j].id;
    	    		objA.text = data[j].name;
    	    		objA.children = [];
    	    		province[areaN].children.push(objA);
    	    		Interface.getArea(data[j].id , function(data , areaN , cityN){
    	    			for(var c = 0;c < data.length;c++){
    	    				var objC = new Object;
    	    	    		objC.value = data[c].id;
    	    	    		objC.text = data[c].name;
    	    	    		province[areaN].children[cityN].children.push(objC);
    	    	    	}
    	    			initPicker();
    	    		},areaN , j);
    	    	}
    		},i);
    	}
    });
    
    
    function initPicker(){
    	Mui.PopPicker({
            layer : 3,
            buttons : ['取消' , '确定'],
            data : province,
        });
    	
    	$scope.getArea = function(){
    		Mui.show(function(data){
        		$scope.area = data[0].text+data[1].text+data[2].text;
        		areaResult.innerText = data[0].text+data[1].text+data[2].text;
            });
        };
    };
    
    
    $scope.sure = function(){
    	if(!$scope.contacts){
    		alert("请输入联系人");
    	}else if(!$scope.cellphone){
    		alert("请输入联系人电话");
    	}else if(!$scope.area){
    		alert("请选择区域");
    	}else if(!$scope.detailAddress){
    		alert("请输入详细地址");
    	}else {
    		$rootScope.contacts = $scope.contacts;
    		$rootScope.cellphone = $scope.cellphone;
    		$rootScope.detailAddress = $scope.area+$scope.detailAddress;
    		$rootScope.isShow = true;
    		location.hash = "/order";
    	}
    }

});

myApp.controller("resultCtrl" , function($scope , $http , tool , $rootScope , Mui , Interface){

    $scope.toBack = function(){
        history.back();
    };
    
    Interface.balance(function(data){
    	$scope.balance = data;
    });
    
    $scope.toGoodsList = function(){
    	location.hash = '/goodsList';
    };
 
});

