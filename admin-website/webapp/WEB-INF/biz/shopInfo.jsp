<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>店铺信息管理</title>
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
    <form action="" class="layui-form layui-form-pane">
       
        <div class="layui-inline">
            <label class="layui-form-label">行业</label>
            <div class="layui-input-inline">
                <select id="s_identity" name="identity" lay-verify="required">
                    <option value="">烟草</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">新商盟账号</label>
            <div class="layui-input-block">
                <input name="xsmAccount" type="text" maxlength="30" id="s_xsmAccount" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">店铺名称</label>
            <div class="layui-input-block">
                <input name="shopName" type="text" maxlength="30" id="s_shopName" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">烟草专卖证</label>
            <div class="layui-input-block">
                <input name="ycCardNo" type="text" maxlength="30" id="s_ycCardNo" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">注册时间</label>
            <div class="layui-input-block">
				<input type="text" name="createTime" id="s_createTime" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off"
                       class="layui-input" onclick="layui.laydate({elem: this})">            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">注册状态</label>
            <div class="layui-input-inline">
                <select id="s_verifyStatus" lay-verify="required">
                    <option value="">请选择</option>
                    <option value="0">注册</option>
                    <option value="1">未实名</option>
                    <option value="2">实名未绑卡</option>
                    <option value="3">绑卡完成</option>
                </select>
            </div>
        </div>
      	<shiro:hasPermission name="shop:view">
        <div class="layui-inline"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>查询</a>
       </div>
       </shiro:hasPermission>
        <shiro:hasPermission name="shop:update">
	        <div class="layui-inline" id="updateRole" onclick="javascript:updateShopDialog();" >
	            <a class="layui-btn layui-btn-normal batchDel"><i class="layui-icon">&#xe642;</i>修改</a>
	        </div>
      	</shiro:hasPermission>

    </form>
</blockquote>
<div id="shopDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:320px;height:300px;padding:10px;"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
         <form class="easyui-form" id="shopFrom" method="post">
            <fieldset style="width:280px">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
				    <tr>
                        <td><input id="shopId" name="userId" type="hidden"/></td>
                    </tr>
                    <tr>
                        <td>店铺名<b>*</b></td>
                        <td><input id="shopName" name="shopName" class="layui-input easyui-validatebox" type="text"></input></td>
                    </tr>
                     <tr>
                        <td>地址</td>
                        <td><input id="shopAddress" name="shopAddress" class="layui-input easyui-validatebox" type="text"></input></td>
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
       onclick="$('#shopDialog').dialog('close');">关闭</a>
</div>

 <div>
     <table id="tt"  style="height:452px;"></table>
     <script type="text/javascript">
				$("#tt").css("width",$(window).width()-20);
	</script>
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
			 $('#tt').datagrid({
					url:'${ctx}/store/getShopInfoList',
					pagination:true,
					rownumbers : true,
					fitColumns : true,
					collapsible : true,
					autoRowHeight : true,
					singleSelect:true,
					loadMsg : "数据加载中,请稍等...",
					//frozenColumns : [[{field : 'ck',checkbox : true}]],
					columns:[[
			             {title:'店主姓名', field:'ownerName',width:50,align:'center'},
			             {title:'店主手机号', field:'ownerCell',width:50,align:'center'},
			             {title:'店铺名称', field:'shopName',width:50,align:'center'},
			             {title:'店铺地址', field:'shopAddress',width:50,align:'center'},
			             {title:'店铺二维码', field:'qrCodeUrl',width:50,align:'center'},
			             {title:'创建时间', field:'createTime',width:120,align:'center',
							formatter:function(value){
								return $.formatDate(value);
							}},
			             {title:'店铺状态', field:'verifyStatus',width:50,align:'center'}
					]]
			 });
		}
		function search(){
			var identity = $('#s_identity').val();
			var xsmAccount = $('#s_xsmAccount').val();
			var shopName = $('#s_shopName').val();
			var ycCardNo = $('#s_ycCardNo').val();
			var verifyStatus = $('#s_verifyStatus').val();
			var createTime = $('#s_createTime').val();
			$("#tt").datagrid('load',{
				identity:identity,
				xsmAccount:xsmAccount,
				shopName:shopName,
				ycCardNo:ycCardNo,
				verifyStatus:verifyStatus,
				createTime:createTime
	    	});
		}
		function updateShopDialog(){
	    	var chks= $('#tt').datagrid('getChecked');
	    	if(null!=chks && chks.length==1){
		    	$('#shopFrom').form('clear');
		    	$('#shopId').val(chks[0].shopId);
				$('#shopName').val(chks[0].shopName);
				$('#shopAddress').val(chks[0].shopAddress);
			    $('#shopDialog').dialog('open');
	    	}else{
	    		$.messager.alert('提示',"请选择一项进行修改!",'info');
	    	}
	    }
	function submitForm(){
    	var shopId=$("#shopId").val();
    	var shopAddress=$("#shopAddress").val();
    	 $.ajax({
			url:'${ctx}/store/shopAuth',
			type:"POST",
			data:JSON.stringify({
				  'shopId':shopId,
				  'shopAddress':shopAddress,
			}),
			dataType:"json",
			headers: { 'Content-Type': 'application/json;charset=UTF-8'},
			async: false,
			success:function(data){
				$.messager.alert('提示',data.msg,'info');
				$('#tt').datagrid('reload');
	    		$('#tt').datagrid('clearSelections');
	    		$('#shopDialog').dialog('close');
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