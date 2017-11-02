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
	     <script type="text/javascript" src="${ctx}/js/validate.js" charset="utf-8"></script>
	     <style>
           .layui-inline{margin-bottom: 5px;}
         </style>
	</head>
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form action="" class="layui-form layui-form-pane">
        <div class="layui-inline">
			<label class="layui-form-label">零售户姓名</label>
            <div class="layui-input-block">
                <input id="searchCondition" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        <div class="layui-inline click"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>搜索</a>
       </div>
        <div class="layui-inline click" id="addImg" onclick="javascript:addImgDialog();" >
            <a class="layui-btn layui-btn batchDel"><i class="layui-icon">&#xe61f;</i>上传</a>
        </div>
        <div class="layui-inline click" id="updateImg" onclick="javascript:updateImgDialog();" >
            <a class="layui-btn layui-btn-normal batchDel"><i class="layui-icon">&#xe642;</i>修改</a>
        </div>
        <div class="layui-inline click" id="deleteImg"  onclick="javascript:deleteImg();">
            <a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
        </div>
    </form>
</blockquote>	
<!-- dialog -->
<div id="imgDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:480px;height:400px;padding:10px"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
        <form class="easyui-form" id="imgForm" method="post">
            <fieldset style="width:420px;height:280px">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
				    <tr>
                        <td><input id="id" name="id" type="hidden"/></td>
                    </tr>
					<tr>
                        <td>零售户姓名<b>*</b></td>
                        <td><input id="merchantName" name="merchantName" class="easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'零售户姓名不能为空!'"></input></td>
                    </tr>
					 <tr>
                            <td>图片<b>*</b></td>  
                            <td>
                            <input type="file" id="file" name="file"  placeholder="上传图片">	                            
                            <button type="button" class="btn btn-primary" onclick="submitImg()" style="border: none;background: #009688;">上传</button>                                        
							<input type="hidden" class="form-control" id="imgUrl" name="imgUrl">
							<img src="" style="height:120px;display: none;" class="imgPre" id="image"/>
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
	       onclick="$('#imgDialog').dialog('close');">关闭</a>
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
						url:'${ctx}/img/getImgPage',
						idField : "id",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'主键', field:'id',width:20,align:'center'},
				             {title:'零售户姓名', field:'merchantName',width:30,align:'center'},
				             {title:'图片路径', field:'imgUrl',width:100,align:'center'},
				             {title:'上传时间', field:'createTime',width:30,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}}							
						]]
				 });
			}
			
			function search(){
					var merchantName = $("#searchCondition").val();
		    	    $("#tt").datagrid('load',{
		    	    	merchantName:merchantName,
		    	     });
			}
			var flag;
			function addImgDialog(){
			    $('#imgForm').form('clear');
				$('#imgDialog').dialog('open');
				flag = "add";
			}
		    function submitForm(){		    	
		    	var url;
		    	if(flag==='add')
		    		url = "addImg";
		    	else if(flag==='update')
		    		url = "updateImg";
		      if($('#merchantName').val()==""||
		    		  $('#imgUrl').val()==""){
		    	   $.messager.alert('提示',"必要不能为空！",'error');
		    	   return;
		         }			      		    
		    	$.ajax({
					url:'${ctx}/img/'+url,
					type:"POST",
					data:JSON.stringify({
							  'id':$('#id').val(),
							  'merchantName':$('#merchantName').val(),
							  'imgUrl':$('#imgUrl').val(),
					}),
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						$('#tt').datagrid('reload');
			    		$('#tt').datagrid('clearSelections');
			    		$('#imgDialog').dialog('close');
						hideLoading();
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				});
	        }
		    function updateImgDialog(){
		    	flag = "update";
		    	var chks= $('#tt').datagrid('getChecked');
		    	if(null!=chks && chks.length==1){
		    	    showLoading();
		    		$.ajax({
		    			url:'${ctx}/img/getImgById',
		    			type:"POST",
		    			data:{'id':chks[0].id},
		    			dataType:"json",
		    			async: false,
		    			success:function(data){
		    				data = data.data;
			    			if(null!=data){
			    				$('#imgForm').form('clear');
		    				  		$('#id').val(data.id);
		    				  		$('#merchantName').val(data.merchantName);
		    				  		$('#imgUrl').val(data.imgUrl);
				    			$('#imgDialog').dialog('open');
			    			}
				    		hideLoading();
		    			},error:function(data){
		    				$.messager.alert('提示',data,'error');
		    				hideLoading();
		    			}
		    		});
		    	}else{
		    		$.messager.alert('提示',"请选择一项进行修改!",'info');return;
		    	}
		    }
		    function deleteImg(){
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
	        				url:'${ctx}/img/deleteImg',
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
		    
	function submitImg(){
    	var source = "web";    	
    	var num = "";
    	for(var i=0;i<8;i++){
    		num+=Math.floor(Math.random()*10);
    	}
    	var alias =num+"img";
		$.ajaxFileUpload({
			url :'<%=externalGlobalBaseUrl%>/file-manage/file/single',		
			secureuri : false,
			fileElementId : 'file',
			data:{'source':source,'mid':num,'alias':alias},
			dataType : 'json',
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			success : function(data) {	
				if(data.code == '0000'){
					data = data.data;
					$("#imgUrl").val(data.imageUrl);
					$("#image").attr("src",data.imageUrl);
		        	$("#image").css("display","block");
				}else{
					$("#loading").hide();
					$.messager.alert('提示', data.msg,'warning');
					return;
				}					
			},
			error : function(data,status,e) {
				$("#loading").hide();
				$.messager.alert('提示', data.msg,'warning');
			}
		});
	}		
		</script>
	</body>
</html>