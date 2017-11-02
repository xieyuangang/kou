<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=320,maximum-scale=1.3,user-scalable=no">
    <title>错误提示</title>
    <style type="text/css">
        body , html ,section{ width: 100%;height: 100%;padding: 0;margin: 0;}
        section{ background: #f2f2f2;text-align: center;}
        img{ width: 150px;height: 150px;margin-top: 70px;margin-bottom: 40px;}
        div{ font-size: 18px;color: #bfbfbf;line-height: 30px;display: block;width: 100%;}
    </style>
</head>
<body>
    <section>
    	<img src="${ctx }/images/error.png" />
    	<!-- <div>二维码未启用</div> -->
    	<div>${errormsg }</div>
    </section>
</body>
</html>