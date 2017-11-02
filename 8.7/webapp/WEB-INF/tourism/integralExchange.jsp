<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <title ng-bind="title"></title>
    <style type="text/css">
    	body , html { padding: 0;margin: 0;background: #f2f2f2;width:100%;height: 100%;overflow: hidden;}
    	.box{ width: 90%;height: 94%;margin: 5%;border: 1px solid #7E7E7E;background: #fff;}
    	.cell{ vertical-align: middle;}
    	.container{ margin: 15px;}
    	.top{ font-size: 28px;text-align: center;margin-bottom: 30px;}
    	.msg{ width: 100%;}
    	.msg td{ padding: 5px 0;}
    	.again{ width: 100%;height: 44px;font-size: 18px;color: #fff;font-weight: bold;background: #F04137;border: none;border-radius:5px;margin-top: 50px;}
    	.serviceHotline{ text-align: right;font-size: 14px;margin-top: 10px;}
    	.agentBox{ width: 100%;border: 1px solid #B1B1B1;border-radius:10px;margin-top: 15px;background-color: #E3E3E3}
    	.title{ font-size: 20px;color: #0066CF;text-align: center;padding: 10px;}
    	.cont{ font-size: 13px;color: #858585;padding: 5px 10px;line-height: 20px;overflow: hidden;word-wrap: break-word;} 
    	.cont a{ font-size: 13px;color: #858585;text-decoration: none;} 
    </style>
    <script type="text/javascript">
    	function again(){
    		var ua = navigator.userAgent.toLowerCase();
    		if(ua.match(/micromessenger/i) == "micromessenger"){
				location.href = '${IntegralQrcodeUrl.weixinUrl }';
			}else{
				location.href = '${IntegralQrcodeUrl.taobaoUrl }';
				document.getElementById("agentBox").style.display = "none";
			}
    	}
    </script>
</head>
<body>
	<section class="box">
		<div class="cell">
			<div class="container">
				<div class="top">溯源结果</div>
				<table class="msg">
					<tr>
						<td width="65">发货商：</td>
						<td>${IntegralQrcodeUrl.provideTrade }</td>
					</tr>
					<tr>
						<td>发货地：</td>
						<td>${IntegralQrcodeUrl.provideAddress }</td>
					</tr>
				</table>
				
				<div class="agentBox" id="agentBox">
					<div class="title">再次购买</div>
					<div class="cont">
						<a href='${IntegralQrcodeUrl.taobaoUrl }'>
							${IntegralQrcodeUrl.taobaoUrl }
						</a>
						点击链接，再选择浏览器打开；或复制这条信息，打开手机淘宝
					</div>
				</div>
				
				<input type="button" value="再次购买" class="again" onclick="again()"/>
				
				<div class="serviceHotline">
					服务热线：${IntegralQrcodeUrl.serviceHotline }
				</div>
			</div>
		</div>
	</section>
</body>
</html>