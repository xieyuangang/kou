<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>活动对账</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	   <%--  <script type="text/javascript" src="${ctx}/layui/layui.js" charset="utf-8"></script> --%>
	    <script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/easyui-lang-zh_CN.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
	     <style>
           .layui-inline{margin-bottom: 5px;}
          /*  .combo{display: none;} */
         </style>
	</head>
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box;">
 
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form action="" class="layui-form layui-form-pane">
       <div class="layui-inline">
            <label class="layui-form-label" style="width:80px">活动名称</label>
          <div class="layui-input-inline">
          <select id="activityCode" name="activityCode" style="width:120px;height:36px;" class="" data-options="editable:false" >
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
       <shiro:hasPermission name="sys:activityRestCount:function"> 
        <div class="layui-inline"  id="rest" onclick="javascript:restCount();" >
        <a class="layui-btn layui-btn layui-btn-warm"><i class="layui-icon">&#xe612;</i>重新统计</a>
       </div>
       </shiro:hasPermission>  
    </form>
</blockquote>	
	<div>
	     <vid>
        <table id="tt" style="height:252px;">
            <h3 style="font-size: 20px;line-height: 40px;">统计信息</h3>
        </table>
    </vid>
     <shiro:hasPermission name="sys:activityDetail:function">  
     <div class="layui-inline" style="float: right;margin-right:15px;margin-top: 10px" onclick="javascript:exportFileClearList();">
	        <a class="layui-btn layui-btn-danger batchDel">导出结算名单</a>
	 </div>
	 </shiro:hasPermission>
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
     <shiro:hasPermission name="sys:activityDetail:function">  
	    <div class="layui-inline" style="float: right;margin-right:15px;margin-top: 10px;padding-bottom: 40px; " onclick="javascript:exportFile();">
	        <a class="layui-btn layui-btn-danger batchDel">导出明细</a>
	    </div>
	 </shiro:hasPermission>
      
<!--        <script>
    layui.use(['form', 'layedit', 'laydate'], function () { });
</script> -->
	</div>		       
		<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
				 $('#tt').datagrid({
						url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/activityDayBills/getActivityDayBillsPage',
						idField : "id",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'主键Id', field:'id',width:50,align:'center'},
				             {title:'日期', field:'tradeTime',width:50,align:'center',
									formatter:function(value){
										return $.formatDate(value,"yyyy-MM-dd");
									}},	
				             {title:'活动名称', field:'activityName',width:50,align:'center'},
				             {title:'行业', field:'industry',width:50,align:'center'},
				             {title:'零售户姓名', field:'merchantName',width:50,align:'center'},
				             {title:'手机号', field:'cellphone',width:50,align:'center'},
				             {title:'店铺名称', field:'shopName',width:50,align:'center'},
				             {title:'店铺地址', field:'shopAddress',width:50,align:'center'},
				             {title:'交易笔数', field:'tradeNum',width:50,align:'center'},
				             {title:'有效交易量', field:'validTradeNum',width:50,align:'center'},
				             {title:'排名', field:'ranking',width:50,align:'center'},
				             {title:'奖励金额', field:'awardSum',width:50,align:'center'},
				             {title:'创建时间', field:'createTime',width:50,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}}							
						]]
				 });
				 
				 $('#ttSub').datagrid({
						url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/activityDayBills/activityDayBillsCountDetail',
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
				var activityCode = $('#activityCode').combobox('getValue');
	    	    $("#tt").datagrid('load',{
	    	    	beginTime:beginTime,
	    	    	endTime:endTime,
	    	    	activityCode:activityCode,
	    	     });
				 $("#ttSub").datagrid('load',{
		    	    	beginTime:beginTime,
		    	    	endTime:endTime,
		    	    	activityCode:activityCode,
		    	     });
			}									
		    function restCount(){
		    	var beginTime = $('#beginTime').combobox('getValue');
				var endTime = $('#endTime').combobox('getValue');
				var activityCode = $('#activityCode').combobox('getValue');
				if(beginTime==""||endTime==""||activityCode==""){
		    		$.messager.alert('提示',"起止、截止时间,活动名称都不能为空!",'info');
		    		return;
		    	}
		    	$.ajax({
					url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/activityDayBills/activityDayBillsCount?beginTime='+beginTime+"&endTime="+endTime+"&activityCode="+activityCode,
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
		    
		    function exportFileClearList(){
		    	var beginTime = $('#beginTime').combobox('getValue');
				var endTime = $('#endTime').combobox('getValue');
				var activityCode = $('#activityCode').combobox('getValue');
				if(beginTime==""||endTime==""||activityCode==""){
		    		$.messager.alert('提示',"起止、截止时间,活动名称都不能为空!",'info');
		    		return;
		    	}
		    	location.href ='<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/activityDayBills/exportFileClearList?beginTime='+beginTime+"&endTime="+endTime+"&activityCode="+activityCode;
	        }	
		    
		    function exportFile(){
		    	var beginTime = $('#beginTime').combobox('getValue');
				var endTime = $('#endTime').combobox('getValue');
				var activityCode = $('#activityCode').combobox('getValue');
				if(beginTime==""||endTime==""||activityCode==""){
		    		$.messager.alert('提示',"起止、截止时间,活动名称都不能为空!",'info');
		    		return;
		    	}
		    	location.href ='<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/activityDayBills/exportFile?beginTime='+beginTime+"&endTime="+endTime+"&activityCode="+activityCode;
	        }		
		   
		    //***********************************************************************************************//
		    //********************************************** 华丽分割线 ***************************************//
		    //***********************************************************************************************//
			
		    $('#activityCode').combobox({
               url:'<%=externalGlobalBaseUrl%>/<%=serverContextPath%>/activityDayBills/getActivityAll',
			  valueField:'activityCode',
			  textField:'name',		
			});
		</script>
	</body>
</html>