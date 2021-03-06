<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp" ng-init="url='${ctx}';shopName='${shopName}';activityCode='${ activityCode}';taobaoUrl='${IntegralQrcodeUrl.taobaoUrl }';weixinUrl='${IntegralQrcodeUrl.weixinUrl }'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title ng-bind="title"></title>
    <link href="${ctx}/tourism/css/index.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/tourism/js/fastclick.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/angular.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/angular-ui-router.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/app.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/config.js?random=<%=Math.random()%>"></script>
    <!--?random=<%=Math.random()%>清空缓存-->
    <script type="text/javascript" src="${ctx}/tourism/js/factory.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/indexCtroller.js"></script>
    
    <script type="text/javascript">
    	var pathUrl = "${ctx}";
    	var url = '${ctx}';
    	localStorage.setItem("shopQRCode" ,'${shopQRCode}');
    	localStorage.setItem("shopName" ,'${shopName}');
    	if('${openId}'){
    		localStorage.setItem("openId" ,'${openId}');
    	}
    	localStorage.setItem("staffMId" ,"${staffMId}");
    	window.addEventListener('load', function () {  
            FastClick.attach(document.body);  
        }, false); 
    </script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>