<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>店铺证件审核</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	    <link href="${ctx}/css/news.css" rel="stylesheet" type="text/css" />
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
                <select id="role_s" name="modules" lay-verify="required">
                    <option value="">烟草</option>
                   <option value="${role.id }">${role.name}</option>
                </select>
            </div>
        </div>
       <!--  <div class="layui-inline">
            <label class="layui-form-label">红码手机号</label>
            <div class="layui-input-block">
                <input name="name" type="text" maxlength="30" id="name" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div> -->
        
        <div class="layui-inline">
            <label class="layui-form-label">店铺名称</label>
            <div class="layui-input-block">
                <input name="s_shopName" type="text" maxlength="30" id="s_shopName" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        <!-- <div class="layui-inline">
            <label class="layui-form-label">身份证号</label>
            <div class="layui-input-block">
                <input name="s_idCard" type="text" maxlength="30" id="s_idCard" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div> -->
        
        <div class="layui-inline">
            <label class="layui-form-label">审核状态</label>
            <div class="layui-input-inline">
                <select id="s_state" lay-verify="required">
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

    </form>
</blockquote>
 <div>
     <table id="tt" style="height:252px;"></table>
     <script type="text/javascript">
				$("#tt").css("width",$(window).width()-20);
	</script>
 </div> 
 
 
 <div>
    <div class="X-IDPhoto">
        <div class="just"><img src="" height="280" width="100%" alt="" id="imgs"><p>证件照片</p></div>
	    <shiro:hasPermission name="shop:update">
	        <div class="back">
		        <form action="" class="layui-form layui-form-pane">
		        <div class="layui-form-item layui-form-text" style="width:100%;float: left;position: relative;border:none;">
		            <label class="layui-form-label">审核意见</label>
		            <div class="layui-input-block" style="height:235px;width: 100%;">
		                <textarea placeholder="请输入内容" id="u_desc" class="layui-textarea" ></textarea>
		            </div>
		            <button class="layui-btn" style="position: absolute;right:110px;bottom:30px;" onclick="javascript:submitAuth(0);">不通过</button>
		            <button class="layui-btn" style="position: absolute;right: 30px;bottom:30px;" onclick="javascript:submitAuth(1);">通过</button>
		        </div>
		    </form>
	        </div>
        </shiro:hasPermission>
    </div>
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
						url:'${ctx}/store/getShopAuthList',
						queryParams:{
							status:'0'
		    			},
						pagination:true,
						singleSelect:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'主键', field:'id',width:50,align:'center',hidden:true},
				             {title:'店铺主键', field:'shopId',width:50,align:'center',hidden:true},
				             {title:'店铺名称', field:'shopName',width:50,align:'center'},
				             {title:'证件名称', field:'name',width:50,align:'center'},
				             {title:'证件地址', field:'url',width:50,align:'center'},
				             {title:'审核状态', field:'status',width:50,align:'center'}
						]],
		    			onClickRow: function (index, row){
		    				var chks= $('#tt').datagrid('getChecked');
		    	    		if(null!=chks && chks.length==1){
		    				 	$('#imgs').attr("src","");
		    				 	$('#imgs').attr("src",row.url);
		    	    		}else{
		    				 	$('#imgs').attr("src","");
		    	    		}
					 	
						 }
				 });
			}
			function search(){
				$('#imgs').attr("src","");
				var shopName = $('#s_shopName').val();
				var status = $("#s_state").val();
				var idCard = $("#s_idCard").val();
				$("#tt").datagrid('load',{
					shopName:shopName,
					idCard:idCard,
					status:status
		    	});
			}
			function submitAuth(status){
	        	var chks= $('#tt').datagrid('getChecked');
	    		if(null!=chks && chks.length==1){
					var shopId = chks[0].shopId;
					var id = chks[0].id;
					var code = chks[0].code;
					var desc = $('#u_desc').val();
					$.ajax({
						url:'${ctx}/store/shopAuth',
						type:"POST",
						data:JSON.stringify({
							  'shopId':shopId,
							  'code':code,
							  'id':id,
							  'status':status,
						}),
						dataType:"json",
						headers: { 'Content-Type': 'application/json;charset=UTF-8'},
						async: false,
						success:function(data){
							$.messager.confirm('提示', data.msg, function(yes){
				        		if(yes){
				        			//$('#tt').datagrid('reload');
				        			$('#tt').datagrid('clearSelections');
				        			alert(111111111111);
				        		return false;
				        		}else{
				        		//	$('#tt').datagrid('reload');
				        			$('#tt').datagrid('clearSelections');
				        			alert(22222222222222);
				        		return false;
				        		}
				        		
				        	});
						},error:function(data){
							$.messager.confirm('提示', data.msg, function(yes){
				        		if(yes){
				        			$('#tt').datagrid('reload');
				        			$('#tt').datagrid('clearSelections');
				        			alert(3333333333333);
				        			return false;
				        		}else{
				        			$('#tt').datagrid('reload');
				        			$('#tt').datagrid('clearSelections');
				        			alert(44444444444);
				        			return false;
				        		}
				        	});
						}
					}); 
	    		}else{
	    			$.messager.alert('提示',"请选择一条进行修改!",'warning');
	    			return null;
	    		}
				 
			}

    //***********************************************************************************************//
    //********************************************** 华丽分割线 ***************************************//
    //***********************************************************************************************//
</script>
	</body>
</html>