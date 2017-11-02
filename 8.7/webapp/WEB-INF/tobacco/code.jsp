<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp"  ng-init="ctx='${ctx}';">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title>红码</title>
    <link href="${ctx }/hm/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${ctx }/hm/css/index.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx }/hm/js/angular.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/angular-ui-router.js"></script>
    <script type="text/javascript">
    	var url = '${ctx}';
    </script>
    <script type="text/javascript" src="${ctx }/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/app.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/qrcode.js"></script>
    <script type="text/javascript">
	    window.onload = function(){
	    	var qrcode = new QRCode(document.getElementById("qrcode"), {
	        	width : 160,
	        	height : 160
	        });
	    	
	    	qrcode.makeCode('${retail.codeUrl2}');
	    	
	    	
	    };
	    myApp.controller("hmskCtrl" , function($scope){
    		$scope.back = function(){
    			closeWP();
    		};
    		
    		function closeWP() {
    			 var Browser = navigator.appName;
    			 var indexB = Browser.indexOf('Explorer');

    			 if (indexB > 0) {
    			    var indexV = navigator.userAgent.indexOf('MSIE') + 5;
    			    var Version = navigator.userAgent.substring(indexV, indexV + 1);

    			    if (Version >= 7) {
    			        window.open('', '_self', '');
    			        window.close();
    			    }
    			    else if (Version == 6) {
    			        window.opener = null;
    			        window.close();
    			    }
    			    else {
    			        window.opener = '';
    			        window.close();
    			    }

    			 }
    			else {
    			    window.close();
    			 }
    			}
    	});
    </script>
</head>
<body>
    <section ng-controller="hmskCtrl">
    	<div class="codeBox">
    		<div class="code_header">
    			<div class="row">
    				<div class="col-sm-12 col-xs-12 text-center">${retail.shopName }</div>
    			</div>
    		</div>
    		<div class="code_cont">
    			<div id="qrcode"></div>
    		</div>
    		<div class="code_header">
    			<div class="row">
    				<div class="col-sm-12 col-xs-12 text-center">扫码向我付款</div>
    			</div>
    		</div>
    	</div>
    </section>
</body>
</html>