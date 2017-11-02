<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp" ng-init="url='${ctx}';shopName='${shopIntroductionInfo.shopName }';area='${shopIntroductionInfo.area }';detailAddress='${shopIntroductionInfo.detailAddress }';contactWay='${shopIntroductionInfo.contactWay }';shopId='${shopIntroductionInfo.shopId }';content='${shopIntroductionInfo.content }';contactMan='${shopIntroductionInfo.contactMan }'">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=320,maximum-scale=1.3,user-scalable=no">
    <title>${shopIntroductionInfo.shopName }</title>
    <link href="${ctx}/tourism/css/share.css" rel="stylesheet" />
    <script type="text/javascript">
    	var pathUrl = "${ctx}";
        var url = '${ctx}';
    </script>
    <script type="text/javascript" src="${ctx}/tourism/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/angular.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/angular-ui-router.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/app.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/configShare.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/factoryShare.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx}/tourism/js/shareCtroller.js"></script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
    <c:forEach var="url" items="${shopIntroductionInfo.icons}">
    	<input type="hidden" value="${url.pictureUrl }" class="imgUrls"/>
    </c:forEach>
</body>
</html>