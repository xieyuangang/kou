<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>管理</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
	     <style>
           .layui-inline{margin-bottom: 5px;}
         </style>
	</head>
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form action="" class="layui-form layui-form-pane">
        <div class="layui-inline">
			<label class="layui-form-label">名称</label>
            <div class="layui-input-block">
                <input id="searchCondition" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        <div class="layui-inline click"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>搜索</a>
       </div>
        <shiro:hasPermission name="sys:menu:add">
        <div class="layui-inline click" id="addUser" onclick="javascript:addMenuDialog();" >
            <a class="layui-btn layui-btn batchDel"><i class="layui-icon">&#xe61f;</i>添加</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:menu:update">  
        <div class="layui-inline click" id="updateUser" onclick="javascript:updateMenuDialog();" >
            <a class="layui-btn layui-btn-normal batchDel"><i class="layui-icon">&#xe642;</i>修改</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:menu:delete">
        <div class="layui-inline click" id="deleteUser"  onclick="javascript:deleteMenu();">
            <a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
        </div>
        </shiro:hasPermission>
    </form>
</blockquote>	
<!-- dialog -->
<div id="menuDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:360px;height:380px;padding:10px"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
        <form class="easyui-form" id="menuForm" method="post">
            <fieldset style="width:300px">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
				    <tr>
                        <td><input id="menuId" name="menuId" type="hidden"/></td>
                    </tr>
					 <tr id="trParentId" style="">
                        <td>上级菜单Id<b>*</b></td>
                        <td>
                         <input id="parentId" name="dept" class="easyui-validatebox" type="text"></input>
                         <!-- <select id="parentId" name="parentId"  style="width:170px;height: 30px;" class="easyui-combobox" data-options="editable:false"></select> -->
                        </td>
                    </tr>
					 <tr>
                        <td>名称<b>*</b></td>
                        <td><input id="name" name="name" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'名称不能为空!'"></input></td>
                    </tr>
					 <tr>
                        <td>代码<b>*</b></td>
                        <td><input id="code" name="code" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'代码不能为空!'"></input></td>
                    </tr>
					 <tr>
                        <td>等级<b>*</b></td>
                        <td>
                        <select id="level" class="easyui-combobox"
								name="level" panelHeight="70" style="width: 175px;"
								data-options="editable:false">
									<option value="1">一级菜单</option>
									<option value="2">二级菜单</option>
									<option value="3">三级菜单</option>
						</select>
                        </td>
                    </tr>
					 <tr>
                        <td>权限<b>*</b></td>
                        <td><input id="permission" name="permission" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'权限不能为空!'"></input></td>
                    </tr>
					 <tr>
                        <td>默认 0 否 1是<b>*</b></td>
                        <td>
                        <select id="available" class="easyui-combobox"
								name="available" panelHeight="70" style="width: 175px;"
								data-options="editable:false">
								    <option selected="selected" value="1">是</option>
									<option value="0">否</option>
									
						</select>
                       </td>
                    </tr>
					 <tr>
                        <td>所属类型<b>*</b></td>
                        <td>
                        <select id="range" class="easyui-combobox"
								name="range" panelHeight="70" style="width: 175px;"
								data-options="editable:false">
									<option selected="selected" value="WEB">WEB</option>
									<option  value="APP">APP</option>
									<option  value="THIRD">THIRD</option>
						</select>
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
	       onclick="$('#menuDialog').dialog('close');">关闭</a>
	</div>
	<div>
	     <table id="tt" style="height:452px;"></table>
	</div>		       
		<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
				 $('#tt').datagrid({
						url:'${ctx}/menu/getMenuPage',
						idField : "menuId",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'菜单标识', field:'menuId',width:50,align:'center'},
				             {title:'上级菜单Id', field:'parentId',width:50,align:'center'},
				             {title:'名称', field:'name',width:50,align:'center'},
				             {title:'代码', field:'code',width:50,align:'center'},
				             {title:'等级', field:'level',width:50,align:'center',
							  formatter:function(value){
								return value==1?"一级菜单":value==2?"二级菜单":"三级菜单";
							  }},							
				             {title:'权限', field:'permission',width:50,align:'center'},
				             {title:'默认 0 否 1是', field:'available',width:50,align:'center',
								  formatter:function(value){
										return value==1?"是":"否";
									  }},							
				             {title:'WEB/APP/THIRD', field:'range',width:50,align:'center'}
						]]
				 });
			}
			
			function search(){
					var name = $("#searchCondition").val();
					/* var status = $("#status").combobox('getValue'); */
		    	    $("#tt").datagrid('load',{
		    	    	name:name,
		    	     });
		    	    $("#searchCondition").val("");
			}
			var flag;
			function addMenuDialog(){
				$("#trParentId").attr("style",'');
				var chks= $('#tt').datagrid('getChecked');
				if(null!=chks && chks.length==1){
					var menuId = chks[0].menuId
					$('#parentId').combobox({    
						url:"${ctx}/menu/getMenuById?id="+menuId,  
						    valueField:'menuId',    
						    textField:'name',
						    editable: false,
						            onLoadSuccess: function () {       
						                 var data = $('#parentId').combobox('getData');  
						                 if (data.length > 0) {
						                     $("#parentId").combobox('select', data[0].menuId);
						                 }
						             }
						}); 
				  $('#tt').datagrid('clearSelections');
				}else if(null==chks||chks.length<1){
					$('#parentId').combobox({    
						url:"${ctx}/menu/getMenuById?id="+0,  
						    valueField:'parentId',    
						    textField:'name',
						    editable: false,
						            onLoadSuccess: function () {       
						                 var data = $('#parentId').combobox('getData');  
						                 if (data.length > 0) {
						                     $("#parentId").combobox('select', data[0].parentId);
						                 }
						             }
						});
				}else{
					$.messager.alert('提示',"不能选择多行!",'info');
					return;
				}
				 $('#menuForm').form('clear');
				 $('#menuDialog').dialog('open');
				 flag = "add";
			}
		    function submitForm(){
		    	var url;
		    	if(flag==='add')
		    		url = "addMenu";
		    	else if(flag==='update')
		    		url = "updateMenu";
		    	/* if($("#menuform").validate()){
		    		return;
		    	}	 */
		    	$.ajax({
					url:'${ctx}/menu/'+url,
					type:"POST",
					data:JSON.stringify({
							  'menuId':$('#menuId').val(),
							  'parentId':$("#parentId").combobox('getValue'),
							  'name':$('#name').val(),
							  'code':$('#code').val(),
							  'level':$("#level").combobox('getValue'),
							  'permission':$('#permission').val(),
							  'available':$("#available").combobox('getValue'),
							  'range':$("#range").combobox('getValue'),
					}),
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						$('#tt').datagrid('reload');
			    		$('#tt').datagrid('clearSelections');
			    		$('#menuDialog').dialog('close');
						hideLoading();
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				});
	        }
		    function updateMenuDialog(){		    	
		    	flag = "update";
		    	var chks= $('#tt').datagrid('getChecked');
		    	if(null!=chks && chks.length==1){
		    	$("#trParentId").attr("style",'display:none');
				$('#menuform').form('clear');
					  $('#menuId').val(chks[0].menuId);
					  $("#parentId").combobox('setValue',chks[0].parentId);
					  $('#name').val(chks[0].name);
					  $('#code').val(chks[0].code);
					  $("#level").combobox('setValue',chks[0].level);
					  $('#permission').val(chks[0].permission);
					  $("#available").combobox('setValue',chks[0].available);
					  $("#range").combobox('setValue',chks[0].range)
    			  $('#menuDialog').dialog('open');
				  $('#tt').datagrid('clearSelections');
		    	  hideLoading();	
		    	}else{
		    		$.messager.alert('提示',"请选择一项进行修改!",'info');
		    	}
		    }
		    function deleteMenu(){
		    	var chks = null;
	        	chks = $('#tt').datagrid('getChecked');
	        	if(chks.length<1){
	        		$.messager.alert('提示','请至少选择一项!','warning');
	        		return ;
	        	}
	        	var arr = new Array();
	        	for(var c in chks){
	        		arr[c] = chks[c].menuId;
	        	}
	        	$.messager.confirm('提示', '确定要删除该项目吗?', function(yes){
	        		if(yes){
	        			showLoading();
	        			$.ajax({
	        				url:'${ctx}/menu/deleteMenu',
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
		</script>
	</body>
</html>