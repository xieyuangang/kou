function dataFormat(value){
				 var date =new Date(value);
		     	 if (!date){return '';}
		     	 var y = date.getFullYear();
		     	 var m = date.getMonth() + 1;
		     	 var d = date.getDate();
		     	 var h = date.getHours();
		     	 var M = date.getMinutes();
		     	 var s = date.getSeconds();
		     	 return y + '-' + (m<10?('0'+m):m)+'-'+d + ' ' + (h<10?('0'+h):h) + ':' + (M<10?('0'+M):M) + ':' + (s<10?('0'+s):s);
		 	}
function ww4(date){  
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
    var d = date.getDate();  
    return  y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);  
      
}  
function w4(s){  
	if (!s) return new Date();
	var y = s.substring(0,4);
	var m = s.substring(4,6);
	var d = s.substring(6,8);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
}  