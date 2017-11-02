<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>商品管理</title>
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
           .layui-inline{margin-bottom: 5px;}
         </style>
	</head>

<body class="childrenBody" style="width: 99%;box-sizing: border-box">
	<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
		<form action="" class="layui-form layui-form-pane">
			<div class="layui-inline">
				<label class="layui-form-label">商品名称</label>
				<div class="layui-input-block">
					<input id="nameSearch" type="text" maxlength="30"
						class="layui-input easyui-textbox" style="width: 240px;" value="" />
				</div>
			</div>
			<div class="layui-inline click" id="toActGoodsPage" onclick="javascript:search();">
				<a class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe615;</i>查询</a>
			</div>
			<shiro:hasPermission name="goods:add">
				<div class="layui-inline click" id="addActGoods" onclick="javascript:addActGoodsDialog();">
					<a class="layui-btn layui-btn"><i class="layui-icon">&#xe61f;</i>添加</a>
				</div>
			</shiro:hasPermission>
			<shiro:hasPermission name="goods:update">
				<div class="layui-inline click" id="updateActGoods" onclick="javascript:updateActGoodsDialog();">
					<a class="layui-btn layui-btn-normal"><i class="layui-icon">&#xe642;</i>修改</a>
				</div>
			</shiro:hasPermission>
			<shiro:hasPermission name="goods:delete">
				<div class="layui-inline click" id="deleteActGoods" onclick="javascript:deleteActGoods();">
					<a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
				</div>
			</shiro:hasPermission>
		</form>
	</blockquote>

	<!-- dialog -->
	<div id="actGoodsDialog" title="商品信息编辑" class="easyui-dialog" closed="true" style="width:420px;height:370px;padding:10px;"
	     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
	    <div class="tab">
	         <form class="easyui-form" id="actGoodsForm" method="post">
	            <fieldset style="width:360px">
	                <legend>带<b>*</b>为必填项</legend>
	                <table border="0">
					    <tr>
	                        <td><input id="cagId" name="cagId" type="hidden"/></td>
	                    </tr>
	                    <tr>
	                        <td>商品名称<b>*</b></td>
	                        <td><input id="cagName" name="cagName" class="layui-input easyui-validatebox" type="text"
	                                   data-options="required:true,missingMessage:'商品名称不能为空!'"></input></td>
	                    </tr>
	                    
	                     <tr>
	                        <td>价格<b>*</b></td>
	                        <td><input id="cagPrice" name="cagPrice" class="layui-input easyui-validatebox" type="text"
	                                   data-options="required:true,missingMessage:'商品价格不能为空!'"></input></td>
	                    </tr>
	                    
	                     <tr>
	                        <td>商品编码<b>*</b></td>
	                        <td><input id="cagCode" name="cagCode" class="layui-input easyui-validatebox" type="text"
	                                   data-options="required:true,missingMessage:'商品价格不能为空!'"></input></td>
	                    </tr>

						<tr>
							<td>图片</td>
							<td><div class="layui-inline">
									<input type="file" id="file" name="file" placeholder="上传图片" onchange="javascript:imageChange();">
									<div class="layui-inline click" onclick="javascript:submitImg();">
										<a class="layui-btn layui-btn-primary layui-btn-small"><i class="layui-icon">&#xe62f;</i>上传</a>
									</div>
									<input type="hidden" class="form-control" id="cagImgurl" name="cagImgurl"> </div> 
									<img src="" style="height: 40px; display: none;" class="imgPre" id="actGoodsImage" /></td>
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
	       onclick="$('#actGoodsDialog').dialog('close');">关闭</a>
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
				url:'${ctx}/actGoods/findAllActGoods',
				idField : "cagId",
				pagination:true,
				rownumbers : true,
				fitColumns : true,
				collapsible : false,
				fitColumns : true,
				autoRowHeight : true,
				loadMsg : "数据加载中,请稍等...",
				frozenColumns : [[{field : 'ck',checkbox : true}]],
				columns:[[
					{title:'商品表id', field:'cagId',width:50,align:'center'},
					{title:'商品名称', field:'cagName',width:50,align:'center'},
					{title:'价格', field:'cagPrice',width:50,align:'center'},
					{title:'图片', field:'cagImgurl',width:50,align:'center'
						,formatter:function(value){
							return  '<img style="height:28px" src="'+value+'"/>';
		             }}, 
					{title:'商品编码', field:'cagCode',width:50,align:'center'}
				]]
		 });
		}
		
		function search(){
			var cagName = $("#nameSearch").val();
			$("#tt").datagrid('load',{
				cagName:cagName,
			});
		}
		
		var flag;
		function addActGoodsDialog(){
			$("#actGoodsImage").attr("src","");
			$("#actGoodsImage").css("display","none");
		    $('#actGoodsForm').form('clear');
			$('#actGoodsDialog').dialog('open');
			flag = "add";
		}
		
		var isUpload = true;
		function imageChange(){
			$("#actGoodsImage").attr("src","");
			$("#actGoodsImage").css("display","none");
			isUpload = false;
		}
		
	    function submitForm(){
	    	var cagName = $('#cagName').val();
	    	var cagPrice = $('#cagPrice').val();
	    	var cagCode = $('#cagCode').val();
	    	if ($.trim(cagName) === '' ){
	    		$.messager.alert('提示', '商品名称不能为空!', 'warning');
	    		return; 
	    	}
	    	if ($.trim(cagPrice) === '' ){
	    		$.messager.alert('提示', '价格不能为空!', 'warning');
	    		return; 
	    	}
	    	
	    	var patrn = /^[0-9]*$/;  
	        if (!patrn.test(cagPrice)) {  
	        	$.messager.alert('提示', '价格只能是数字!', 'warning');
	            return; 
	        }
	        
	        if ($.trim(cagCode) === '' ) {  
	        	$.messager.alert('提示', '商品编码不能为空!', 'warning');
	            return; 
	        }
	        
	        var imageUrl = $("#cagImgurl").val();
	    	var file = $("#file").val();
	        if(file!=""){
	    		if(imageUrl==""){
	    			$.messager.alert('提示',"请先上传商品图片！",'warning');
					 return false;
	    		}
	    	}
	        
		if (isUpload == false) {
				$.messager.confirm("提示", "变更的图片未上传，是否继续提交！", function(data) {
					if (data) {
						submitData();
						isUpload = true;
					} else {
						return;
					}
				});
			} else {
				submitData();
			}
		}
 
	    
		function submitData() {
			checkCagCode();
			if (!isCheckCagCode){
				return;
			}
			var url;
			if (flag === 'add')
				url = "addActGoods";
			else if (flag === 'update')
				url = "updateActGoods";

			$.ajax({
				url : '${ctx}/actGoods/' + url,
				type : "POST",
				data : JSON.stringify({
					'cagId' : $('#cagId').val(),
					'cagName' : $('#cagName').val(),
					'cagPrice' : $('#cagPrice').val(),
					'cagCode' : $('#cagCode').val(),
					'cagImgurl' : $('#cagImgurl').val(),
				}),
				dataType : "json",
				headers : {
					'Content-Type' : 'application/json;charset=UTF-8'
				},
				async : false,
				success : function(data) {

					$.messager.alert('提示', data.msg, 'info');
					$('#tt').datagrid('reload');
					$('#tt').datagrid('clearSelections');
					$('#actGoodsDialog').dialog('close');
					hideLoading();
				},
				error : function(data) {
					$.messager.alert('提示', data.msg, 'error');
					hideLoading();
				}
			});
		}

		var isCheckCagCode;
		function checkCagCode() {
	    	$.ajax({
				url : '${ctx}/actGoods/findGoodsByCagCode',
				type : "POST",
				data : JSON.stringify({
					'cagId' : $('#cagId').val(),
					'cagCode' : $('#cagCode').val(),
				}),
				dataType : "json",
				headers : {
					'Content-Type' : 'application/json;charset=UTF-8'
				},
				async : false,
				success : function(data) {
					// status 返回 0 表示商品编码重复
					if (data.status == 0){
						$.messager.alert('提示', data.msg, 'waring');
						isCheckCagCode = false;
					}else if(data.status == 1){
						isCheckCagCode = true;
					}
				},
				error : function(data) {
					$.messager.alert('提示', data.msg, 'error');
					isCheckCagCode = false;
				}
			});
	    }
		
		function submitImg() {
			var file = $("#file").val();
			var source = "web";
			var account = $("#cagCode").val();
			var alias = account;

			if (file == "") {
				$.messager.alert('提示', '未添加图片!', 'warning');
				return;
			}

			if (account == "") {
				$.messager.alert('提示', '商品编码不能为空!', 'warning');
				return;
			}
			
			checkCagCode();
			if (!isCheckCagCode){
				return;
			}

			$.ajaxFileUpload({
				url : '<%=externalGlobalBaseUrl%>/file-manage/file/single',		
				secureuri : false,
				fileElementId : 'file',
				data:{'source':source,'mid':account,'alias':alias},
				dataType : 'json',
				contentType : 'application/x-www-form-urlencoded; charset=utf-8',
				success : function(data) {
					if(data.code == '0000'){
						isUpload = true;
						$("#cagImgurl").val(data.data);
						$("#actGoodsImage").attr("src",data.data);
			        	$("#actGoodsImage").css("display","block");
					}else{
						$("#loading").hide();
						$.messager.alert('提示', data.msg,'warning');
						return;
					}					
				},
				error : function(data,status,e) {
					alert(status);
					$("#loading").hide();
					//$.messager.alert('提示', data.msg,'warning');
				}
			});
		}

	    function updateActGoodsDialog(){
	    	flag = "update";
	    	$("#file").val('');
	    	$("#actGoodsImage").attr("src","");
	    	$("#actGoodsImage").css("display","none");
	    	var chks= $('#tt').datagrid('getChecked');
	    	
	    	if(null!=chks && chks.length==1){
	    	    showLoading();
	    		$.ajax({
	    			url:'${ctx}/actGoods/getActGoodsByCagId',
	    			type:"POST",
	    			data:{'cagId':chks[0].cagId},
	    			dataType:"json",
	    			async: false,
	    			success:function(data){
	    				if (data.status == 1){
	    					data = data.data;
			    			if(null!=data){
								  $('#cagId').val(data.cagId);
								  $('#cagName').val(data.cagName);
								  $('#cagPrice').val(data.cagPrice);
								  $('#cagCode').val(data.cagCode);
								  $("#cagImgurl").val(data.cagImgurl);
						          $("#actGoodsImage").attr("src",data.cagImgurl);
						          $("#actGoodsImage").css("display","block");
				    			$('#actGoodsDialog').dialog('open');
			    			}
				    		hideLoading();
	    				}	    				
	    			},error:function(data){
	    				$.messager.alert('提示',data,'error');
	    				hideLoading();
	    			}
	    		});
	    	}else{
	    		$.messager.alert('提示',"请选择一项商品进行修改!",'info');return;
	    	}
	    }

		function deleteActGoods() {
			var chks = $('#tt').datagrid('getChecked');
			if (chks.length < 1) {
				$.messager.alert('提示', '请至少选择一项!', '');
				return;
			}
			var arr = new Array();
			for ( var c in chks) {
				arr[c] = chks[c].cagId;
			}
			$.messager.confirm('提示', '确定要删除选择的商品吗?', function(yes) {
				if (yes) {
					showLoading();
					$.ajax({
						url : '${ctx}/actGoods/deleteActgoods',
						type : "POST",
						data : {'param' : arr.toString()},
						dataType : "json",
						async : false,
						success : function(data) {
							$.messager.alert('提示',data.msg, '');
							$('#tt').datagrid('reload');
							$('#tt').datagrid('clearSelections');
							hideLoading();
						},
						error : function(data) {
							$.messager.alert('提示', JSON.stringify(data),'');
							$('#tt').datagrid('clearSelections');
							hideLoading();
						}
					});
				}
			});
		}
		
	</script>
</body>
</html>