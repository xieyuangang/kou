myApp.factory("Mui" , function(tool){
	return {
		picker : null,
		PopPicker : function(obj){
			this.picker = new mui.PopPicker({
				layer : obj.layer,
				buttons : obj.buttons,
			});
			if(obj.data){
				this.picker.setData(obj.data);
			};
			
			for(var i = 0; i < obj.layer; i++){
				this.picker.pickers[i].setSelectedIndex(0);
			};
		},
		setData : function(data){
			this.picker.setData(data);
		},
		show : function(callback){
			this.picker.show(function(SelectedItem) {
				callback(SelectedItem);
			});
		},
		hide : function(){
			this.picker.hide();
		}

	}
});

myApp.factory("Interface" , function($http , tool){
	return {
		getGoodsList:function(obj){
			$http({
	    		url:url+'/medal/gifts?memberId='+localStorage.getItem("memberId"),
	    		method:'get',
	    	}).success(function(json){
	    		if(json.code=='0000') {
					obj.success(json.data)
				}else {
					alert(json.msg);
				}
	    	}).error(function(msg){
				alert(msg);
	    	});
		},

		exchange:function(obj){
			$http({
				url:url+'/medal/exchange',
				method:'post',
				data:JSON.stringify(obj.param),
				headers: { 'Content-Type': 'application/json;charset=UTF-8'}
			}).success(function(json){
				obj.success(json);
			}).error(function(msg){
				alert(msg);
			});
		},
		
		records:function(obj){
			$http({
				url:url+'/medal/records?memberId='+obj.memberId+"&startDate="+obj.startDate,
				method:'get',
			}).success(function(json){
				if(json.code=='0000') {
					obj.success(json.data);
				}else {
					alert(json.msg);
				}
			}).error(function(msg){
				alert(msg);
			});
		},
		
		getArea : function(id , fn , areaN , cityN){
			$http({
				url:url+"/ynAddress/getZoneByParentId?parentId="+id,
				method:'get',
			}).success(function(json){
				if(json.code=='0000'){
					fn(json.data , areaN , cityN);
				}else{
					alert(json.msg);
				}
			});
		},
		
		getHistoricalAddress : function(obj){
			$http({
				url:url+"/medal/address?memberId="+localStorage.getItem("memberId"),
				method:'get',
			}).success(function(json){
				if(json.code == '0000'){
					obj.success(json.data);
				}else{
					obj.error();
				}
			});
		},
		
		balance : function(fn){
			$http({
				url:url+"/medal/balance?memberId="+localStorage.getItem("memberId"),
				method:'get',
			}).success(function(json){
				if(json.code == '0000'){
					fn(json.data);
				}else{
					alert(json.msg);
				}
			});
		}
	};
});
