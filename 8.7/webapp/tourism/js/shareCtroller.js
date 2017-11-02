/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("shareCtrl" , function($scope , $http , tool , $rootScope , Interface){
	clearInterval(iTimer);
	var imgList = new Array();
	$(".imgUrls").each(function(){
		imgList.push($(this).val());
	});
	$scope.imgList = imgList;
	$rootScope.imgList = imgList;
	
	var i = 1;
	var l = $(".imgUrls").length;
	$("#imgs").width(320*l);
	var iTimer = setInterval(function(){
		if(i < l ){
			$("#imgs").animate({
				left: "-"+(320*i)
			});
			i++;
		}else{
			$("#imgs").animate({
				left: "0"
			});
			i = 1;
		}
		
	}, 2000);


	Interface.getEvaluateInfo($scope.shopId , function(json){
		if(json){
			$scope.total = json.total;
			evaluate(json , 2);
		}
	});
});

myApp.controller("evaluateCtrl" , function($scope , $http , tool , $rootScope , Interface){
	Interface.getEvaluateInfo($scope.shopId , function(json){
		if(json){
			$scope.total = json.total;
			if(json.rows){
				evaluate(json , json.rows.length);
			}
			
		}
	});
});

myApp.controller("imagesCtrl" , function($scope , $http , tool , $rootScope , Interface){
	
	var w = $(window).width();
	var h = $(window).height();
	
	$(".tdH").height(h);
	
	$scope.showBig = function(){
		var src = $(this).attr("src");
		$("#bigImg").attr("src",this.i);
		$("#bigBox").show().animate({
			width:w+'px',
			height:h+'px',
			top:'0px',
			left:'0px',
			opacity:'1',
		});
	}
	
	$scope.hide = function(){
		$("#bigBox").hide().css({
			width:'0px',
			height:'0px',
			top:'50%',
			left:'50%',
			opacity:'0',
		});
		
	}
	
});


function evaluate(json , num){
	if(json.rows){
		for(var i = 0;i < num;i++){
			var str = "";
			for(var j = 0;j < 5;j++){
				if(j < json.rows[i].star){
					str += '<img src="'+url+'/tourism/images/score_choose.png" class="score"/>';
				}else{
					str += '<img src="'+url+'/tourism/images/score.png" class="score"/>';
				}
			}
			var customer = json.rows[i].customer;
			var createTime = new Date(json.rows[i].createTime);
			$("#evaluate").append('<li>'+
                '<table>'+
                    '<tr>'+
                        '<td rowspan="2">'+
                            '<img src="'+url+'/tourism/images/avatar.jpg" class="avatar"/>'+
                        '</td>'+
                        '<td>手机用户:'+customer.replace(/(\d{3})\d{4}(\d{4})/, "$1****$2")+'</td>'+
                        '<td align="right">'+createTime.getFullYear()+'.'+(createTime.getMonth()+1)+'.'+createTime.getDate()+'</td>'+
                    '</tr>'+
                    '<tr>'+
                        '<td colspan="2">'+str+'</td>'+
                    '</tr>'+
                '</table>'+
            '</li>')
		}
	};
}


