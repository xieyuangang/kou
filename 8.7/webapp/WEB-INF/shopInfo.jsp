<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=320,maximum-scale=1.3,user-scalable=no">
    <title>店铺信息</title>
    <style>
        body , html{ width: 100%;height: 100%;padding: 0;margin: 0;background: #fff;overflow: hidden;}
        section{ margin: 10px;height:100%;display: table}
        .cell{ display: table-cell;vertical-align: middle;}
        .title{ font-size: 20px;}
        .info{ margin: 15px;font-size: 15px;}
        
        .container{ margin: 0 10px;}
        
        header{ width: 100%;background: #c60c1b;padding: 12px 0;}
		header table{ width: 100%;height: 26px;color:#fff;font-size: 15px;}
		header table .more{ font-size: 14px;text-align: right;}
		header table img{ width: 15px;display: block;}
		header table .back{ width: 25px;border-right: 1px solid #fff;}
		header table .title{ padding-left: 10px;}
		
		.btn{ position: absolute;bottom: 20px;width: 100%;text-align: center;}
		.btn input{ width: 90%;height: 50px;border: none;background: #c60c1b;color: #fff;border-radius:5px;}
    </style>
</head>
<body>
	
    <div class="info">店铺名称：${shopName}</div>
	<div class="info">店铺地址：${shopAddress}</div>
	<div class="info">新商盟账号：${custId}</div>
	<div class="info">烟草专卖证号：${license}</div>
	
	<div class="btn">
		<input type="button" value="确定" onclick="javascript:backClickListener.back()"/>
	</div>
</body>
</html>