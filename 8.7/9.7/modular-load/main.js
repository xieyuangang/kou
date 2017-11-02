define(function(require, exports, module) {
		var Mobilebone = require('mobilebone'), Fun = {};
	Fun.page1 = require("1");
	Fun.page2 = require("2");
	Fun.page3 = require("3");
	// 通过 exports 对外提供接口
	/*document.addEventListener("touchend", function(event) {
	 	var target = event.target;
	  	if (target && target.tagName && target.tagName.toLowerCase() == '') {
			target.parentElement.insertAdjacentHTML("afterend", '<p>2秒后回首页...</p>'); 
			setTimeout(function() {
				Mobilebone.transition(document.getElementById("pageHome"), target.parentElement.parentElement, true); 
				var p = target.parentElement.nextElementSibling;
				p && p.parentElement.removeChild(p);
			}, 2000);
	  	}
	});*/
	
	Mobilebone.onpagefirstinto = function(page_in) {
		Fun[page_in.id] && Fun[page_in.id].init(page_in);
	};
	Mobilebone.init();
});