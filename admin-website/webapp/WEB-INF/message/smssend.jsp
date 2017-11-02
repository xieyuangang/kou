<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>消息发送</title>
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
	<style>
		.layui-inline { margin-bottom: 5px; }
	</style>
</head>
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
	<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
		<form action="" class="layui-form layui-form-pane" enctype="multipart/form-data">
			<div class="layui-inline" >
				<label class="layui-form-label">手机号</label>
				<div class="layui-input-block">
					<input id="phoneSearch" type="text" maxlength="20"
						class="layui-input easyui-textbox" style="width: 180px;" value="" />
				</div>
			</div>
			<shiro:hasPermission name="message:send:view">
				<div class="layui-inline click" id="toSmsSendPage" onclick="javascript:search();">
					<a class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe615;</i>查询</a>
				</div>
			</shiro:hasPermission>
			<shiro:hasPermission name="message:send:all">
				<div class="layui-inline click" id="sendAll" onclick="javascript:sendAllDialog();">
					<a class="layui-btn"><i class="layui-icon">&#xe654;</i>所有用户发送</a>
				</div>
			</shiro:hasPermission>
			<shiro:hasPermission name="message:send:one">
				<div class="layui-inline click" id="sendPhoneNum" onclick="javascript:oneSendDialog();">
					<a class="layui-btn"><i class="layui-icon">&#xe654;</i>指定单个用户发送</a>
				</div>
			</shiro:hasPermission>
			<shiro:hasPermission name="message:send:many">
				<div class="layui-inline click" id="sendMany" onclick="javascript:manySendDialog();">
					<a class="layui-btn"><i class="layui-icon">&#xe654;</i>批量发送</a>
				</div>
			</shiro:hasPermission>
		</form>
	</blockquote>
	<shiro:user></shiro:user>
	<!-- dialog -->
	<div id="sendSmsDialog" title="信息发送" class="easyui-dialog" closed="true" style="width:420px;padding:10px;"
	     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
	    <div class="tab">
	         <form class="easyui-form" id="sendSmsForm" method="post">
	            <fieldset style="width:360px">
	                <legend>带<b>*</b>为必填项</legend>
	                <table border="0"  style="width:340px">
					    <tr>
					    	<!-- terminal和file同为短信发送对象，因此将终端ID存放到msgAudit对象的fileName属性中 -->
	                        <td><input id="terminalId" name="fileName" type="hidden"/></td>
	                    </tr>
	                    <tr>
	                        <td>标题</td>
	                        <td><input id="title" name="title" class="layui-input easyui-validatebox" type="text"></input></td>
	                    </tr>
						<tr>
							<td>消息内容<b>*</b></td>
							<td><textarea id="msg" name="msg" placeholder="消息内容" class="layui-textarea easyui-validatebox"
							 data-options="required:true,missingMessage:'消息内容不能为空!'"></textarea></td>
						</tr>

						<tr>
	                        <td>附加信息</td>
	                        <td><input id="options" name="options" class="layui-input easyui-validatebox" type="text"></input></td>
	                    </tr>
	                    
	                     <tr id="list">
	                        <td>会员ID名单<b>*</b></td>
	                        <td><input class="easyui-validatebox" type="file" id="phoneList" name="phoneList" 
                                   placeholder="会员清单" data-options="required:true,missingMessage:'会员名单不能为空!'">
                                  </td>
	                    </tr>

					</table>
	            </fieldset>
	        </form>
	    </div>
	</div>
	<!-- dialog buttons -->
	<div id="dialog_buttons">
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitForm();">提交</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
	       onclick="$('#sendSmsDialog').dialog('close');">关闭</a>
	</div>
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
				url:'${ctx}/terminal/findAllTerminal',
				idField : "terminalId",
				pagination:true,
				rownumbers : true,
				fitColumns : true,
				collapsible : false,
				fitColumns : true,
				autoRowHeight : true,
				loadMsg : "数据加载中,请稍等...",
				frozenColumns : [[{field : 'ck',checkbox : true}]],
				columns:[[
					 {title:'设备ID', field:'terminalId',width:40,align:'center', hidden:true},
		             {title:'手机号', field:'handerCell',width:40,align:'center'},
		             {title:'会员ID', field:'memberId',width:40,align:'center'},
		             {title:'操作系统', field:'equipOS',width:40,align:'center'},
				]]
		 });
		}
		
		function search(){
			var handerCell = $("#phoneSearch").val();
			$("#tt").datagrid('load',{
				handerCell:handerCell,
			});
		}
	        
		function submitForm(){
			var msg = $("#msg").val();
			if ($.trim(msg) == ""){
				$.messager.alert('提示', "消息内容不能为空", 'info');
				return;
			}
			var phoneList = $("#phoneList").val();
			if (url === "/send/sendByFile"){
				if (phoneList == null || phoneList == ""){
					$.messager.alert('提示', "会员名单不能为空，请选择文件", 'info');
					return;
				}
			}
			
			
			var formData = new FormData($( "#sendSmsForm" )[0]); 
			$.ajax({
				url : '${ctx}' + url,
				type: 'POST',
			    data: formData,
			    async: false,
			    cache: false,
			    contentType: false,
			    processData: false,
				success : function(data) {
					$.messager.alert('提示', data.msg, 'info');
					$('#tt').datagrid('reload');
					$('#tt').datagrid('clearSelections');
					$('#sendSmsDialog').dialog('close');
					hideLoading();
				},
				error : function(data) {
					$.messager.alert('提示', data.msg, 'error');
					hideLoading();
				}
			});
			
		}
		
		function formCheck(){
			
		}
		
		function sendAllDialog(){
			$('#sendSmsForm').form('clear');
			$('#list').hide();
			$('#ID').hide();
			url = "/send/sendAll";
			$('#sendSmsDialog').dialog('open');
		}
		function manySendDialog(){
        	$('#sendSmsForm').form('clear');
			$('#list').show();
			$('#phone').hide();
			$('#ID').hide();
			
        	url = "/send/sendByFile";
        	$('#sendSmsDialog').dialog('open');
		}
		function oneSendDialog(){
        	$('#sendSmsForm').form('clear');
			$('#list').hide();
			$('#ID').hide();
			var chks = $('#tt').datagrid('getChecked');
        	if(null!=chks && chks.length!=1){
        		$.messager.alert('提示','请选择一项进行修改!','');
        		return ;
        	}
        	url = "/send/sendOne";
        	$("#terminalId").val(chks[0].terminalId);
        	$('#sendSmsDialog').dialog('open');
		}
		
	</script>
</body>
</html>