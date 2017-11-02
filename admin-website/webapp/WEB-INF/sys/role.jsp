<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>管理</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/css/themes/icon.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/css/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript" src="${ctx}/js/jquery-3.1.1.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/validate.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js" charset="utf-8"></script>
	     <style>
           .layui-inline{margin-bottom: 5px;}
         </style>
	</head>
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form action="" class="layui-form layui-form-pane">
        <div class="layui-inline">
			<label class="layui-form-label">角色名称</label>
            <div class="layui-input-block">
                <input id="searchCondition" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        <div class="layui-inline click"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>搜索</a>
       </div>
         <shiro:hasPermission name="sys:role:add">
        <div class="layui-inline click" id="addUser" onclick="javascript:addRoleDialog();" >
            <a class="layui-btn layui-btn batchDel"><i class="layui-icon">&#xe61f;</i>添加</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:role:update">  
        <div class="layui-inline click" id="updateUser" onclick="javascript:updateRoleDialog();" >
            <a class="layui-btn layui-btn-normal batchDel"><i class="layui-icon">&#xe642;</i>修改</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:role:delete">
        <div class="layui-inline click" id="deleteUser"  onclick="javascript:deleteRole();">
            <a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:role:authMenu">
        <div class="layui-inline click" id="addRoleAuth" onclick="javascript:assignPermDialog();">
            <a class="layui-btn layui-btn-warm batchDel"><i class="layui-icon">&#xe614;</i>分配菜单</a>
        </div>
         </shiro:hasPermission> 
    </form>
</blockquote>	
<!-- dialog -->
<div id="roleDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:360px;height:320px;padding:10px"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
        <form class="easyui-form" id="roleForm" method="post">
            <fieldset style="width:300px">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
				    <tr>
                        <td><input id="roleId" name="roleId" type="hidden"/></td>
                    </tr>
					 <tr>
                        <td>角色名称<b>*</b></td>
                        <td><input id="name" name="name" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'角色名称不能为空!'"></input></td>
                    </tr>
					 <tr>
                        <td>角色代码<b>*</b></td>
                        <td><input id="code" name="code" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'角色代码不能为空!'"></input></td>
                    </tr>
					 <tr>
                        <td>角色分组<b>*</b></td>
                        <td><input id="group" name="group" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'角色分组不能为空!'"></input></td>
                    </tr>
					 <tr>
                        <td>权限值<b>*</b></td>
                        <td><input id="permission" name="permission" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'权限值不能为空!'"></input></td>
                    </tr>
					 <tr>
                        <td>备注</td>
                        <td><input id="remark" name="remark" class="easyui-validatebox" type="text"
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
	       onclick="$('#roleDialog').dialog('close');">关闭</a>
	</div>
	<div>
	     <table id="tt" style="height:452px;"></table>
	</div>
	<!-- 权限分配窗口 -->
		<div id="assignPermDialog" title="权限菜单" class="easyui-dialog" closed="true"  style="width:340px;height:500px;padding:10px" data-options="iconCls:'icon-save',modal:true" buttons="#assignPerm_buttons">
			<div class="tab">
			<form>
				<fieldset style="width:270px">
					<legend>带勾为选中</legend>
					<ul id="rt"></ul>
				</fieldset>
			</form>
			</div>
		</div>
		<!-- 权限分配 -->
		<div id="assignPerm_buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="assignPerm();">提交</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#assignPermDialog').dialog('close');">关闭</a>
	    </div>		       
		<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
				 $('#tt').datagrid({
						url:'${ctx}/role/getRolePage',
						idField : "roleId",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'角色标识', field:'roleId',width:50,align:'center'},
				             {title:'角色名称', field:'name',width:50,align:'center'},
				             {title:'角色代码', field:'code',width:50,align:'center'},
				             {title:'角色分组', field:'group',width:50,align:'center'},
				             {title:'权限值', field:'permission',width:50,align:'center'},
				             {title:'备注', field:'remark',width:50,align:'center'},
				             {title:'创建时间', field:'createTime',width:50,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}}							
						]]
				 });
			}
			
			function search(){
					var name = $("#searchCondition").val();
		    	    $("#tt").datagrid('load',{
		    	    	name:name,
		    	     });
		    	    $("#searchCondition").val("");
			}
			var flag;
			function addRoleDialog(){
			    $('#roleForm').form('clear');
				$('#roleDialog').dialog('open');
				flag = "add";
			}
		    function submitForm(){
		    	var url;
		    	if(flag==='add')
		    		url = "addRole";
		    	else if(flag==='update')
		    		url = "updateRole";
		/*     	if($("this").validate()){
 		    		alert("字段不能为空");
		    		return;
		    	} */ 
		    	$.ajax({
					url:'${ctx}/role/'+url,
					type:"POST",
					data:JSON.stringify({
							  'roleId':$('#roleId').val(),
							  'name':$('#name').val(),
							  'code':$('#code').val(),
							  'group':$('#group').val(),
							  'permission':$('#permission').val(),
							  'remark':$('#remark').val(),
					}),
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						$('#tt').datagrid('reload');
			    		$('#tt').datagrid('clearSelections');
			    		$('#roleDialog').dialog('close');
						hideLoading();
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				});
	        }
		    function updateRoleDialog(){
		    	flag = "update";
		    	var chks= $('#tt').datagrid('getChecked');
		    	if(null!=chks && chks.length==1){
				$('#roleform').form('clear');
					  $('#roleId').val(chks[0].roleId);
					  $('#name').val(chks[0].name);
					  $('#code').val(chks[0].code);
					  $('#group').val(chks[0].group);
					  $('#permission').val(chks[0].permission);
					  $('#remark').val(chks[0].remark);
    			$('#roleDialog').dialog('open');
				  $('#tt').datagrid('clearSelections');
		    	  hideLoading();	
		    	}else{
		    		$.messager.alert('提示',"请选择一项进行修改!",'info');
		    	}
		    }
		    function deleteRole(){
		    	var chks = null;
	        	chks = $('#tt').datagrid('getChecked');
	        	if(chks.length<1){
	        		$.messager.alert('提示','请至少选择一项!','warning');
	        		return ;
	        	}
	        	var arr = new Array();
	        	for(var c in chks){
	        		arr[c] = chks[c].roleId;
	        	}
	        	$.messager.confirm('提示', '确定要删除该项目吗?', function(yes){
	        		if(yes){
	        			showLoading();
	        			$.ajax({
	        				url:'${ctx}/role/deleteRole',
	        				type:"POST",
	        				data:{'param':arr.toString()},
	        				dataType:"json",
	        				async: false,
	        				success:function(data){
		        				$.messager.alert('提示',data.msg,'info');
		        				$('#tt').datagrid('reload');
		        				$('#tt').datagrid('clearSelections');
		        				hideLoading();
	        				},error:function(data){
	        					$.messager.alert('提示',data.msg,'error');
	        					$('#tt').datagrid('clearSelections');
	        					hideLoading();
	        				}
	        			});
	        		}
	        	});
		    }
		    //***********************************************************************************************//
		    //********************************************** 华丽分割线 ***************************************//
		    //***********************************************************************************************//		    
		   	var roleId=null;
	       	function assignPermDialog(){
	    	   var chks = $('#tt').datagrid('getChecked');
	    	   if(null!=chks && chks.length==1){
	    		   $('#rt').html(null);
	    		   showLoading();
	    	    	roleId  = chks[0].roleId;
	    	       	$('#rt').tree({
	    	       		lines:true,
	    	       		animate:true,
	    	       		checkbox:true,
	    	       	    url:'${ctx}/menu/getTreeMenu',
	    	       	    onLoadSuccess:function(){
	    	       	          $.ajax({
	    	           			url:'${ctx}/menu/getMenuListByRole',
	    	           			type:'POST',
	    	           			data:{'roleId':roleId},
	    	           			dataType:'json',
	    	           			async: false,
	    	           			success:function(data){
	    	           			   //先将回显数据全部清除 
	    	           			   var root=$("#rt").tree('getRoot');  
	    	           	           $("#rt").tree('uncheck',root.target); 
	    	           				hideLoading();
	    	           				for(d in data){
	    	           				     //这里遍历获取到了 tnode的值， 获取menuId  
	    	           	                // 根据menuId查找到这个节点,并将其设置为“已勾选状态”  
	    	           					var tnode = data[d];
	    	           					var node = $('#rt').tree('find',tnode.menuId);
	    	           					 if(node.level==3||node.children==""){//三级菜单或没有子类，设置选中
	    	           						$('#rt').tree('check',node.target);
	    	           					 }
	    	           				} 
	    	           				
	    	           			},error:function(data){
	    	           				$.messager.alert('提示','数据加载失败','error');
	    	           			}
	    	           		});
	    	       	    }
	    	       	});
	    	       	$('#assignPermDialog').dialog('open');
	    	   }else{
	    		   $.messager.alert('提示','请选择一项进行操作!','info');
	    	   }
	       	}
	    	function assignPerm(){
	       		showLoading();
	        	var nodes = $('#rt').tree('getChecked',['checked','indeterminate']);
		      	var ch = new Array();
		      	for(node in nodes){
		      		ch[node] = nodes[node].menuId;
		      	}
	        	$.ajax({
	       		url:'${ctx}/role/authorizationRolesMenus',
	      			type:'POST',
	      			data:{'menus':ch.toString(),'roleId':roleId},
	      			dataType:"json",
	      			async: false,
	      			success:function(data){
	      				hideLoading();
	      				$('#assignPermDialog').dialog('close');
	      				$.messager.alert('提示',data.msg+",新分配角色需要重新登录!",'info');
	      			},error:function(data){
	      				$.messager.alert('提示',data.msg,'error');
	      			}
	      		}); 
	       	}  
		    
		</script>
	</body>
</html>