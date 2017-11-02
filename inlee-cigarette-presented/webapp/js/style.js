$(function () {
    var date = JSON.stringify({'machine_code': machine_code});
    
    $.ajax({
        url: url + '/consumer/getPorts',
        type: 'post',
        data: date,
        dataType: "json",
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        async: false,
        success: function (data) {
           // console.log(data);
            var cla = '';
            for (var i = 0; i < data.result.length; i++) {

                var app = data.result[i].port_status;
               // var app ='0';
                
                var ppts=data.result[i].statusStr;
                cla += "<button att=" + app + " exception="+ppts+"><b>" + data.result[i].port + "</b>:号通道<br/><span>请点击取烟</span></button>"
               
            }
            $(".navs").empty().append(cla);
        },
        error: function (data) {
            alert("服务器繁忙");
            console.log(data)
        }
    });


    $('.navs').find("button").each(function () {

        var apps = $(this).attr("att");
        var appst = $(this).attr("exception");
        var ben = $(this);
          if(apps=='0'){
        	  clst(ben)
          }else{
        	  $(this).css({background: "#eee", color: "#999"});
              $(this).find("span").html(appst)
          }
        
        /*if (apps == '5') {
          
            $(this).css({background: "#eee", color: "#999"});
            $(this).find("span").html(appst)
        } else if (apps == '3') {
          
            $(this).css({background: "#eee", color: "#999"});
            $(this).find("span").html(appst)
        } else {
            clst(ben)
        }*/
    });
});

function clst(ben) {
	var n=0;
    ben.click(function () {

        var phone = $(".text").val();

        var port = $(this).find("b").html();

        if (!(/^1[3,4,5,7,8]\d{9}$/.test(phone))) {
            alert("手机号码不正确重新输入");
            return false;
        }
      
    
        
        var date = JSON.stringify({'machine_code': machine_code, 'phone': phone, 'port': port});
        //console.log(date);
        
        var nowTime = new Date().getTime();
        var clickTime = $(this).attr("ctime");
        if( clickTime != 'undefined' && (nowTime - clickTime < 5000)){
            //alert('操作过于频繁，稍后再试');
        	console.log(1)
            return false;
         }else{
            $(this).attr("ctime",nowTime);
            //alert('提交成功');
   
        	$.ajax({
                url: url + '/consumer/getCigarette',
                type: 'post',
                data: date,
                dataType: "json",
                headers: {'Content-Type': 'application/json;charset=UTF-8'},
                async: true,
                success: function (data) {
                   var orderNum =data.result
                
                    if (data.code == "0000") {
                    
                    	   resetCode(orderNum)
                    	   	 console.log(data)
                          // alert("领取成功\r\n" + port + "号通道正在出烟");
                      
                    } else {
                        alert(data.msg);
                        history.go(0) 
                        console.log(data)
                    }
                },
                error: function (data) {
                    alert("服务器繁忙");
                    //console.log(data);
                  
                }
            })
            
         }       
        

        
       
        
        	
        
     
    })
}

function resetCode(orderNum){

	 $(".zhaun").show();
     $('#J_second').html('15');
    var second = 15;
    var timer = null;
    timer = setInterval(function(){
        second -= 1;
        if(second >0 ){
            $('#J_second').html(second);
        }else{
            clearInterval(timer);
           // $(".zhaun").hide();
        }
         var date={orderNum:orderNum}
        if(second=='2'){
        	
        	 $.ajax({
                 url: url + '/consumer/getOrderStatus',
                 type: 'get',
                 data: date,
                 dataType: "json",
                 headers: {'Content-Type': 'application/json;charset=UTF-8'},
                 async: true,
                 success: function (data) {
                   //console.log(data)
             	 var code='0000';
             	
        		
                 if(data.code=='0000'){
                	    if(data.result=='0001'){
                	    	 $(".zhaun").hide();
                	    	 timer =  setInterval(function(){
                	    		 alert("出烟成功")
                	    		 history.go(0) 
                	    		 clearInterval(timer);
                	    	 },100)
                	    }else{
                	    	 $(".zhaun").hide();
                	    	  timer =  setInterval(function(){
                	    		 alert("出烟失败")
                	    		 history.go(0) 
                	    		 clearInterval(timer);
                	    	 },100)
                	    }
                   }else{
                	   $(".zhaun").hide();
                	   timer =  setInterval(function(){
                		   alert(data.msg)
                		   history.go(0) 
          	    		 clearInterval(timer);
          	    	 },100)
                	  
                   }
                 },
                 error: function (data) {
                	 $(".zhaun").hide();
                     timer =  setInterval(function(){
                    	 alert("服务器繁忙");
                    	 history.go(0) 
        	    		 clearInterval(timer);
        	    	 },100)
                 }
             })
        }
    },1000);
}
