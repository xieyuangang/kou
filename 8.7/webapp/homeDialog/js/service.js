myApp.service( 'Homeface' , function($http){//提交
	 	var name = '';
	$(".commodity").each(function(i){
		    
    	 $(this).find("div").click(function(){
    		$(this).css({border:"1px solid red",background:"#d52941",color: "#fff"})
    		$(this).siblings().css({border:"1px solid #e2e2e2",background:"#ffffcb",color:"#691842"})
    	    name=$(this).attr('class')
    	 })
    })
   
    this.getShopDetail = function(memberId , shopQRCodes , activityCode , success){
		if(name==""){
			alert("请选择商品")
			return false
		}
		$http({
    		url:url+'/dialog/changegoods',
    		method:'post',
    		data:JSON.stringify({
    			'goodsCode' : name,
    			'shopQRCodes' : shopQRCodes,
    		}),
    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
    	}).success(function(json){
    		if(json.code=='0000'){
    			//success(json);
    			alert("成功");
    		}else {
				alert(json.msg);
			}
    	}).error(function(msg){
    		alert(msg);
    	});	
    	}
	this.getShopList = function(memberId , success){//提交函数
		$http({
    		url:url+'/dialog/shopList?memberId='+memberId+'&activityCode=scCoupon',
    		method:'get',
    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
    	}).success(function(json){
    		if(json.code=='0000'){
    			success(json.data);
			}else {
				alert(json.msg);
			}
    	}).error(function(msg){
    		alert(msg);
    	});	
	}
});
myApp.service( 'Interface' , function($http){//提交
	   
	 var name = '';
	 $(".commodity").each(function(i){
		    
    	 $(this).find("div").click(function(){
    		$(this).css({background:"#ffffcc"})
    		$(this).siblings().css({background:"#fff"})
    	    name=$(this).attr('class')
    	  
    	 })
    })
   
    this.getShopDetail = function(memberId , shopQRCodes , activityCode , success){
		 if(name==""){
		    alert("请选择商品")
		    return false
		 }
		 $http({
        		url:url+'/dialog/affirm',
        		method:'post',
        		data:JSON.stringify({
        			'memberId' : memberId,
        			'shopQRCodes' : shopQRCodes,
        			'activityCode' : activityCode,
        		}),
        		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
        	}).success(function(json){
        		if(json.code=='0000') {
        			//success(json);
        			$http({
        	    		url:url+'/dialog/changegoods',
        	    		method:'post',
        	    		data:JSON.stringify({
        	    			'goodsCode' : name,
        	    			'shopQRCodes' : shopQRCodes,
        	    		}),
        	    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
        	    	}).success(function(json){
        	    		if(json.code=='0000'){
        	    			//success(json);
        	    			alert("成功");
        	    		}else {
        					alert(json.msg);
        				}
        	    	}).error(function(msg){
        	    		alert(msg);
        	    	});	

        			
    			}else {
    				//alert(name)
    				alert(json.msg);
    			}
        	}).error(function(msg){
        		alert(msg);
        	});	
    	}
 
	
	this.getShopList = function(memberId , success){//提交函数
		$http({
    		url:url+'/dialog/shopList?memberId='+memberId+'&activityCode=scCoupon',
    		method:'get',
    		headers: { 'Content-Type': 'application/json;charset=UTF-8'}
    	}).success(function(json){
    		if(json.code=='0000'){
    			success(json.data);
			}else {
				alert(json.msg);
			}
    	}).error(function(msg){
    		alert(msg);
    	});	
	}
});