<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp" ng-init="url='${ctx}';memberId='${memberId}'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title>统计信息</title>
    <link href="${ctx}/exchange/css/style.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/exchange/js/fastclick.js"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/angular.js"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/angular-ui-router.js"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/app.js"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/currPointDeductionConfig.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/factory.js"></script>
    <script type="text/javascript" src="${ctx}/exchange/js/pointCtroller2.js"></script>
    <script type="text/javascript">
    	var pathUrl = "${ctx}";
    	var url = '${ctx}';
    </script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>