/**
 * Created by melanie on 2016/7/12.
 */
myApp.controller("payCtrl" , function($scope , $http ){

	
	$(".ad").height($(window).height() - 398);
	$("button").css({background:"red"});

    if ('addEventListener' in document) {
        document.addEventListener('DOMContentLoaded', function(){
            FastClick.attach(document.body);
        }, false);
    }
    document.querySelector("#click").addEventListener("click",function(){
        alert("click me!");
    })
});



