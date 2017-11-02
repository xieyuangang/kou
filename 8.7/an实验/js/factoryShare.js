myApp.factory("Interface" , function($http , tool){
	return {
		getEvaluateInfo:function(shopId , fn){
			var This = this;
			$http({
	    		url:url+'/shopIntroduction/getShopEvaluateInfo?shopId='+shopId+"&pageNum=1&pageSize=100",
	    		method:'get',
	    	}).success(function(json){
	    		fn(json);
	    	}).error(function(msg){
	    		alert("系统错误！");
	    	});	
		},
		
	};
});
