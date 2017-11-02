<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>消息审核</title>
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
			<div class="layui-form-item layui-inline">
				<label class="layui-form-label">审核状态</label>
				<div class="layui-input-block" style="width: 180px">
					<select id="isCheck" name="isCheck">
						<option value=""></option>
						<option value="0">待审核</option>
						<option value="1">已审核</option>
						<option value="2">审核未通过</option>
					</select>
				</div>
			</div>
			<shiro:hasPermission name="message:audit:view">
				<div class="layui-inline click" id="toSmsAuditPage" onclick="javascript:search();">
					<a class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe615;</i>查询</a>
				</div>
			</shiro:hasPermission>
			<shiro:hasPermission name="message:audit:success">
				<div class="layui-inline click" id="auditSuccess" onclick="javascript:auditSuccess();">
					<a class="layui-btn"><i class="layui-icon">&#xe605;</i>通过审核</a>
				</div>
			</shiro:hasPermission>
			<shiro:hasPermission name="message:audit:fail">
				<div class="layui-inline click" id="auditFail" onclick="javascript:auditFail();">
					<a class="layui-btn layui-btn-danger"><i class="layui-icon">&#x1006;</i>审核失败</a>
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

		function initGrid(){
			$('#tt').datagrid({
				url:'${ctx}/audit/getAuditByIsCheck',
				idField : "msgAuditId",
				pagination:true,
				rownumbers : true,
				fitColumns : true,
				collapsible : false,
				fitColumns : true,
				autoRowHeight : true,
				loadMsg : "数据加载中,请稍等...",
				frozenColumns : [[{field : 'ck',checkbox : true}]],
				columns:[[
					{title:'消息审核ID', field:'msgAuditId',width:40,align:'center', hidden:true},
		             {title:'发送对象', field:'fileName',width:40,align:'center',
						formatter:function(value){
							if (value == null || value == ""){
								return "所有用户";
							}else{
								return value;
							}
						}},
		             {title:'标题', field:'title',width:40,align:'center'},
		             {title:'消息内容', field:'msg',width:80,align:'center'},
		             {title:'发送类型', field:'type',width:40,align:'center',formatter:function(value){

		            	 if(value == 0){
		            		 return "文件群发";
		            	 }else if(value == 1){
		            		 return "单用户";
		            	 }else if (value == 2){
		            		 return "所有用户"
		            	 }
		             }},
		             {title:'审核状态', field:'isCheck',width:30,align:'center',formatter:function(value){
		            	 if(value == 1){
		            		 return "已审核";
		            	 }else if(value == 2){
		            		 return "审核未通过";
		            	 }else{
		            		 return "待审核";
		            	 }
		             }},
		             {title:'发送状态', field:'sending',width:30,align:'center',formatter:function(value){
		            	 if(value == 1){
		            		 return "已发送";
		            	 }else if(value == 0){
		            		 return "未发送";
		            	 }else if(value == 2){
		            		 return "发送中";
		            	 }else{
		            		 return "发送失败";
		            	 }
		             }},
		             {title:'创建者', field:'provider',width:30,align:'center'},
		             {title:'审核者', field:'auditor',width:30,align:'center'},
		             {title:'创建时间', field:'createTime',width:40,align:'center',
							formatter:function(value){
								return $.formatDate(value);
							}}
		             
		             
				]]
		 });
		}
		
		function search(){
			var isCheck = $("#isCheck").val();
			$("#tt").datagrid('load',{
				isCheck:isCheck,
			});
		}
		
		var fialOrSuccess;
		var info;
		function auditSuccess(){
			fialOrSuccess = 1;
			info = "确定要审核通过该信息吗?";
			audit();
		}
		
		function auditFail(){
			fialOrSuccess = 2;
			info = "确定审核不通过该信息吗?";
			audit();
		}
		
		
		function audit() {
			var chks = $('#tt').datagrid('getChecked');
        	if(chks.length<1){
        		$.messager.alert('提示','请至少选择一项!','');
        		return ;
        	}
				        		
        	var arr = new Array();
        	for(var c in chks){
        		if(chks[c].isCheck==1 || chks[c].isCheck==2){
        			$.messager.alert('提示','该信息已审核不能再次审核','');
        			$('#tt').datagrid('clearSelections');
        			return ;
        		}
        		arr[c] = chks[c].msgAuditId;
        	}
        	
        	$.messager.confirm('提示', info, function(yes){
        		if(yes){
        			showLoading();
        			$.ajax({
        				url:'${ctx}/audit/audit',
        				type:"POST",
        				data:{'ids':arr.toString(),'isCheck':fialOrSuccess},
        				dataType:"json",
        				async: false,
        				success:function(data){
	        				$.messager.alert('提示',data.msg,'');
	        				$('#tt').datagrid('reload');
	        				$('#tt').datagrid('clearSelections');
	        				hideLoading();
        				},error:function(data){
        					$.messager.alert('提示',JSON.stringify(data),'');
        					$('#tt').datagrid('clearSelections');
        					hideLoading();
        				}
        			});
        		}
        	});
		}
		
		// 加载 layui from 使 select 生效
		layui.use('form', function(){
			 var form = layui.form();
			});
	</script>
</body>
</html>