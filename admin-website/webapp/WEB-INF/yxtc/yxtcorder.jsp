<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>订单查询</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/layui/layui.js"></script>
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
            <label class="layui-form-label">新商盟账号</label>
            <div class="layui-input-block">
                <input id="searchCustId" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
         <div class="layui-inline">
            <label class="layui-form-label">起止时间</label>
            <div class="layui-input-inline">
                <input type="text" name="begindate" id="begindate" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off"
                       class="layui-input" onclick="layui.laydate({elem: this})">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">截止时间</label>
            <div class="layui-input-inline">
                <input type="text" name="enddate" id="enddate" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off"
                       class="layui-input" onclick="layui.laydate({elem: this})">
            </div>
        </div>
        <div class="layui-inline click"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>查询</a>
       </div>
        <div class="layui-inline click" id="updateUser" onclick="javascript:searchDialog();" >
            <a class="layui-btn layui-btn-normal"><i class="layui-icon">&#xe642;</i>订单详情查询</a>
        </div>
    </form>
</blockquote>

 <!-- dialog -->
<div id="userDialog" title="订单详情" class="easyui-dialog" closed="true" style="width:730px;height:580px;padding:10px;"
   data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
         <form class="easyui-form" id="userForm" method="post">
           <div>
         <table id="ttr" style="height:480px;width:700px;"></table>
          </div> 
        </form>
    </div>
</div>
<!-- dialog buttons -->
<div id="dialog_buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#userDialog').dialog('close');">关闭</a>
</div>
 <div>
     <table id="tt" style="height:452px;"></table>
     <script type="text/javascript">
				$("#tt").css("width",$(window).width()-20);
	</script>
 </div> 
 <script>
    layui.use(['form', 'layedit', 'laydate'],function(){
    });
</script>
<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
			 var custid = $('#searchCustId').val();
			 var begindate = $('#begindate').val().replace(/-/g,'').trim();
			 var enddate = $('#enddate').val().replace(/-/g,'').trim();
				 $('#tt').datagrid({
						url:'${ctx}/yxtcorder/getYxtcOrderPage',
						queryParams:{
							custCode:custid,
							beginDate:begindate,
							endDate:enddate,
			    		},
						pagination: true,
						rownumbers : false,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
							 {title:'id', field:'orderId',width:100,align:'center'},
				             {title:'新商盟账号', field:'custCode',width:100,align:'center'},
				             {title:'订单号', field:'coNum',width:100,align:'center'},
				             {title:'创建日期', field:'createDate',width:90,align:'center'},	
						     {title:'创建时间', field:'createTime',width:90,align:'center'},	
				             {title:'订单需求量', field:'reqQtySum',width:50,align:'center'},
				             {title:'订单订购量', field:'ordQtySum',width:50,align:'center'},
				             {title:'订单总金额', field:'ordAmtSum',width:50,align:'center'},
				             {title:'订单状态', field:'orderStatus',width:50,align:'center',
				             formatter:function(value){
				            			var str;
										if(value=='10') {
				                			str = '<font color=#FFA07A>新建</font>';
					            		}else if(value == '20'){
				                			str = '<font color=#FF83FA>提交</font>';
					            		}else if(value == '30'){
				                			str = '<font color=#00B1FF>审核</font>';
					            		}else if(value == '40'){
				                			str = '<font color=#00BAFF>确认</font>';
					            		}else if(value == '50'){
				                			str = '<font color=#00BCFF>配送</font>';
					            		}else if(value == '60'){
				                			str = '<font color=#00BDFF>完成</font>';
					            		}else if(value == '90'){
				                			str = '<font color=#00BEFF>停止</font>';
					            		}
				                		return str;
				            		 }},
				             {title:'支付状态', field:'pmtStatus',width:50,align:'center',
				            	 formatter:function(value){
				            			var str;
										if(value=='0') {
				                			str = '<font color=#FEA07A>未付款</font>';
					            		}else if(value == '1'){
				                			str = '<font color=#FD83FA>已付款</font>';
					            		}else if(value == '2'){
				                			str = '<font color=#01B1FF>付款中</font>';
					            		} return str;}}
						]]
				 });
			}
			
			function search(){
				initGrid();
			}
		    function searchDialog(){
		    	var chks= $('#tt').datagrid('getChecked');
		    	if(null!=chks && chks.length==1){
				$('#userform').form('clear');
				$('#ttr').datagrid({
					url:'${ctx}/yxtcorder/getYxtcOrderDetailPage',
					queryParams:{
						orderId:chks[0].orderId,
		    		},
					pagination : false,
					rownumbers : false,
					fitColumns : true,
					collapsible : true,
					autoRowHeight : true,
					loadMsg : "数据加载中,请稍等...",
					columns:[[
			             {title:'卷烟编码', field:'cgtCode',width:100,align:'center'},
			             {title:'烟品名称', field:'cgtName',width:100,align:'center'},
			             {title:'卷烟简码', field:'shortCode',width:60,align:'center'},	
					     {title:'单位', field:'umSaleName',width:50,align:'center'},	
			             {title:'订购需求量', field:'reqQty',width:50,align:'center'},
			             {title:'确认总量', field:'vfyQty',width:50,align:'center'},
			             {title:'订购量', field:'ordQty',width:50,align:'center'},
					]]
			 });
    			$('#userDialog').dialog('open');
				  $('#tt').datagrid('clearSelections');
		    	  hideLoading();	
		    	}else{
		    		$.messager.alert('提示',"请选择一项进行查看!",'info');
		    	}
		    }

    //***********************************************************************************************//
    //********************************************** 华丽分割线 ***************************************//
    //***********************************************************************************************//
</script>
	</body>
</html>