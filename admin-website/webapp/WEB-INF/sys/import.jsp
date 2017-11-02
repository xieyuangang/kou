
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>导入</title>
    <link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
    <style>
        .layui-inline {
            margin-bottom: 5px;
        }
    </style>
</head>
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">

    <!-- dialog -->
    <form action="" class="layui-form layui-form-pane">


        <div class="layui-btn layui-btn-primary batchDel">选择文件：<input type="file" id="fileUd" name="fileUd" style="height: 24px;"
                                                                      ></div>
        <div class="layui-btn layui-btn-primary batchDel">选择文件类型：
            <input id="infoType" type="text" class="easyui-combobox" data-options="editable:false" class="layui-input"/>
        </div>


        <div class="layui-inline click" id="toTaskPage" onclick="impInfo();">
            <a class="layui-btn layui-btn batchDel"><i class="layui-icon">&#xe615;</i>上传</a>
        </div>

        <div class="layui-inline click" id="deleteTask" onclick="javascript:deleteTask();">
            <a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
        </div>

    </form>


</blockquote>
<div>
    <table id="tt" style="height:452px;"></table>
    <script type="text/javascript">
        $("#tt").css("width", $(window).width() - 20);
    </script>
</div>

<!-- dialog -->
<div id="roleDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:350px;height:380px;padding:10px;"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
        <form class="easyui-form" id="roleForm" method="post">
            <fieldset style="width:290px">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
                    <tr>
                        <td><input id="roleId" name="roleId" type="hidden"/></td>
                    </tr>
                    <tr class="layui-form-item">
                        <td class="layui-form-label">角色名称<b>*</b></td>
                        <td><input id="name" name="name" class="easyui-validatebox layui-input" type="text"
                                   data-options="required:true,missingMessage:'角色名称不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td class="layui-form-label">角色代码<b>*</b></td>
                        <td><input id="code" name="code" class="easyui-validatebox layui-input" type="text"
                                   data-options="required:true,missingMessage:'角色代码不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td class="layui-form-label">角色分组<b>*</b></td>
                        <td><input id="group" name="group" class="easyui-validatebox layui-input" type="text"
                                   data-options="required:true,missingMessage:'角色分组不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td class="layui-form-label">权限值<b>*</b></td>
                        <td><input id="permission" name="permission" class="easyui-validatebox layui-input" type="text"
                                   data-options="required:true,missingMessage:'权限值不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td class="layui-form-label">备注</td>
                        <td><input id="remark" name="remark" class="easyui-validatebox layui-input" type="text"></input>
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
       onclick="$('#roleDialog').dialog('close');">关闭</a>
</div>

<!-- 权限分配窗口 -->
<div id="assignPermDialog" title="权限菜单" class="easyui-dialog" closed="true"
     style="width:340px;height:500px;padding:10px" data-options="iconCls:'icon-save',modal:true"
     buttons="#assignPerm_buttons">
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
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#assignPermDialog').dialog('close');">关闭</a>
</div>
<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
    });
</script>
<script type="text/javascript">
			$(function(){
	        	initGrid();
	        	regCRUDEvent();
	        	$('#infoType').combobox({
	    	    	url:"${ctx}/task/getInfoTypeList",
	    			valueField:'infoType',
	    			textField:'msg'
	    	    });
			});
			function initGrid(){
				 $('#tt').datagrid({
						url:'${ctx}/task/getTaskPage',
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'id', field:'id',width:100,align:'center'},
				             {title:'上传文件', field:'srcName',width:130,align:'center'},
				             {title:'处理后文件下载', field:'downUrl',width:180,align:'center',
				            	 formatter:function(value,row,index){
					            		if(value){
					            			return '<a class="url" href="${ctx}/downfiles/'+row.downUrl+'" onclick="">'+value+'</a>';
					            		}
					            	}	
				             },
				             {title:'文件类型', field:'infoType',width:100,align:'center',
				            	 formatter:function(value){
					            		if(value == '0'){
					            			return '导入零售户';
					            		}
					            	}	 
				             },
				             {title:'上传人', field:'uploadUser',width:100,align:'center'},
				             {title:'上传时间', field:'uploadDate',width:200,align:'center',
				            	 formatter:function(value,row,index){	
				            		 if(value){
				            			 return $.formatDate(value);
				            		 }
				            	 }		 
				             },
				             {title:'处理人', field:'doUser',width:100,align:'center'},
				             {title:'处理时间', field:'doDate',width:200,align:'center',
				            	 formatter:function(value,row,index){	
				            		 if(value){
				            			 return $.formatDate(value);
				            		 }
				            	 }	  
				             },
				             {title:'完成时间', field:'finishDate',width:200,align:'center',
				            	 formatter:function(value,row,index){	
				            		 if(value){
				            			 return $.formatDate(value);
				            		 }
				            	 }		 
				             },
				             {title:'状态', field:'state',width:100,align:'center',
				            	 formatter:function(value,row,index){
					            		if(value == '0'){
					            			return '<a class="url" href="javascript:void(0)" onclick="dotransfile('+row.id+');">需要处理</a>';
					            		}else if(value == '1'){
					            			return '处理中';
					            		}else if(value == '2'){
					            			return '处理完成';
					            		}else if(value == '3'){
					            			return '作废';
					            		}else if(value == '4'){
					            			return '处理失败';
					            		}
					            	}			 
				             },
				             {title:'结果', field:'resultDesc',width:100,align:'center'}
						]]
				 });
			}
			
			 function search(){
			    	var srcName = $("#srcName").val();
					$("#tt").datagrid('load', {
						srcName : srcName
					});
				 }
			
			
			var url=null;
			// 注册crud事件
			function regCRUDEvent(){
				// 表单提交（添加、更新）
				$('#submitFormBtn').click(function(e) {
					options.url = '${ctx}/task/'+url;
					$('#taskForm').ajaxSubmit(options);
			        return false;
				});
				// 提交参数对象
			  	var options = {
		            beforeSubmit: before,
		            success: showResponse,
		            error:showError,
		            type:'post'
		        };
				// 表单检查
			  	function before(){
					if($('#taskForm').form('validate')){
						pro();
						$('#taskDialog').dialog('close');
						return true;
					}else
						return false;
			  	};
		        function showResponse(responseText, statusText, xhr, $form) {
		        	hide();
		        	$.messager.alert('提示',eval(responseText), 'info');
		        	$('#tt').datagrid('clearSelections');
		        	$('#tt').datagrid('reload');
		        };
		        function showError(p1, $form) {
		        	hide();
		        	$('#taskDialog').dialog('open');
		        	$.messager.alert('提示',eval(p1.responseText), 'info');
		        };
			}
		    function deleteTask(){
		    	var chks = null;
	        	chks = $('#tt').datagrid('getChecked');
	        	if(chks.length<1){
	        		$.messager.alert('提示','请至少选择一项!','warning');
	        		return ;
	        	}
	        	var arr = new Array();
	        	for(var c in chks){
	        		arr[c] = chks[c].id;
	        	}
	        	$.messager.confirm('提示', '确定要删除该项目吗?', function(yes){
	        		if(yes){
	        			//pro();
	        			$.ajax({type:'GET',url:'${ctx}/task/deleteTask',data:{'param':arr.toString()},
	    	        	    success:function(text,status,xhr){
	    	        	    	$.messager.alert('提示',eval(xhr.responseText),'info');
	    	        	    	$('#tt').datagrid('clearSelections');
	    	        	    	$('#tt').datagrid('reload');
	    	        	    	hide();
	    	        	    },error:function(res){
	    	        	    	hide();
	    	        	    	$.messager.alert('提示',eval(res.responseText),'warning');
	    	        	    },
	    	        	    dataType:'json'
	    	        	});
	        		}
	        	});
		    } 
		    
		    function impInfo() {
		    	try{
				var val = $("#fileUd").val();
				var infoType = $("#infoType").combobox('getValue');
				if (val != '' && infoType != '') {
					$.ajaxFileUpload( {
						data:{'infoType':infoType},
						url : '${ctx}/upload/uploadFile',
						secureuri : false,
						fileElementId : 'fileUd',
						dataType : 'text',
						contentType : 'application/x-www-form-urlencoded; charset=utf-8',
						success : function(data) {
							$.messager.alert('提示',data,'info');
							$('#tt').datagrid('reload');
						},
						error : function(data) {
							$("#upFaile").show();
						}
					});
				}
		    	}catch(e){
		    		alert(e.message);
		    	}
			}
		    function dotransfile(taskId){
				$.ajax({
						type : 'POST',
						url : '${ctx}/task/updateTask',
						data : {
							'id' : taskId,
						},
						success : function(text, status, xhr) {
							$.messager.alert('提示', eval(xhr.responseText), 'info');
							$('#tt').datagrid('clearSelections');
							$('#tt').datagrid('reload');
							hide();
						},
						error : function(res) {
							hide();
							$.messager.alert('提示', eval(res.responseText),
									'warning');
						},
						dataType : 'json'
					});
			}
			//********************************************** 华丽分割线 ***************************************//
		</script>
</body>
</html>