<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>日常对账</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript" src="${ctx}/layui/layui.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
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
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block" style="width:120px;">
			<select id="status"  name="status" panelHeight="70"  data-options="editable:false">
						<option value="0">未扎账</option>
						<option value="1">已扎账</option>
						<option value="">全部</option>
			</select>
            </div>
        </div>
	   <div class="layui-inline">
	           <label class="layui-form-label" style="width:80px">起止时间</label>
	         <div class="layui-input-inline">
	                <!-- <input type="text" name="beginTime" id="beginTime" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off"
	                      class="layui-input" onclick="layui.laydate({elem: this})" style="width:95px;"> -->
	                      <input id="beginTime" name="beginTime" type="text" class="easyui-datebox" required="required" style="width:110px;height:38px;">
	                 
	           </div> 
	       </div>
	       <div class="layui-inline">
	           <label class="layui-form-label">截止时间</label>
	           <div class="layui-input-inline">
	              <!--  <input type="text" name="endTime" id="endTime" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off"
	                      class="layui-input" onclick="layui.laydate({elem: this})" style="width:95px;"> -->
	                       <input id="endTime" name="endTime" type="text" class="easyui-datebox" required="required" style="width:110px;height:38px;" >
	           </div>
	       </div>
	   <div class="layui-inline"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>查询</a>
       </div>
       <shiro:hasPermission name="sys:dayRestCount:function">
       <div class="layui-inline"  id="rest" onclick="javascript:restCount();" >
        <a class="layui-btn layui-btn layui-btn-warm"><i class="layui-icon">&#xe612;</i>重新统计</a>
       </div>
       </shiro:hasPermission>
        <shiro:hasPermission name="sys:sureBills:function">       
        <div class="layui-inline"  id="" onclick="javascript:confirmCheck();">
        <a class="layui-btn"><i class="layui-icon">&#xe618;</i>扎账完成</a>
       </div>
       </shiro:hasPermission>
       <p style="width:100%;height: 30px;">银行回盘文件：<b>http://file.inlee.com.cn:8011/shbank/20170814.zip</b><a class="layui-btn layui-btn-normal" style="float:right"><i class="layui-icon">&#xe601;</i>点击下载</a> </p>
    </form>
</blockquote>		
<div>
    <vid>
        <table id="tt" style="height:252px;">
            <h3 style="font-size: 20px;line-height: 40px;">统计信息</h3>
        </table>
    </vid>
    <script type="text/javascript">
        $("#tt").css("width",$(window).width()-20);
    </script>
    
    <vid>
        <table id="ttSub" style="height:252px;">
            <h3 style="font-size: 20px;line-height: 40px;">交易明细</h3>
        </table>
    </vid>
    <script type="text/javascript">
        $("#ttSub").css("width",$(window).width()-20);
    </script>
     <shiro:hasPermission name="sys:billsdetail:function">  
    <div class="layui-inline" style="float: right;margin-right:15px;margin-top: 10px;padding-bottom: 40px;" onclick="javascript:exportFile();">
        <a class="layui-btn layui-btn-danger batchDel">导出明细</a>
    </div>
    </shiro:hasPermission>
</div>
 <script>
    layui.use(['form', 'layedit', 'laydate'], function () {});
</script>
		<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
				 $('#tt').datagrid({
						url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/shopDayBills/getShopDayBillsPage',
						idField : "id",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'序号', field:'id',width:50,align:'center'},
				             {title:'交易时间', field:'tradeTime',width:50,align:'center',
									formatter:function(value){
										return $.formatDate(value,"yyyy-MM-dd");
									}},	
				             {title:'行业', field:'industry',width:30,align:'center'},
				             {title:'交易笔数', field:'tradeNum',width:50,align:'center'},
				             {title:'交易金额', field:'tradeSum',width:50,align:'center'},
				             {title:'清算金额', field:'clearSum',width:50,align:'center'},
				             {title:'手续', field:'handCharge',width:50,align:'center'},
				             {title:'利润', field:'profit',width:30,align:'center'},
				             {title:'状态', field:'status',width:30,align:'center',
									formatter:function(value){
										return value==1?"已扎账":"未扎账";
									}},
							{title:'银行回盘文件', field:'bankFileUrl',width:50,align:'center',
										formatter:function(value){
											return '<a href='+value+'><u>下载回盘文件</u></a>';
										}},  
				             {title:'创建时间', field:'createTime',width:60,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}},							
				             {title:'扎账时间', field:'updateTime',width:60,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}}							
						]]
				 });
				 $('#ttSub').datagrid({
						url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/shopDayBills/shopDayBillsCountDetail',
						idField : "id",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'序号', field:'id',width:50,align:'center'},
				             {title:'订单编号', field:'outTradeNo',width:50,align:'center'},	
				             {title:'行业', field:'industry',width:50,align:'center'},
				             {title:'省份', field:'provinceCode',width:50,align:'center'},
				             {title:'地市', field:'cityCode',width:50,align:'center'},
				             {title:'店铺名称', field:'shopName',width:50,align:'center'},
				             {title:'店铺地址', field:'shopAddress',width:50,align:'center'},
				             {title:'红码手机号', field:'cellphone',width:50,align:'center'},
				             {title:'消费金额(元)', field:'tradeSum',width:50,align:'center'},
				             {title:'实际支付金额(元)', field:'actualSum',width:50,align:'center'},
				             {title:'手续费(元)', field:'handCharge',width:50,align:'center'},
				             {title:'交易状态', field:'tradeStatus',width:50,align:'center'},
				             {title:'交易时间', field:'tradeTime',width:50,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}}							
						]]
				 });
								 				 
			}			
			function search(){
				var beginTime = $('#beginTime').combobox('getValue');
				var endTime = $('#endTime').combobox('getValue');
				var status = $("#status").val();
	    	    $("#tt").datagrid('load',{
	    	    	beginTime:beginTime,
	    	    	endTime:endTime,
	    	    	status:status,
	    	     });
				 $("#ttSub").datagrid('load',{
		    	    	beginTime:beginTime,
		    	    	endTime:endTime,
		    	     });
			}									
		    function restCount(){
		    	var beginTime = $('#beginTime').combobox('getValue');
				var endTime = $('#endTime').combobox('getValue');
				if(beginTime==""||endTime==""){
		    		$.messager.alert('提示',"起止或截止时间不能为空!",'info');
		    		return;
		    	}
		    	$.ajax({
					url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/shopDayBills/shopDayBillsCount?beginTime='+beginTime+"&endTime="+endTime,
					type:"POST",
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						$('#tt').datagrid('reload');
						hideLoading();
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				});
	        }
		    function confirmCheck(){
		    	var beginTime = $('#beginTime').combobox('getValue');
				var endTime = $('#endTime').combobox('getValue');
		    	if(beginTime==""||endTime==""){
		    		$.messager.alert('提示',"起止或截止时间不能为空!",'info');
		    		return;
		    	}
	    		$.ajax({
					url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/shopDayBills/updateByTradeTime?beginTime='+beginTime+"&endTime="+endTime,
					type:"POST",					
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						$('#tt').datagrid('reload');
						hideLoading();
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				});
	        }
		    function exportFile(){
		    	var beginTime = $('#beginTime').combobox('getValue');
				var endTime = $('#endTime').combobox('getValue');
		    	if(beginTime==""||endTime==""){
		    		$.messager.alert('提示',"起止或截止时间不能为空!",'info');
		    		return;
		    	}
		    	location.href ='<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/shopDayBills/exportFile?beginTime='+beginTime+"&endTime="+endTime;
	        }
		    //***********************************************************************************************//
		    //********************************************** 华丽分割线 ***************************************//
		    //***********************************************************************************************//
		</script>
	</body>
</html>