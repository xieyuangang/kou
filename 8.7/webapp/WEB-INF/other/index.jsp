<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp" ng-init="url='${ctx }';shopName='${shopName}'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title ng-bind="title"></title>
    <link href="${ctx }/pay/css/index.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx }/pay/js/fastclick.js"></script>
    <script type="text/javascript" src="${ctx }/pay/js/angular.js"></script>
    <script type="text/javascript" src="${ctx }/pay/js/angular-ui-router.js"></script>
    <script type="text/javascript" src="${ctx }/pay/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="${ctx }/pay/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx }/pay/js/app.js"></script>
    <script type="text/javascript" src="${ctx }/pay/js/config.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx }/pay/js/factory.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx }/pay/js/indexCtroller.js?random=<%=Math.random()%>"></script>
    
    <script type="text/javascript">
        var pathUrl ='${ctx}';
    	var url = '${ctx}';
    	var activityCode = '${activityCode}';
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