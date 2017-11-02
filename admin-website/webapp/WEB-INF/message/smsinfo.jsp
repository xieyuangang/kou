<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>消息查询</title>
	<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/css/news.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${ctx}/js/jquery-1.9.1.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/dateFormat.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/easyui-lang-zh_CN.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/ajaxfileupload.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/layui/layui.js" charset="utf-8"></script>
	<style>
		.layui-inline { margin-bottom: 5px; }
	</style>
</head>
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
	<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
		<form action="" class="layui-form layui-form-pane">
			<div class="layui-inline">
				<label class="layui-form-label">手机号</label>
				<div class="layui-input-block">
					<input id="phoneSearch" type="text" maxlength="20"
						class="layui-input easyui-textbox" style="width: 180px;" value="" />
				</div>
			</div>
			<shiro:hasPermission name="message:search:view">
				<div class="layui-inline click" id="toSmsInfoPage" onclick="javascript:search();">
					<a class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe615;</i>查询</a>
				</div>
			</shiro:hasPermission>
		</form>
	</blockquote>
	
	<!-- grid -->
	<div>
	     <table id="tt" style="height:452px;"></table>
	     <script type="text/javascript">
					$("#tt").css("width",$(window).width()-20);
		</script>
 	</div> 

	<script type="text/javascript">
		$(function(){
			initGrid();
		});

		
		function initGrid() {
			$('#tt').datagrid({
				url : '${ctx}/sms/findAllSmsInfo',
				idField : "messageId",
				pagination : true,
				rownumbers : true,
				fitColumns : true,
				collapsible : false,
				fitColumns : true,
				autoRowHeight : true,
				loadMsg : "数据加载中,请稍等...",
				frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				} ] ],
				columns : [ [ {
					title : '消息表Id',
					field : 'messageId',
					width : 50,
					align : 'center',
					hidden : 'true'
				}, {
					title : '手机号',
					field : 'targetReal',
					width : 50,
					align : 'center'
				}, {
					title : '请求来源',
					field : 'source',
					width : 50,
					align : 'center',
					formatter : function(value) {
						return value == 'website' ? "红码后台管理" : " ";
					}
				}, {
					title : '消息内容',
					field : 'msg',
					width : 100,
					align : 'center'
				}, {
					title : '状态',
					field : 'status',
					width : 50,
					align : 'center',
					formatter : function(value) {
						return value == 'F' ? "发送失败" : value == 'T' ? "发送成功" : " ";
					}
				}, {
					title : '发送方式',
					field : 'channel',
					width : 100,
					align : 'center',
					formatter : function(value) {
						if (value == 0) {
							return "文件群发";
						} else if (value == 1) {
							return "单用户";
						} else if (value == 2) {
							return "所有用户";
						}
					}
				}, {
					title : '发送时间',
					field : 'sendTime',
					width : 50,
					align : 'center',
					formatter : function(value) {
						if (value == '' || value == null){
							return value;
						}else{
							return $.formatDate(value);
						}
					}
				}, {
					title : '创建时间',
					field : 'createTime',
					width : 50,
					align : 'center',
					formatter : function(value) {
						if (value == '' || value == null){
							return value;
						}else{
							return $.formatDate(value);
						}
					}
				}  ] ]
			});
		}

		function search() {
			var targetReal = $("#phoneSearch").val();
			$("#tt").datagrid('load', {
				targetReal : targetReal,
			});
		}

		// 加载 layui from 使 select 生效
		layui.use('form', function() {
			var form = layui.form();
		});
	</script>
</body>
</html>