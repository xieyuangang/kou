/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("homeCtrl" , function($scope , $http , tool,Homeface){
//	$scope.toList = function(){
//		/*backClickListener.jump(rootUrl+'/dialog/toPage?memberId='+$scope.memberId+'#/detail')*/
//		location.hash = "/detail";
//	}
	var shopList = '';
	Homeface.getShopList($scope.memberId , function(data){
		shopList = data
	})
	$scope.sure = function(){
		var array = new Array();
		for(var i=0;i<shopList.length;i++){
			array[i] = shopList[i].qrCode
		}
		//console.log(array);
		
		Homeface.getShopDetail($scope.memberId , array , 'scCoupon' , function(json){
		    alert("成功");
		});
	}
	
});

myApp.controller("detailController" , function($scope , Interface){//调用提交
	Interface.getShopList($scope.memberId , function(data){
		$scope.list = data;

	})
	$scope.sure = function(){
		var array = new Array();
		$("input[type='checkbox']:checked").each(function(){
			array.push($(this).val());
		});

		Interface.getShopDetail($scope.memberId , array , 'scCoupon' , function(json){
		    alert("成功");
		});
	}
});

$(function(){
	if(activityCode=="scCoupon"){
		$("#name").html("1、每订购1条云南中烟活动烟品（小熊猫、恭贺新禧、初心）配置10个随机减红包，用来发给扫红码购烟的消费者；")
	}else if(activityCode=="scCoupon2"){
		$("#name").html("1、每订购1条四川中烟活动烟品（娇子传奇、娇子红芙蓉、娇子祥云）配置10个随机减红包，用来发给扫红码购烟的消费者:")
	}
})


