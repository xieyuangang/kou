<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>红码管家后台管理系统</title>
    <meta name="description" content="LarryCMS Version:1.09"/>
    <meta name="Author" content="larry"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" type="text/css" href="${ctx}/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/css/main.css" media="all">
    <script type="text/javascript" src="${ctx}/layui/layui.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jparticle.jquery.js"></script>
	<script type="text/javascript" src="${ctx}/js/login.js"></script>
</head>
<body>
<div class="larry-canvas" id="canvas"></div>
<div class="layui-layout layui-layout-login">
    <h1>
        <strong>红码管家后台管理系统</strong>
        <em>红码管家</em>
    </h1>
     <form action=""  method = 'post'>
        <div class="layui-user-icon larry-login">
            <input type="text" placeholder="账号" name="username" class="login_txtbx nam"/>
        </div>
        <div class="layui-pwd-icon larry-login">
            <input type="password" placeholder="密码" name="password" class="login_txtbx word"/>
        </div>
        <div class="layui-submit larry-login">
            <input type="submit" value="立即登陆" class="submit_btn"/>
        </div>
    </form>
    <div class="layui-login-text">
        <p>${error }</p>
        <p>${kickOutMsg }</p>
    </div>
</div>
<div style="display:none">
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?6848a6ecfb975d7426bfbd0f297a690f";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
</div>
</body>
</html>