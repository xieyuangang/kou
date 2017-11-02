var myApp = angular.module('myApp',['ui.router'],function($httpProvider) {
    // 头部配置
    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';
    $httpProvider.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';
    $httpProvider.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';

    var param = function (obj) {
        var query = '', name, value, fullSubName, subName, subValue, innerObj, i;

        for (name in obj) {
            value = obj[name];

            if (value instanceof Array) {
                for (i = 0; i < value.length; ++i) {
                    subValue = value[i];
                    fullSubName = name + '[' + i + ']';
                    innerObj = {};
                    innerObj[fullSubName] = subValue;
                    query += param(innerObj) + '&';
                }
            }
            else if (value instanceof Object) {
                for (subName in value) {
                    subValue = value[subName];
                    fullSubName = name + '[' + subName + ']';
                    innerObj = {};
                    innerObj[fullSubName] = subValue;
                    query += param(innerObj) + '&';
                }
            }
            else if (value !== undefined && value !== null)
                query += encodeURIComponent(name) + '=' + encodeURIComponent(value) + '&';
        }

        return query.length ? query.substr(0, query.length - 1) : query;
    };

    $httpProvider.defaults.transformRequest = [function (data) {
        return angular.isObject(data) && String(data) !== '[object File]' ? param(data) : data;
    }];
}).filter('cut', function () {
    return function (value) {
    	var date = new Date(value);
    	var month = Number(date.getMonth())+1;
        return date.getFullYear()+"-"+month+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes();
    };
}).filter('bt' , function(){
	return function(value){
		var split = value.split(",");
		var str = "";
		if(split[0] != 0 && split[0]){
			str += split[0]+"包";
		}
		if(split[1] != 0 && split[1]){
			str += split[1]+"条";
		}
		return str;
	};
}).filter("splitImg" , function(){
	return function(value){
		var split = value.split(";");
		return split[1];
	}
});

myApp.service("tool" , function(){
    this.getLocalhost = function(){
        var pathName=window.document.location.pathname;
        return window.location.protocol+"//"+window.location.host + pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    };


    this.array = [];

    this.init = function() {
        try {
            var This = this;
            var dpr, rem, scale;
            var docEl = document.documentElement;
            var fontEl = document.createElement('style');
            var metaEl = document.querySelector('meta[name="viewport"]');
            dpr = window.devicePixelRatio || 1;
            rem = docEl.clientWidth * dpr / 10;
            scale = 1 / dpr;
            // 设置viewport，进行缩放，达到高清效果
            metaEl.setAttribute('content', 'width=' + dpr * docEl.clientWidth
                + ',initial-scale=' + scale + ',maximum-scale=' + scale
                + ',minimum-scale=' + scale + ',user-scalable=no');
            // 设置data-dpr属性，留作的css hack之用
            docEl.setAttribute('data-dpr', dpr);
            // 动态写入样式
            docEl.firstElementChild.appendChild(fontEl);
            fontEl.innerHTML = 'html{font-size:' + rem + 'px!important;}';
            // 给js调用的，某一dpr下rem和px之间的转换函数
            window.rem2px = function(v) {
                v = parseFloat(v);
                return v * rem;
            };
            window.dpr = dpr;
            window.rem = rem;
        } catch (e) {
            // TODO: handle exception
            alert(e.message);
        }

    };

    this.$ = function(name) {
        var splits = name.split(" ");
        var docu = document;
        var a = [];
        var arr = [];
        var arrs = [];
        for ( var i = 0; i < splits.length; i++) {
            arr = arrs;
            arrs = [];
            if (arr.length > 0) {
                for ( var o = 0; o < arr.length; o++) {
                    docu = arr[o];
                    get(splits[i]);
                }
            } else {
                get(splits[i]);
            }
        }

        function get(n) {
            var f = n.substr(0, 1);
            var s = n.substring(1, n.length);
            if (f == ".") {
                a = docu.getElementsByClassName(s);
            } else if (f == "#") {
                a.push(docu.getElementById(s));
            } else {
                a = docu.getElementsByTagName(n);
            }
            for ( var j = 0; j < a.length; j++) {
                arrs.push(a[j]);
            }
        }
        this.array = arrs;

        return this;
    };

    this.siblings = function(obj) {
        var parent = obj.parentNode;
        var childs = parent.childNodes;
        var arr = [];
        for ( var i = 0; i < childs.length; i++) {
            if (childs[i] !== obj && childs[i].nodeName != "#text" && childs[i].tagName) {
                arr.push(childs[i]);
            }
        }
        this.array = arr;
        return this;
    };

    this.forArray = function(fn) {
        for ( var i = 0; i < this.array.length; i++) {
            fn(this.array[i]);
        }

    };

    this.css = function(obj) {
        this.forArray(function(o) {
            for ( var key in obj) {
                o.style[key] = obj[key];
            }
        });
    };

    this.show = function() {
        this.forArray(function(o) {
            o.style["display"] = "block";
        });
    };

    this.hide = function() {
        this.forArray(function(o) {
            o.style["display"] = "none";
        });
    };

    this.clear = function() {
        this.forArray(function(o) {
            o.style = "";
        });
    };

    this.click = function(fn) {
        this.forArray(function(o) {
            o.onclick = fn;
        });

    };

    this.addClass = function(sClass, obj) {
        var aClass = obj.className.split(" ");
        if (!obj.className) {
            obj.className = sClass;
            return;
        }
        for ( var i = 0; i < aClass.length; i++) {
            if (aClass[i] === sClass)
                return;
        }
        obj.className += ' ' + sClass;
    };

    this.removeClass = function(sClass, obj) {
        if (obj) {
            f(obj);
        } else {
            this.forArray(function(o) {
                f(o);
            });
        }

        function f(obj) {
            var aClass = obj.className.split(" ");
            if (!obj.className) {
                return;
            }
            for ( var i = 0; i < aClass.length; i++) {
                if (aClass[i] === sClass) {
                    aClass.splice(i, 1);
                    obj.className = aClass.join(' ');
                    break;
                }
                ;
            }
        }
    };

    this.height = function(height){
        this.forArray(function(o) {
            o.style.height = height + "px";
        });
    }

    this.lineHeight = function(height){
        this.forArray(function(o) {
            o.style.lineHeight = height + "px";
        });
    }

    this.openDialog = function(msg){
        document.getElementById("ts").innerHTML = msg;
        $('#myModal').modal({
            show:true
        });
    };
    
    this.createIscroll = function(id){
		new iScroll(id, { 
			checkDOMChanges: true,
			vScrollbar:false,
			bounce:true,
			onBeforeScrollStart: function (e) {
				var target = e.target;
				while (target.nodeType != 1) target = target.parentNode;

				if (target.tagName != 'SELECT' && target.tagName != 'INPUT' && target.tagName != 'TEXTAREA')
					e.preventDefault();
			}
		});
	};

    this.dataFormat = function(value){
        var date =new Date(value);
        if (!date){return '';}
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        var h = date.getHours();
        var M = date.getMinutes();
        var s = date.getSeconds();
        return y + '-' + (m<10?('0'+m):m)+'-'+d + ' ' + (h<10?('0'+h):h) + ':' + (M<10?('0'+M):M) + ':' + (s<10?('0'+s):s);
    };
    

	this.updateTitle = function(name) {
		var $body = $('body');
		document.title = name;
		var $iframe = $("<iframe src='/favicon.ico'></iframe>");
		$iframe.on('load', function() {
			setTimeout(function() {
				$iframe.off('load').remove();
			}, 0);
		}).appendTo($body);
	}
});