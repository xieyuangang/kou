<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>管理</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
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
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box;height:98%">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form action="" class="layui-form layui-form-pane">
        <div class="layui-inline">
            <label class="layui-form-label">用户名称</label>
            <div class="layui-input-block">
                <input id="searchCondition" type="text" maxlength="30"  class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div>

        <div class="layui-inline click"  id="toStorePage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>搜索</a>
       </div>
       <shiro:hasPermission name="sys:user:add">
        <div class="layui-inline click" id="addUser" onclick="javascript:addUserDialog();" >
            <a class="layui-btn layui-btn batchDel"><i class="layui-icon">&#xe61f;</i>添加</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:user:update">  
        <div class="layui-inline click" id="updateUser" onclick="javascript:updateUserDialog();" >
            <a class="layui-btn layui-btn-normal batchDel"><i class="layui-icon">&#xe642;</i>修改</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:user:delete">
        <div class="layui-inline click" id="deleteUser"  onclick="javascript:deleteUser();">
            <a class="layui-btn layui-btn-danger batchDel"><i class="layui-icon">&#x1007;</i>删除</a>
        </div>
        </shiro:hasPermission>
        <shiro:hasPermission name="sys:user:authRole">
        <div class="layui-inline click" id="addRoleAuth" onclick="javascript:commonnAddRole();">
            <a class="layui-btn layui-btn-warm batchDel"><i class="layui-icon">&#xe614;</i>分配角色</a>
        </div>
        </shiro:hasPermission>        
    </form>
</blockquote>
 <!-- dialog -->
<div id="userDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:480px;height:620px;padding:10px;"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
         <form class="easyui-form" id="userForm" method="post">
            <fieldset style="width:420px;">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
				    <tr>
                        <td><input id="userId" name="userId" type="hidden"/></td>
                    </tr>
                    <tr>
                        <td>申请人姓名<b>*</b></td>
                        <td><input id="applyName" name="applyName" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'申请人姓名不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td>申请人手机号<b>*</b></td>
                        <td><input id="applyPhone" name="applyPhone" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'申请人手机号不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td>店铺名称<b>*</b></td>
                        <td><input id="shopName" name="shopName" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'店铺名称不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td>店铺简称<b>*</b></td>
                        <td><input id="shopShortName" name="shopShortName" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'店铺简称不能为空!'"></input></td>
                    </tr>                   
                    <tr>
                        <td>店铺经营范围<b>*</b></td>
                        <td>
						<select id="shopScope" name="shopScope" style="width:70px;" class="easyui-combobox" data-options="editable:false" >
						 </select>
					    </td>           
                    </tr>
                                                          
                    <tr>
                       <td>店铺城市<b>*</b></td>
                       <td><input id="area" name="area" type="hidden"/></td>
                        <table id="areaTable" border="0">
							<tr>
								<td>省：</td>
								<td>
									<select id="provinceId" name="provinceId" style="width:70px;" class="easyui-combobox" data-options="editable:false" >
									</select>
								</td>
								<td>市：</td>
								<td>
									<select id="cityId" name="cityId" style="width:70px;" class="easyui-combobox" data-options="editable:false" >
									</select>
								</td>
								<td>县：</td>
								<td>
									<select id="countyId" name="countyId" style="width:70px;" class="easyui-combobox" data-options="editable:false" >
									</select>
								</td>
							</tr>
						</table>
                     </tr>
                     <tr>
                      <tr>
                        <td>店铺详细地址<b>*</b></td>
                        <td><input id="shopAddress" name="shopAddress" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'店铺详细地址不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td>店铺营业执照号<b>*</b></td>
                        <td><input id="shopLicense" name="shopLicense" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'店铺营业执照号不能为空!'"></input></td>
                    </tr>                     
                    <tr>
                            <td>店铺执照图片<b>*</b></td>  
                            <td>
                            <input type="file" id="file" name="file"  placeholder="上传图片">	                            
                            <button type="button" class="btn btn-primary" onclick="submitImg()" style="border: none;background: #009688;margin-top: 10px;">上传</button>                                        
							<input type="hidden" class="form-control" id="imgUrl" name="imgUrl">
							<img src="" style="height:120px;display: none;" class="imgPre" id="image"/>
                            </td> 
                    </tr>
			</div>
                </table>
            </fieldset>
        </form>
    </div>
</div>
<!-- dialog buttons -->
<div id="dialog_buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitForm();">提交</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#userDialog').dialog('close');">关闭</a>
</div>
 <div>
     <table id="tt" style="height:452px;"></table>
     <script type="text/javascript">
				$("#tt").css("width",$(window).width()-20);
	</script>
 </div> 
 <div id="addRoleDialog" title="分配角色" class="easyui-dialog"
	 closed="true" style="width: 560px; height: 520px; padding: 10px"
	 data-options="iconCls:'icon-save',modal:true" buttons="#role_buttons">
	<div class="tab">
		<table id="rt" style="width: 520px; height: 420px"></table>
	</div>
</div>
<!-- dialog buttons -->
<div id="role_buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="authorizationRole();">提交</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#addRoleDialog').dialog('close');">关闭</a>
</div>
 
<script type="text/javascript">
		 $(function(){
	        	initGrid();
			});		 
		 function initGrid(){
				 $('#tt').datagrid({
						url:'${ctx}/user/getUserPage',
						idField : "userId",
						pagination:true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'会员标识', field:'userId',width:50,align:'center'},
				             {title:'用户 memberId', field:'identity',width:50,align:'center'},
				             {title:'系统帐号', field:'account',width:50,align:'center'},
				             {title:'手机号', field:'cell',width:50,align:'center'},
				             {title:'用户名', field:'name',width:50,align:'center'},
				             {title:'姓名', field:'realName',width:50,align:'center'},
				             {title:'身份证', field:'idCard',width:50,align:'center'},
				             {title:'邮箱', field:'email',width:50,align:'center'},
				             {title:'性别 0女 1男', field:'gender',width:50,align:'center',
									formatter:function(value){
										return value==0?"女":value==1?"男":"未知";
									}},
				             {title:'头像Url', field:'headUrl',width:50,align:'center'},
				             {title:'区县名称', field:'area',width:50,align:'center'},
				             {title:'地址', field:'address',width:50,align:'center'},
				             {title:'备注', field:'remark',width:50,align:'center'},
				             {title:'固定二维码：主键+帐号+系统', field:'fixedQR',width:50,align:'center'},
				             {title:'状态', field:'state',width:50,align:'center'},
				             {title:'创建时间', field:'createTime',width:120,align:'center',
								formatter:function(value){
									return $.formatDate(value);
								}}							
						]]
				 });
			}
			
			function search(){
					var userId = $("#searchCondition").val();
					/* var status = $("#status").combobox('getValue'); */
		    	    $("#tt").datagrid('load',{
		    		   userId:userId,
		    	     });
			}
			var flag;
			var flafImg = 0;
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
		    	var provinceId = $("#provinceId").combobox('getText');
		    	var cityId = $("#cityId").combobox('getText');
		    	var countyId = $("#countyId").combobox('getText');		   
		    	var provinceCode = $("#provinceId").combobox('getValue');
		    	var cityCode = $("#cityId").combobox('getValue');
		    	var countyCode = $("#countyId").combobox('getValue');		    
		    	var area = provinceId+"-"+cityId+"-"+countyId;	
		    	var areaCode = provinceCode+"-"+cityCode+"-"+countyCode;
		    	var account=$("#account").val();
		    	var idCard=$("#idCard").val();
		    	var email=$("#email").val();
		    	var headUrl = $("#imgUrl").val();
		    	var file = $("#file").val();
		    	if(file!=""){
		    		if(headUrl==""){
		    			$.messager.alert('提示',"先上传头像Url！",'warning');
						 return ;
		    		}
		    	}		    	
		    	if($('#applyName').val()==""
		    		||$('#applyPhone').val()==""
		    		||$('#shopName').val()==""
		    		||$('#shopShortName').val()==""
		    		||$("#shopScope").combobox('getValue')==""
		    		||area==""
		    		||areaCode==""
		    		||$('#shopAddress').val()==""
		    		||$('#shopLicense').val()==""
		    		||headUrl==""){		
			    	   $.messager.alert('提示',"必要不能为空！",'error');
			    	   return;
			         }	
		    	 $.ajax({
					url:'${ctx}/user/'+url,
					type:"POST",
					data:JSON.stringify({
						  'userId':$('#userId').val(),
						  'applyName':$('#applyName').val(),
						  'applyPhone':$('#applyPhone').val(),
						  'shopName':$('#shopName').val(),
						  'shopShortName':$('#shopShortName').val(),
						  'shopScope':$("#shopScope").combobox('getValue'),
						  'shopCity':area,
						  'shopCityCode':areaCode,
						  'shopAddress':$('#shopAddress').val(),
						  'shopLicense':$('#shopLicense').val(),
						  'shopLicenseUrl':headUrl,
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
		    		$("#trPassword").attr("style",'display:none');
		    		$("#account").attr("disabled",'disabled');
		    	    showLoading();
		    		$.ajax({
		    			url:'${ctx}/user/getUserByAccount',
		    			type:"POST",
		    			data:{'account':chks[0].account},
		    			dataType:"json",
		    			async: false,
		    			success:function(data){
		    				data = data.data;
			    			if(null!=data){
			    				  $('#userForm').form('clear');
			    				  $('#userId').val(data.userId);
								  $('#identity').val(data.identity);
								  $('#account').val(data.account);
								  $('#password').val(data.password);
								  $('#cell').val(data.cell);
								  $('#name').val(data.name);
								  $('#realName').val(data.realName);
								  $('#idCard').val(data.idCard);
								  $('#email').val(data.email);
								  $('#gender').combobox('setValue',data.gender);
								  $('#headUrl').val(data.headUrl);
								  $('#provinceId').combobox('setValue',data.provinceName);
								  $('#cityId').combobox('setValue',data.cityName);
								  $('#countyId').combobox('setValue',data.countyName);
								  $('#address').val(data.address);
								  $('#remark').val(data.remark);
								  $('#state').val(data.state);
								  $('#state').val(data.state);
								  $("#imgUrl").val(data.headUrl);
						          $("#image").attr("src",data.headUrl);
						          $("#image").css("display","block");
				    			$('#userDialog').dialog('open');
			    			}
				    		hideLoading();
		    			},error:function(data){
		    				$.messager.alert('提示',data,'error');
		    				hideLoading();
		    			}
		    		});
		    	}else{
		    		$.messager.alert('提示',"请选择一项进行修改!",'info');return;
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
    function commonnAddRole() {
    	var uk = $('#tt').datagrid('getChecked');
		if (uk == null || uk.length < 1) {
			$.messager.alert('提示', '请选择用户!', 'warning');
			return;
		}
		$('#rt').datagrid({
			url : '${ctx}/role/getRolePage',
			idField : "roleId",
			pagination : true,
			rownumbers : true,
			fitColumns : true,
			collapsible : true,
			autoRowHeight : true,
			loadMsg : "数据加载中,请稍等...",
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			} ] ],
			columns : [ [ {
				title : '角色标识',
				field : 'roleId',
				width : 30,
				align : 'center'
			}, {
				title : '角色名称',
				field : 'name',
				width : 40,
				align : 'center'
			}, {
				title : '角色代码',
				field : 'code',
				width : 30,
				align : 'center'
			}, {
				title : '角色分组',
				field : 'group',
				width : 30,
				align : 'center'
			} , {
				title : '权限值',
				field : 'permission',
				width : 60,
				align : 'center'
			}] ]
		});
		$('#addRoleDialog').dialog('open');
	}
    function authorizationRole(){
		var ul = $('#tt').datagrid('getChecked');
		var users = new Array();
		if (ul == null || ul.length < 1) {
			$.messager.alert('提示', '请选择商户!', 'warning');
			return;
		}
		for ( var u in ul) {
			users[u] = ul[u].userId;
		}
		var rl = $('#rt').datagrid('getChecked');
		var roles = new Array();
		if (rl == null || rl.length < 1) {
			$.messager.alert('提示', '请选择角色!', 'warning');
			return;
		}
		for ( var r in rl) {
			roles[r] = rl[r].roleId;
		}
		$.ajax({
			url : '${ctx}/user/authorizationUserRoles',
			type : "POST",
			data : {
				'users' : users.toString(),
				'roles' : roles.toString()
			},
			dataType:"json",
			async : false,
			success : function(data) {
				$.messager.alert('提示', data.msg, 'info');
				$('#tt').datagrid('reload');
				$('#tt').datagrid('clearSelections');
				$('#rt').datagrid('clearSelections');
				$('#addRoleDialog').dialog('close');
			},
			error : function(data) {
				$.messager.alert('提示', data.statusText, 'error');
			}
		   });
	    }
    $('#shopScope').combobox({
		url:'${ctx}/user/getChannels',
		valueField:'code',
		textField:'name',		
	  }); 
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
	}
);   
    function submitImg(){
    	var source = "web";
    	var account=$("#account").val();
    	var alias =account+"img";
    	if(account==""){
    		$.messager.alert('提示', '手机号不能为空!', 'warning');
			return;	
    	}
		$.ajaxFileUpload({
			url :'<%=externalGlobalBaseUrl%>/file-manage/file/single',		
			secureuri : false,
			fileElementId : 'file',
			data:{'source':source,'mid':account,'alias':alias},
			dataType : 'json',
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			success : function(data) {
				if(data.code == '0000'){						
					data = data.data;
					$("#imgUrl").val(data.imageUrl);
					$("#image").attr("src",data.imageUrl);
		        	$("#image").css("display","block");
				}else{
					$("#loading").hide();
					$.messager.alert('提示', data.msg,'warning');
					return;
				}					
			},
			error : function(data,status,e) {
				$("#loading").hide();
				$.messager.alert('提示', data.msg,'warning');
			}
		});
	}		
      
</script>
	</body>
</html>