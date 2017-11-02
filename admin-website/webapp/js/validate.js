var flagALL = false;

$.fn.extend({
    validate:function(opations){
    	var tagName = $(this)[0].tagName;
    	flagALL = false;
    	
    	if(tagName != 'FORM'){
    		return;
    	}
    	
    	$(this).find("input[type='text'], input[type='password'], input[type='file'], select, textarea, " +
					"input[type='number'], input[type='search'], input[type='tel'], input[type='url'], " +
					"input[type='email'], input[type='datetime'], input[type='date'], input[type='month'], " +
					"input[type='week'], input[type='time'], input[type='datetime-local'], " +
					"input[type='range'], input[type='color'], input[type='radio'], input[type='checkbox']").each(function(){
						var validate = $(this).data("validate");
						if(validate){
							$(this).judge();
						}
					});
    	
    	return flagALL;
    	
    },
    
    clear:function(){
    	var tagName = $(this)[0].tagName;
    	flagALL = false;
    	
    	if(tagName != 'FORM'){
    		return;
    	}
    	
    	$(this).form('clear');
    	
    	$(this).find("input[type='text'], input[type='password'], input[type='file'], select, textarea, " +
					"input[type='number'], input[type='search'], input[type='tel'], input[type='url'], " +
					"input[type='email'], input[type='datetime'], input[type='date'], input[type='month'], " +
					"input[type='week'], input[type='time'], input[type='datetime-local'], " +
					"input[type='range'], input[type='color'], input[type='radio'], input[type='checkbox']").each(function(){
						var validate = $(this).data("validate");
						if(validate){
							$(this).success();
						}
					});
    }
});

$.extend($.fn, {
	event : function(judge) {
		$(this).focus(function(){
			$(this).success();
		});
		
		$(this).blur(function(){
			$(this).judge();
		});
		
		$(this).change(function(){
			$(this).judge();
		});
	},
	
	error : function(msg){
		var message = msg ? msg : $(this).data("messageRequired");
		$(this).parent().addClass("validate-has-error");
		if($(this).siblings("span").attr("class")){
			$(this).siblings("span").text(message);
		}else{
			$(this).parent().append('<span class="validate-has-error">'+message+'</span>');
		}
		
	},
	
	success : function(This){
		$(this).parent().removeClass("validate-has-error");
		$(this).siblings("span").remove();
	},
	
	judge : function(){
		$(this).unbind();
		var validate = $(this).data("validate");
		var arr = validate.split(" ");
		var val = $(this).val();
		var flag = false;
		var l = false;
		if(val instanceof Array){
			if(val.length == 0) l = true;
		}
		
		for(var i = 0;i < arr.length;i++){
			switch (arr[i]) {
				case "required":
					if(!val || l){
						$(this).error();
						$(this).event();
						flag = true;
						flagALL = true;
					}else{
						$(this).success();
					}
					break;
				case "tel":
					var telReg = /^1[3|4|5|7|8][0-9]\d{8}$/;
					if(!telReg.test(val)){
						$(this).error("请输入正确的手机号");
						$(this).event();
						flag = true;
						flagALL = true;
					}else{
						$(this).success();
					}
					break;
				default:
					break;
			}
			
			if(flag) return;
			
		}
	}
});
