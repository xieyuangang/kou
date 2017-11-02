<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>活动</title>
     <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0"/>
     <link href="${ctx}/css/style.css" rel="stylesheet" />
     <script type="text/javascript" src="${ctx}/js/jquery-3.1.0.min.js"></script>
     <script type="text/javascript" src="${ctx}/js/style.js"></script>
</head>
<script>
var url = '${ctx}';
var machine_code = '${machine_code}';
 //console.log(url)
</script>	
<body>

<div class="nav">
    <input type="number" class="text" placeholder="请输入手机号码">
    <div class='navs'>
    <h3 style='text-align: center;line-height: 100px; color: #fff;'>暂无服务......</h3>
    <!--  <button class='button' id='One'>请点击取烟1号机</button>
     <button class='button' id='two'>请点击取烟2号机</button>-->
    <!--  <div>
         <button class='button' id='three'>1号通道请点击取烟</button> 
         <b class="btn btn-small reset-code" id="J_resetCode" style="display:none;"><b id="J_second">20</b>秒后出烟</b>
     </div>	 -->
     
    
    </div>
   <div class="zhaun">
        <div style="width: 80%;margin: 50% auto;height: 20%;border-radius: 9px;text-align: center;background: #fff;">
            <h3><b id="J_second">15</b>秒</h3>	
            <b class="btn btn-small reset-code" id="J_resetCode">正请求出烟，请等待....</b>
             
        </div>	
</div>
</div>
</body>
</html>