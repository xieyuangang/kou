<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
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
	    <script type="text/javascript" src="${ctx}/js/ajaxfileupload.js" charset="utf-8"></script>
	     <style>
           .layui-inline{margin-bottom: 5px;}
         </style>
	</head>
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form action="" class="layui-form layui-form-pane">
           
        <div class="layui-inline click" id="addTask" onclick="javascript:addTaskDialog();" >
                             选择文件：<input type="file"  id="fileUd" name="fileUd">
        </div>
        <div class="layui-inline click" id="updateTask" onclick="javascript:updateTaskDialog();" >
                          选择文件类型：<input id="infoType" type="text" class="easyui-combobox" data-options="editable:false" style="width:120px" />
        </div>
        <div class="layui-inline click" id="toTaskPage" onclick="javascript:impInfo();" >
          <a href="#">
		    <span style="display: block;float: left;margin: 5px;">
		    	<img src="${ctx}/images/ico06.png" style="width: 24px;height:24px;"/>
		    	</span>
		    	上传
		 </a>
        </div>
        <div class="layui-inline click" id="deleteTask"  onclick="javascript:deleteTask();">
            <a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
        </div>
    </form>
</blockquote>	
	<div>
	     <table id="tt" style="height:452px;"></table>
	</div>		       
		<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
				 $('#tt').datagrid({
						url:'${ctx}/task/getTaskPage',
						idField : "id",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'id', field:'id',width:50,align:'center'},
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
				             {title:'处理结果', field:'resultDesc',width:100,align:'center'},
				             {title:'结果', field:'registerDesc',width:100,align:'center'},
				             {title:'出错列表', field:'errorList',width:100,align:'center'}
						]]
				 });
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
	        			showLoading();
	        			$.ajax({
	        				url:'${ctx}/task/deleteTask',
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
		    $('#infoType').combobox({
    	    	url:"${ctx}/task/getInfoTypeList",
    			valueField:'infoType',
    			textField:'msg'
    	    });
		    function impInfo(){
		    	var f = document.getElementById("fileUd").files;  			    	
	            var oldFileName = f[0].name; 
		    	var account = '${account}';
		    	try{
				var val = $("#fileUd").val();
				var infoType = $("#infoType").combobox('getValue');
				if (val != '' && infoType != '') {
					$.ajaxFileUpload( {
						data:{'infoType':infoType,"account":account,"oldFileName":oldFileName},
						url : '${ctx}/upload/uploadFile',
						secureuri : false,
						fileElementId : 'fileUd',
						dataType : 'text',
						contentType : 'application/x-www-form-urlencoded; charset=utf-8',
						success : function(data) {
							var reg = /<pre.+?>(.+)<\/pre>/g;  
							var result = data.match(reg);  
							data = RegExp.$1;							
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
		    	var account = '${account}';
				$.ajax({
						type : 'POST',
						url : '${ctx}/task/updateTask',
						data : {
							'id':taskId,'account':account
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
		    //***********************************************************************************************//
		    //********************************************** 华丽分割线 ***************************************//
		    //***********************************************************************************************//
		</script>
	</body>
</html>