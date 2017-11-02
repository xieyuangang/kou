<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp"  ng-init="ctx='${ctx}';openId='${openId }';custMd5='${custMd5 }';amount_s='${order.amount }';userPoint_s='${order.userPoint }';crtDate_s='${order.crtDate }';orderNum_s='${order.orderNum }';shopName_s='${shopName }';cell='${order.userPhone }';type_s='${order.orderState }';nickname='${nickname }';headimgurl='${headimgurl }';isActived='${isActived }'">
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
    	window.onload = function(){
    		window.location.hash = "/success";
    	};
    </script>
    <script type="text/javascript" src="${ctx }/hm/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/app.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/config.js?random=<%=Math.random()%>"></script>
    <script type="text/javascript" src="${ctx }/hm/js/factory.js"></script>
    <script type="text/javascript" src="${ctx }/hm/js/indexCtroller.js"></script>
</head>
<body>
    <div ui-view="" style="height: 100%;"></div>
</body>
</html>