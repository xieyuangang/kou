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
            <label class="layui-form-label">行业</label>
            <div class="layui-input-inline">
                <select id="role_s" name="modules" lay-verify="required">
                    <option value="">烟草</option>
                   <option value="${role.id }">${role.name}</option>
                </select>
            </div>
        </div>
        
           <div class="layui-inline">
            <label class="layui-form-label">新商盟账号</label>
            <div class="layui-input-block">
                <input name="name" type="text" maxlength="30" id="name" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">红码手机号</label>
            <div class="layui-input-block">
                <input name="name" type="text" maxlength="30" id="name" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
        
        <div class="layui-inline">
            <label class="layui-form-label">店铺名称</label>
            <div class="layui-input-block">
                <input name="enName" type="text" maxlength="30" id="enName" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>
         <div class="layui-inline">
            <label class="layui-form-label">起止时间</label>
            <div class="layui-input-inline">
                <input type="text" name="" id="" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off"
                       class="layui-input" onclick="layui.laydate({elem: this})">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">截止时间</label>
            <div class="layui-input-inline">
                <input type="text" name="" id="" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off"
                       class="layui-input" onclick="layui.laydate({elem: this})">
            </div>
        </div>

        <div class="layui-inline"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>查询</a>
       </div>

    </form>
</blockquote>
 <div>
     <table id="tt" style="height:252px;"></table>
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
			 var name = $('#searchShopName').val();
				var endCreateTime = $('#endCreateTime').val();
				 $('#tt').datagrid({
						url:'http://192.168.3.65:8801/merchantService/store/shopList',
						queryParams:{
							name:name
			    		},
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
							
				             {title:'订单编号', field:'',width:50,align:'center'},
				             {title:'店铺名称', field:'enName',width:50,align:'center'},
				             {title:'店铺地址', field:'address',width:50,align:'center'},
				             {title:'红码手机号', field:'name',width:50,align:'center'},
				             {title:'购买商品', field:'',width:50,align:'center'},
				             {title:'商品数量', field:'',width:50,align:'center'},
				             {title:'交易金额', field:'',width:50,align:'center'},
				             {title:'实际交易金额', field:'',width:50,align:'center'},
				             {title:'手续费', field:'',width:50,align:'center'},
				             {title:'交易状态', field:'',width:50,align:'center'},
				             {title:'交易时间', field:'createTime',width:120,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}}				
						]]
				 });
			}
			function search(){
				//initGrid();
			}
			var flag;
			function addUserDialog(){
			    $('#userForm').form('clear');
				$('#userDialog').dialog('open');
				flag = "add";
			}
		    function submitForm(){
		    	var url;
		    	if(flag==='add')
		    		url = "addUser";
		    	else if(flag==='update')
		    		url = "updateUser";
/* 		    	if($("#userform").validate()){
		    		return;
		    	} */	
		    	alert("用户添加2");
		    	alert($('#operTime').combobox('getValue'));
		    	alert("发起请求");
		    	$.ajax({
					url:'${ctx}/user/'+url,
					type:"POST",
					data:JSON.stringify({
							  'userId':$('#userId').val(),
							  'identity':$('#identity').val(),
							  'account':$('#account').val(),
							  'password':$('#password').val(),
							  'cell':$('#cell').val(),
							  'name':$('#name').val(),
							  'salt':$('#salt').val(),
							  'realName':$('#realName').val(),
							  'idCard':$('#idCard').val(),
							  'email':$('#email').val(),
							  'gender':$('#gender').val(),
							  'headUrl':$('#headUrl').val(),
							  'area':$('#area').val(),
							  'address':$('#address').val(),
							  'remark':$('#remark').val(),
							  'fixedQR':$('#fixedQR').val(),
							  'state':$('#state').val(),
							  'operId':$('#operId').val(),
							  'operTime':$('#operTime').combobox('getValue'), 
					}),
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						$('#tt').datagrid('reload');
			    		$('#tt').datagrid('clearSelections');
			    		$('#userDialog').dialog('close');
						hideLoading();
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				});
	        }
		    function updateUserDialog(){
		    	flag = "update";
		    	var chks= $('#tt').datagrid('getChecked');
		    	if(null!=chks && chks.length==1){
				$('#userform').form('clear');
					  $('#userId').val(chks[0].userId);
					  $('#identity').val(chks[0].identity);
					  $('#account').val(chks[0].account);
					  $('#password').val(chks[0].password);
					  $('#cell').val(chks[0].cell);
					  $('#name').val(chks[0].name);
					  $('#salt').val(chks[0].salt);
					  $('#realName').val(chks[0].realName);
					  $('#idCard').val(chks[0].idCard);
					  $('#email').val(chks[0].email);
					  $('#gender').val(chks[0].gender);
					  $('#headUrl').val(chks[0].headUrl);
					  $('#area').val(chks[0].area);
					  $('#address').val(chks[0].address);
					  $('#remark').val(chks[0].remark);
					  $('#fixedQR').val(chks[0].fixedQR);
					  $('#state').val(chks[0].state);
					  $('#operId').val(chks[0].operId);
					  $('#operTime').datebox('setValue',$.formatDate(chks[0].operTime));
    			$('#userDialog').dialog('open');
				  $('#tt').datagrid('clearSelections');
		    	  hideLoading();	
		    	}else{
		    		$.messager.alert('提示',"请选择一项进行修改!",'info');
		    	}
		    }
		    function deleteUser(){
		    	var chks = null;
	        	chks = $('#tt').datagrid('getChecked');
	        	if(chks.length<1){
	        		$.messager.alert('提示','请至少选择一项!','warning');
	        		return ;
	        	}
	        	var arr = new Array();
	        	for(var c in chks){
	        		arr[c] = chks[c].userId;
	        	}
	        	$.messager.confirm('提示', '确定要删除该项目吗?', function(yes){
	        		if(yes){
	        			showLoading();
	        			$.ajax({
	        				url:'${ctx}/user/deleteUser',
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
</script>
	</body>
</html>