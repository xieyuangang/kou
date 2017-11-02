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
            <label class="layui-form-label">新商盟账号</label>
            <div class="layui-input-block">
                <input id="searchCsdCustid" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:240px;" value=""/>
            </div></div>
            <div class="layui-inline">
            <label class="layui-form-label">店铺名称</label>
            <div class="layui-input-block">
                <input id="searchBsName" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:240px;" value=""/>
            </div>
        </div>

		<div class="layui-inline click" id="toShopRefGoodsPage" onclick="javascript:search();">
			<a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>查詢</a>
		</div>
		<shiro:hasPermission name="goods:conf:delete">
			<div class="layui-inline click" id="deleteGoodsDist" onclick="javascript:deleteConfGoods();">
				<a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
			</div>
		</shiro:hasPermission>
		<shiro:hasPermission name="goods:conf:choosedist">
			<div class="layui-inline click" id="chooseGoodsDist" onclick="javascript:chooseGoodsDistDialog();">
				<a class="layui-btn layui-btn-warm batchDel"><i class="layui-icon">&#xe614;</i>选择分配商品</a>
			</div>
		</shiro:hasPermission>
		<shiro:hasPermission name="goods:conf:areadist">
			<div class="layui-inline click" id="chooseAreaDist" onclick="javascript:chooseAreaDistDialog();">
	           	<a class="layui-btn layui-btn-warm batchDel"><i class="layui-icon">&#xe614;</i>选择区域分配商品</a>
	        </div>
        </shiro:hasPermission>
		<shiro:hasPermission name="goods:conf:shopdist">
	        <div class="layui-inline click" id="chooseShopDist" onclick="javascript:chooseShopDistDialog();">
	           <a class="layui-btn layui-btn-warm batchDel"><i class="layui-icon">&#xe614;</i>所有店铺分配商品</a>
	        </div>
        </shiro:hasPermission>
    </form>
</blockquote>

 <!-- dialog -->
	<div id="confGoodsDialog" title="商户商品管理菜单" class="easyui-dialog" closed="true" style="width: 880px;/*  height: 620px; */ padding: 10px;"
		data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
		<div id="areaTable" style="padding-bottom: 10px;">
		<table  border="0">
			<tr>
				<td><input id="userId" name="userId" type="hidden" /></td>
			</tr>
			<tr style="padding: 10px;">
				<td> &nbsp;&nbsp;选择需要分配的区县：</td>
				<td><input id="area" name="area" type="hidden" /></td>
				<table border="0">
					<tr></tr>
					<tr>
						<td> 省：</td>
						<td><select id="provinceId" name="provinceId" style="width: 120px;" class="easyui-combobox" 
							data-options="editable:false"></select></td>
						<td> &nbsp;&nbsp;市：</td>
						<td><select id="cityId" name="cityId" style="width: 120px;" class="easyui-combobox" 
							data-options="editable:false"></select></td>
						<td> &nbsp;&nbsp;县：</td>
						<td><select id="countyId" name="countyId" style="width: 120px;" class="easyui-combobox"
							data-options="editable:false"></select></td>
					</tr>
				</table>
			</tr>
		</table>
		</div>
		<div style="padding-left: 10px;"><span>选择需要分配的商品：</span></div>
		<table id="gt"></table>
	</div>
	<!-- dialog buttons -->
<div id="dialog_buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitForm();">提交</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#confGoodsDialog').dialog('close');">关闭</a>
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
			url:'${ctx}/shopRefGoods/findAllShopRefGoods',
			//idField : "bsId",
			pagination:true,
			rownumbers : true,
			fitColumns : true,
			collapsible : false,
			fitColumns : true,
			autoRowHeight : true,
			loadMsg : "数据加载中,请稍等...",
			frozenColumns : [[{field : 'ck',checkbox : true}]],
			columns:[[
				{title:'店铺Id', field:'bsId',width:50,align:'center'},
				{title:'新商盟账号', field:'csdCustid',width:50,align:'center'},
				{title:'店铺名称', field:'bsName',width:50,align:'center'},
				{title:'商户商品关联ID', field:'crsaId',hidden:'true'},
				{title:'商品名称', field:'crsaName',width:50,align:'center'},
				{title:'商品图片', field:'crsaImgUrl',width:50,align:'center',formatter:function(value){
					return  '<img style="height:28px" src="'+value+'"/>';
	             }},
				{title:'是否自定义', field:'crsaIsCustomized',width:50,align:'center',formatter:function(value){
					if ('0' == value){
						return "否";
					}else if ('1' == value){
						return "是";
					}
	             }},
			]]
	 });
	}
	
	function search(){
		var csdCustid = $("#searchCsdCustid").val();
		var bsName = $("#searchBsName").val();
		$("#tt").datagrid('load',{
			csdCustid:csdCustid,
			bsName:bsName,
		});
	}
	
	
	function chooseGoodsDistDialog(){
		var chks = $('#tt').datagrid('getChecked');
		if (chks.length < 1) {
			$.messager.alert('提示', '请至少选择一家商户!', '');
			return;
		}

		$('#areaTable').hide();
		$('#provinceId').form('clear');
		$('#confGoodsDialog').dialog('open');
		initGridGt();
		$('#gt').datagrid('clearSelections');
		type = "chooseDist";
	}
	
	function chooseAreaDistDialog(){
		$('#countyId').combobox('clear');
		$('#cityId').combobox('clear');
		$('#provinceId').combobox('clear');
		$('#areaTable').show();
		$('#confGoodsDialog').dialog('open');
		initGridGt();
		$('#gt').datagrid('clearSelections');
		type = "areaDist";
	}
	
	function chooseShopDistDialog(){
		$('#areaTable').hide();
		$('#confGoodsDialog').dialog('open');
		initGridGt();
		$('#gt').datagrid('clearSelections');
		type = "allDist";
	}

	var type;
	// 提交商品配置
	function submitForm(){
		var gts = $('#gt').datagrid('getChecked');
		if (gts.length < 1) {
			$.messager.alert('提示', '请至少选择一件商品!', 'waring');
			return;
		}
		var goods = new Array();
		for ( var c in gts) {
			goods[c] = gts[c].cagId;
		}
		
		var provinceId = $('#provinceId').combobox('getValue');
		var cityId = $('#cityId').combobox('getValue');
		var countyId = $('#countyId').combobox('getValue');
		
		var shopIds = new Array();
		var new_shopIds= new Array();
		if(type==='chooseDist'){
			var shops = $('#tt').datagrid('getChecked');
			if (shops == null || shops.length < 1) {
				$.messager.alert('提示', '请至少选择一家商户!', 'warning');
				return;
			}
			
			for ( var c in shops) {
				shopIds[c] = shops[c].bsId;
			}
			
			// 去除重复的店铺id
			for(var i=0;i<shopIds.length;i++) {
				var items=shopIds[i];
				if($.inArray(items,new_shopIds)==-1) {
					new_shopIds.push(items);
				}
			}			
		}
		
		if (type==='areaDist'){
			if (provinceId == null || provinceId == ""){
				$.messager.alert('提示', '请至少选择需要分配的省级地区!', 'warning');
				return;
			}
		}

		$.ajax({
			url : '${ctx}/shopRefGoods/confActGoods',
			type : "POST",
			data : {
				'shops' : new_shopIds.toString(),
				'goods' : goods.toString(),
				'type' : type,
				'provinceId' : provinceId,
				'cityId' : cityId,
				'countyId' : countyId
			},
			dataType:"json",
			async : false,
			/* headers:{
				   "Content-Type": "application/json;charset=utf-8"
				 }, */
			success : function(data) {
				$.messager.alert('提示', data.msg, 'info');
				$('#tt').datagrid('reload');
				$('#tt').datagrid('clearSelections');
				$('#gt').datagrid('clearSelections');
				$('#confGoodsDialog').dialog('close');
			},
			error : function(data) {
				$.messager.alert('提示', data.statusText, 'error');
			}
		});
		
	}
	
	// 获取商品信息
	function initGridGt(){
		$('#gt').datagrid({ 
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
	
	
	// 删除商品配置信息
	function deleteConfGoods() {
		var chks = $('#tt').datagrid('getSelections');
		if (chks.length < 1) {
			$.messager.alert('提示', '请至少选择一项!', 'waring');
			return;
		}
		var arr = new Array();
		for ( var c in chks) {
			// 部分商户还没有配置过商品，添加判断
			if (chks[c].crsaId != null && chks[c].crsaId != ""){
				arr[c] = chks[c].crsaId;
			}
		}
		
		// 去除数组中的空元素
		$.each(arr,function(index,item){
			for (var i = 0; i < arr.length; i++){
				if (item == "" || item == null) {
					arr.splice(index,1);
				}
			}
     	});
		
		if (arr.length <= 0){
			$.messager.alert('提示', '没有需要删除的商户商品配置!', 'waring');
			return;
		}
		
		$.messager.confirm('提示', '确定要删除选择的商品吗?', function(yes) {
			if (yes) {
				showLoading();
				$.ajax({
					url : '${ctx}/shopRefGoods/deleteConfGoods',
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
	
	// 获取行政区划信息
	$('#provinceId').combobox({
		url:'${ctx}/user/getCommonnArea?areaId='+0,
		valueField:'areaId',
		textField:'name',
		onChange:function(newValue) {
			$('#cityId').combobox({
						url:'${ctx}/user/getCommonnArea?areaId='+newValue,
						valueField:'areaId',
						textField:'name',
						onChange:function(newValue) {
							$('#countyId').combobox({
										url:'${ctx}/user/getCommonnArea?areaId='+newValue,
										valueField:'areaId',
										textField:'name'
									}
							);
						}
					}
			);
		}
	});
			
	</script>
	</body>
</html>