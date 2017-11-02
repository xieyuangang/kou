<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp"  ng-init="ctx='${ctx}';custMd5='${custMd5 }';shopName='${shopName }';custId='${retail.custId }';title='红码';nickname='${nickname }';headimgurl='${headimgurl }';isActived='${isActived }';isTouchA='false';shopQRCode='${shopQRCode }';license='${license }'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title ng-bind="title"></title>
    <link href="${ctx }/test/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${ctx }/test/css/index.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx }/test/js/angular.js"></script>
    <script type="text/javascript" src="${ctx }/test/js/angular-ui-router.js"></script>
    <script type="text/javascript">
   			 /*var pathUrl = "../paytest"; */
    		var pathUrl = '${ctx}'; 
    		var url = '${ctx}';
    		var openId = '${openId}';
    		var userId = '${userId}';
    		var activityCode = '${activityCode}';
    		var toPage = "scCoupon2";
    		localStorage.setItem("shopQRCode",'${shopQRCode}');
    		localStorage.setItem("staffMId",'${staffMId}');
    		if(openId != 'null'){
    			localStorage.setItem("openId",openId);
    		}
    		if(userId != ""){
    			localStorage.setItem("userId",userId);
    		}
    </script>
    <script type="text/javascript" src="${ctx }/test/js/jquery.1.11.0.min.js"></script>
    <script type="text/javascript" src="${ctx }/test/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx }/test/js/app.js"></script>
    <script type="text/javascript" src="${ctx }/test/js/config.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx }/test/js/factory.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx }/test/js/directive.js"></script>
    <script type="text/javascript" src="${ctx }/test/js/indexCtroller.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx }/test/js/wScratchPad.js"></script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>