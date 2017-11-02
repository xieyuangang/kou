<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>实名认证审核</title>
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
            <label class="layui-form-label">红码手机号</label>
            <div class="layui-input-block">
                <input name="cell" type="text" maxlength="30" id="s_cell" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">身份证号<shiro:principal/></label>
            <div class="layui-input-block">
                <input name="idCard" type="text" maxlength="30" id="s_idCard" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-input-inline">
                <select id="s_state" lay-verify="required">
                    <option value="">请选择</option>
                    <option value="0">未通过</option>
                    <option value="1">审核通过</option>
                </select>
            </div>
        </div>
		<shiro:hasPermission name="merchant:view">
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
        <div class="just"><img src="" height="280" width="100%" alt="照片1" id="front_imgs"></div>
        <div class="back"><img src="" height="280" width="100%" alt="照片2" id="back_imgs"></div>
        <shiro:hasPermission name="merchant:update">
	        <div style="width:100%;height:100px;">
		        <form action="" class="layui-form layui-form-pane">
		        <div class="layui-form-item layui-form-text" style="width:100%;float: left;position: relative;border:none;height: 78px;">
		            <label class="layui-form-label" style="width:30%;float: left;height: 38px;">审核意见</label>
		            <div class="layui-input-block" style="height:39px;width:50%;padding: 0;">
		            <input type="text" placeholder="请输入内容" id="u_desc" style="height:37px;border:none;padding: 0 5px;width: 80%;">
		              
		            </div>
		            <button class="layui-btn" style="position: absolute;right:110px;bottom:30px;" onclick="javascript:submitAuth(0);">不通过</button>
		            <button class="layui-btn" style="position: absolute;right: 30px;bottom:30px;" onclick="javascript:submitAuth(1);">通过</button>
		        </div>
		    </form>
	        </div>
	     </shiro:hasPermission>
    </div>
   
</div>

<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
				 $('#tt').datagrid({
						url:'${ctx}/store/getUserAuthList',
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
						//frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'用户标识', field:'mid',width:50,align:'center'},
				             {title:'姓名', field:'name',width:50,align:'center'},
				             {title:'手机号', field:'cell',width:50,align:'center'},
				             {title:'身份证号', field:'idCard',width:50,align:'center'},
				             {title:'身份证正面照url', field:'frontUrl',width:50,align:'center'},
				             {title:'身份证背面照url', field:'backUrl',width:50,align:'center'},
				             {title:'审核状态', field:'state',width:50,align:'center',
				            	 formatter:function(value){
					            		if(value == 1){
					            			return "通过";
					            		}else if(value == 0){
					            			return "未通过";
					            		}else{
					            			return "未知";
					            		}
					            	}
				             },
				             {title:'描述', field:'desc',width:50,align:'center'}
						]],
		    			onClickRow: function (index, row){
		    				var chks= $('#tt').datagrid('getChecked');
		    	    		if(null!=chks && chks.length==1){
		    					$('#front_imgs').attr("src","");
		    					$('#back_imgs').attr("src","");
		    					$('#front_imgs').attr("src",row.frontUrl);
		    					$('#back_imgs').attr("src",row.backUrl);
		    	    		}else{
		    					$('#front_imgs').attr("src","");
		    					$('#back_imgs').attr("src","");
		    	    			
		    	    		}
					 	
						 }
				 });
			}
			function search(){
				$('#front_imgs').attr("src","");
				$('#back_imgs').attr("src","");
				var state = $('#s_state').val();
				var cell = $('#s_cell').val();
				var idCard = $('#s_idCard').val();
				$("#tt").datagrid('load',{
					state:state,
					cell:cell,
					idCard:idCard
		    	});
			}
			function submitAuth(state){
	        	var chks= $('#tt').datagrid('getChecked');
	    		if(null!=chks && chks.length==1){
					var mid = chks[0].mid;
					var idCard = chks[0].idCard;
					var name = chks[0].name;
					var desc = $('#u_desc').val();
					var operName = '${account}';
					$.ajax({
						url:'${ctx}/store/userAuth',
						type:"POST",
						data:JSON.stringify({
							  'mid':mid,
							  'idCard':idCard,
							  'name':name,
							  'desc':desc,
							  'operName':operName,
							  'state':state,
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