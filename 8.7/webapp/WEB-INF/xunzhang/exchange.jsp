<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp" ng-init="url='${ctx }'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=320,maximum-scale=1.3,user-scalable=no">
    <title></title>
    <link href="${ctx }/xunzhang/css/index.css" rel="stylesheet" />
    <link href="${ctx }/xunzhang/css/mui.picker.min.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx }/xunzhang/js/mui.min.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/mui.picker.min.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/angular.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/angular-ui-router.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/app.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/config.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/factory.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/indexCtroller.js"></script>
    <script type="text/javascript" src="${ctx }/xunzhang/js/iscroll.js"></script>
    <script type="text/javascript">
        var url = '${ctx}';
        var pathUrl = "${ctx}";
        localStorage.setItem("memberId" ,'${memberId}');
    </script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>