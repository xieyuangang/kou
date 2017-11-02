<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp" ng-init="url='${ctx }';memberId='${memberId}'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title>随机减红包</title>
    <link rel="stylesheet" href="${ctx }/homeDialog/css/home.css">
    <link rel="stylesheet" href="http://at.alicdn.com/t/font_s7j4oelyotdfgvi.css">
    <script type="text/javascript" src="${ctx }/homeDialog/js/angular.js"></script>
    <script type="text/javascript" src="${ctx }/homeDialog/js/angular-ui-router.js"></script>
    <script type="text/javascript" src="${ctx }/homeDialog/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="${ctx }/homeDialog/js/app.js"></script>
    <script type="text/javascript" src="${ctx }/homeDialog/js/service.js"></script>
    <script type="text/javascript" src="${ctx }/homeDialog/js/config.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx }/homeDialog/js/indexCtroller.js?random=<%=Math.random()%>"></script>
    <script>
    	var url = '${ctx }';
    	var activityCode ='${activityCode}';
    	var rootUrl = 'merchant.inlee.com.cn';
    </script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>