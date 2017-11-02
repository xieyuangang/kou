myApp.directive("prompt" , function(tool){
    return {
        restrice : "AE",
        template : "<div class='promptBox' id='promptBox'>"+
        		   		"<span class='promptText'>{{prompt}}</span>"+
             	   "</div>",
    };
}).directive("loading" , function(tool){
    return {
        restrice : "AE",
        template : "<div class='loading' id='loading'>"+
        		   		"<img src='{{ctx}}/test/images/loading.gif' />"+
             	   "</div>",
    };
});