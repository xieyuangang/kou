<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>烟草信使统计</title>
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
            <label class="layui-form-label">批次号:</label>
            <div class="layui-input-block">
                <input id="searchMsgId" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
          <div class="layui-inline"> 
            <label class="layui-form-label">渠道:</label> 
            <div class="layui-input-block">    
            <select id="channel" name="channel" panelHeight="70" style="width: 135px;"
						data-options="editable:false">
						<option value="">--</option>
						<option value="0">非红码管家</option>
						<option value="1">红码管家</option>		
			</select>
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
         
        <div class="layui-inline click"  id="toYcxsOrderPage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>搜索</a>
         </div>
    </form>
</blockquote>
 <div>
     <table id="tt" style="height:452px;"></table>
     <script type="text/javascript">
				$("#tt").css("width",$(window).width()-20);
	</script>
 </div> 
  <script>
    layui.use(['form', 'layedit', 'laydate'], function () {});
</script>
<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
			 var msgid = $('#searchMsgId').val();
			 var begindate = $('#begindate').val();
			 var enddate = $('#enddate').val();
			 var channel=$('#channel').val();
				 $('#tt').datagrid({
						url:'${ctx}/ycxsorder/getYcxsOrderPage',
						queryParams:{
							msg_id:msgid,
							begindate:begindate,
							enddate:enddate,
							channel:channel,
			    		},
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						columns:[[
				             {title:'批次号', field:'msg_id',width:120,align:'center'},
				             {title:'渠道', field:'channel',width:120,align:'center',
				            	 formatter:function(value){
				            			var str;
										if(value=='0') {
				                			str = '<font color=#00BCFF>非红码管家</font>';
					            		}else if(value == '1'){
				                			str = '<font color=#FF83FA>红码管家</font>';
					            		}
				                		return str;
				            		 }
				             },
				             {title:'发送数量', field:'sms_amount',width:50,align:'center'},
				             {title:'发送成功数', field:'succ_amount',width:50,align:'center'},
				             {title:'成功率', field:'succ_rate',width:120,align:'center'},					
						]]
				 });
			}
		 	function search(){	
				initGrid();
			} 
			
    //***********************************************************************************************//
    //********************************************** 华丽分割线 ***************************************//
    //***********************************************************************************************//
</script>
	</body>
</html>