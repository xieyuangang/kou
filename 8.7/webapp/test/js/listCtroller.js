myApp.controller("listCtrl" , function($scope , $http){
	document.getElementById("listBox").style.height = document.body.offsetHeight - 120 + "px";
	
	var myScroll,
		pullUpEl, pullUpOffset,
		generatedCount = 0;
	var pageNumber = 1;
	var array = [];
	
	$scope.$watch('transTime',function(newValue,oldValue, scope){
		if(newValue){
			array = [];
			pageNumber = 1;
			var date = new Date(newValue);
			$scope.time = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
			pullUpAction();
		}
	});
	
	$scope.transTime = new Date();
	
	function pullUpAction() {
		$http({
			url: url+"/getKkpayOrder" , 
			method : "post" ,
			data : {"pageSize":20,"pageNumber":pageNumber,"crtDate":$scope.time,"custId":$scope.custId}
		}).success(function(json){
			if(json.code == 200){
				var list = json.data;
				for(var i = 0;i<list.length;i++){
					var date = new Date(list[i].crtDate);
					var hours = (date.getHours()+"").length == 2 ? date.getHours() : "0"+date.getHours();
					var minutes = (date.getMinutes()+"").length == 2 ? date.getMinutes() : "0"+date.getMinutes();
					var time = hours+":"+minutes;
					list[i].transTime = time;
					array.push(list[i]);
				}
				pageNumber++;
				$scope.array = array;
				pullUpEl.style.display = "show";
			}else{
				pullUpEl.style.display = "none";
			}
			myScroll.refresh();	
		});
	}
	
	function loaded() {
		pullUpEl = document.getElementById('pullUp');	
		pullUpOffset = pullUpEl.offsetHeight;
		
		myScroll = new iScroll('listBox', {
			useTransition: true,
			topOffset: 0,
			onRefresh: function () {
				if (pullUpEl.className.match('loading')) {
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '获取更多订单...';
				}
			},
			onScrollMove: function () {
				if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
					pullUpEl.className = 'flip';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '松开加载数据...';
					this.maxScrollY = this.maxScrollY;
				} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '获取更多订单...';
					this.maxScrollY = pullUpOffset;
				}
			},
			onScrollEnd: function () {
				if (pullUpEl.className.match('flip')) {
					pullUpEl.className = 'loading';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '数据加载中...';				
					pullUpAction();
				}
			}
		});
	}
	
	loaded();
	
});