<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>商户信息管理</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript" src="${ctx}/layui/layui.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/dateFormat.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/easyui-lang-zh_CN.js" charset="utf-8"></script>
	     <style>
           .layui-inline{margin-bottom: 5px;}
         </style>
	</head>
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form id="userForm" action="" class="layui-form layui-form-pane">
       
        <div class="layui-inline">
            <label class="layui-form-label">行业</label>
            <div class="layui-input-inline">
                <select id="s_industry" name="industry" lay-verify="required">
                    <option value="">烟草</option>
                   <option value="${role.id }">${role.name}</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">新商盟账号</label>
            <div class="layui-input-block">
                <input name="xsmAccount" type="text" maxlength="30" id="" class="layui-input easyui-textbox" style="width:120px;"/>
            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">红码手机号</label>
            <div class="layui-input-block">
                <input name="cell" type="text" maxlength="30" id="s_cell" class="layui-input easyui-textbox" style="width:120px;"/>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">身份证号</label>
            <div class="layui-input-block">
                <input name="idCard" type="text" maxlength="30" id="s_idCard" class="layui-input easyui-textbox" style="width:120px;"/>
            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">注册时间</label>
            <div class="layui-input-block">
                <input name="createTime" type="text" maxlength="30" id="s_createTime" class="layui-input easyui-textbox" style="width:120px;"/>
            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">注册状态</label>
            <div class="layui-input-inline">
                <select id="s_state" lay-verify="required">
                    <option value="">请选择</option>
                    <option value="0">申请中</option>
                    <option value="1">可用</option>
                    <option value="2">停用</option>
                </select>
            </div>
        </div>
      	<shiro:hasPermission name="merchant:view">
	        <div class="layui-inline"  id="toStorePage" onclick="javascript:search();" >
	        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>查询</a>
	       </div>
       </shiro:hasPermission>
        <shiro:hasPermission name="merchant:update">
	        <div class="layui-inline" id="updateRole" onclick="javascript:updateUserDialog();" >
	            <a class="layui-btn layui-btn-normal batchDel"><i class="layui-icon">&#xe642;</i>修改</a>
	        </div>
      	</shiro:hasPermission>
    </form>
</blockquote>
 <div>
     <table id="tt" style="height:452px;"></table>
     <script type="text/javascript">
				$("#tt").css("width",$(window).width()-20);
	</script>
 </div> 
  <!-- dialog -->
<div id="userDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:320px;height:300px;padding:10px;"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
         <form class="easyui-form" id="userForm" method="post">
            <fieldset style="width:280px">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
				    <tr>
                        <td><input id="userId" name="userId" type="hidden"/></td>
                    </tr>
                    <tr>
                        <td>手机号<b>*</b></td>
                        <td><input id="cell" name="cell" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'手机号不能为空!'"></input></td>
                    </tr>
                     <tr>
                        <td>真实姓名</td>
                        <td><input id="realName" name="realName" class="layui-input easyui-validatebox" type="text"
                                   ></input></td>
                     </tr>
                     <tr>
                       <td>身份证</td>
                        <td><input id="idCard" name="idCard" class="layui-input easyui-validatebox" type="text"
                                   ></input></td>
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
       onclick="$('#userDialog').dialog('close');">关闭</a>
</div>
 
 
 
 
 
 
 <script>
    layui.use(['form', 'layedit', 'laydate'], function () {
    });
</script>
<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
			var name = $('#searchShopName').val();
			var endCreateTime = $('#endCreateTime').val();
			$('#tt').datagrid({
				url:'${ctx}/store/getMerchantInfoList',
				pagination:true,
				rownumbers : true,
				singleSelect:true,
				fitColumns : true,
				collapsible : true,
				autoRowHeight : true,
				loadMsg : "数据加载中,请稍等...",
				//frozenColumns : [[{field : 'ck',checkbox : true}]],
				columns:[[
				    {title:'账号', field:'account',width:50,align:'center'},
				    {title:'店铺名称', field:'shopName',width:50,align:'center'},
				    {title:'真实姓名', field:'realName',width:50,align:'center'},
				    {title:'身份证号', field:'idCard',width:50,align:'center'},
				    {title:'手机号', field:'cell',width:50,align:'center'},
					{title:'店铺地址', field:'shopAddress',width:50,align:'center'},
				    {title:'E账户状态', field:'Eaccount',width:50,align:'center'},
				    {title:'注册时间', field:'createTime',width:120,align:'center',
						formatter:function(value){
							return $.formatDate(value);
								}}					
						]]
				 });
			}
			
		 	function search(){
		 		var industry = $('#s_industry').val();
				var xsmAccount = $('#s_xsmAccount').val();
				var idCard = $('#s_idCard').val();
				var cell = $('#s_cell').val();
				var state = $('#s_state').val();
				var createTime = $('#s_createTime').val();
				$("#tt").datagrid('load',{
					industry:industry,
					xsmAccount:xsmAccount,
					idCard:idCard,
					cell:cell,
					state:state,
					createTime:createTime
		    	});
			}
			function updateUserDialog(){
			    	var chks= $('#tt').datagrid('getChecked');
			    	if(null!=chks && chks.length==1){
			    		$.ajax({
			    			url:'${ctx}/user/getUserByAccount',
			    			type:"POST",
			    			data:{'account':chks[0].account},
			    			dataType:"json",
			    			async: false,
			    			success:function(data){
			    				data = data.data;
				    			if(null!=data){
				    				  $('#userForm').form('clear');
				    				  $('#userId').val(data.userId);
									  $('#account').val(data.account);
									  $('#cell').val(data.cell);
									  $('#realName').val(data.realName);
									  $('#idCard').val(data.idCard);
					    			$('#userDialog').dialog('open');
				    			}
			    			},error:function(data){
			    				$.messager.alert('提示',data,'error');
			    				hideLoading();
			    			}
			    		});
			    	}else{
			    		$.messager.alert('提示',"请选择一项进行修改!",'info');
			    	}
			    }
			function submitForm(){
		    	var userId=$("#userId").val();
		    	var idCard=$("#idCard").val();
		    	var cell=$("#cell").val();
		    	var realName = $("#realName").val();
		    	 $.ajax({
					url:'${ctx}/user/updateUser',
					type:"POST",
					data:JSON.stringify({
						  'userId':userId,
						  'realName':realName,
						  'idCard':idCard,
						  'cell':cell,
					}),
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						$('#tt').datagrid('reload');
			    		$('#tt').datagrid('clearSelections');
			    		$('#userDialog').dialog('close');
						hideLoading();
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				}); 
	        }
    //***********************************************************************************************//
    //********************************************** 华丽分割线 ***************************************//
    //***********************************************************************************************//
</script>
	</body>
</html>