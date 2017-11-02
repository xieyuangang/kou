/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("currPointCtrl" , function($scope , $http , tool , $rootScope , Interface){
	
	document.getElementById("wapper").style.height = document.body.offsetHeight - 186 + "px";
	
	$scope.toMore = function(){
		location.hash = '/more';
	}
	
	Interface.getIntegralExchangeDetail("memberId="+$scope.memberId,function(data){
		$scope.rows = data.list.rows;
		$scope.tradeNum = data.tradeNum + " 笔";
		$scope.integralPointDay = data.integralPointDay || 0 + " 积分";
		$scope.integralPointTotal = data.integralPointTotal + " 积分";
		setTimeout(() => {
			tool.createIscroll("wapper");
		}, 10);
		
	});
	
});

myApp.controller("moreCtrl" , function($scope , $http , tool , $rootScope , Interface){
	$scope.back = function(){
		location.hash = '/currPoint';
	}
	
	document.getElementById("wapper").style.height = document.body.offsetHeight - 213 + "px";
	
	var currPage = 1;
	var flag = false;
	var date = new Date();
	var year = date.getFullYear()
	var month = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : "0"+(date.getMonth()+1);
	var day = date.getDate() > 9 ? date.getDate() : "0"+date.getDate();
	var exchangeDate = year+"-"+month;
	$scope.timeText = year+"年"+month+"月";
	
	showList(exchangeDate , currPage);
	//---------------------------------------
	var pullUpEl = document.getElementById('pullUp');	
	var pullUpOffset = pullUpEl.offsetHeight;
	tool.refreshIscroll("wapper" , function(){
		pullUpEl.className = '';
		pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多';
	} , function(){
		if(flag){
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '松开加载数据...';
				this.maxScrollY = this.maxScrollY;
			} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = pullUpOffset;
			}
		}
		
	} , function(){
		if(flag && pullUpEl.className.match('flip')){
			pullUpEl.className = 'loading';
			pullUpEl.querySelector('.pullUpLabel').innerHTML = '数据加载中...';		
			currPage += 1;
			showList(exchangeDate , currPage);
		}
	})
	
	

	
	//-----------------------------------------------
	
	$("#date").change(function(){
		currPage = 1;
		var v = $(this).val();
		exchangeDate = v;
		var s = v.split("-");
		$scope.timeText = s[0]+"年"+s[1]+"月";
		showList(v , currPage , 'newDate')
	});
	
	
	function showList(exchangeDate , pageNum , newDate){
		Interface.getIntegralExchangeDetail("memberId="+$scope.memberId+"&exchangeDate="+exchangeDate+"&pageNum="+pageNum+"&pageSize=20",function(data){
			if(newDate == 'newDate'){
				$scope.rows = [];
			}
			var rows = $scope.rows || [];
			$scope.rows = rows.concat(data.list.rows);
			
			$scope.tradeNum = data.tradeNum + " 笔";
			
			$scope.integralPointDay = data.integralPointDay || 0 + " 积分";
			
			if(data.integralPointTotal){
				$scope.integralPointTotal = data.integralPointTotal + " 积分";
			}
			
			if(data.list.rows && data.list.rows.length >= 20 && $scope.rows.length >= 20){
				flag = true;
				$("#pullUp").show();
			}else{
				flag = false;
				$("#pullUp").hide();
			}
			setTimeout(() => {
				tool.iScroll.refresh();
			}, 10);
		});
	}
});