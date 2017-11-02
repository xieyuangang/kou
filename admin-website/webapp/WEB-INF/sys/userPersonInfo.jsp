<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>管理</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	    <link href="${ctx}/css/user.css" rel="stylesheet" type="text/css" />
	    
	    <script type="text/javascript" src="${ctx}/js/jquery-1.9.1.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.showLoading.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/jquery.utils.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/dateFormat.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/easyui-lang-zh_CN.js" charset="utf-8"></script>
	    <script type="text/javascript" src="${ctx}/js/ajaxfileupload.js" charset="utf-8"></script>
	     <style>
           .layui-inline{margin-bottom: 5px;}
         </style>
	</head>
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<!-- <blockquote class="layui-elem-quote news_search" style="width: 96.5%;"></blockquote> -->
 	 	<div class="user_left" style="margin-bottom: 33px;">
		    <input id="userId" name="userId" type="hidden"/>          
			<div class="layui-form-item">
			    <label class="layui-form-label">手机号/账号</label>
			    <div class="layui-input-block">
			    	<input type="text" id="account" name="account" class="layui-input" disabled="disabled" data-options="required:true,missingMessage:'手机号不能为空!'">          
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">真实姓名</label>
			    <div class="layui-input-block">
			<input type="text" id="realName" name="realName" class="layui-input">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">身份证</label>
			    <div class="layui-input-block">
			    	<input type="text" id="idCard" name="idCard" class="layui-input">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">邮箱</label>
			    <div class="layui-input-block">
			    	<input type="email" id="email" name="email" class="layui-input">
			    </div>
			</div>
			
			<div class="layui-form-item">
			    <label class="layui-form-label">性别</label>
			    <div class="layui-input-block">
			       <select id="gender" class="easyui-combobox" name="gender" panelHeight="70" 
                       style="width:432px;height: 38px;border-radius: 3px;border-color: #ffa8a8;background-color: #fff3f3"data-options="editable:false">
							<option value="1">男</option>
							<option value="0">女</option>
							<option value="2">未知</option>
							</select>
			    </div>
			</div>
			
	  
                      
			
			
			<div class="layui-form-item">
			    <label class="layui-form-label">用户昵称</label>
			    <div class="layui-input-block">
			    	<input type="email" id="name" name="name" class="layui-input">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">区县名称</label>
			    <div class="layui-input-block">
			    	<input  id="area" name="area" type="hidden" class="layui-input">
			    	 <table id="areaTable" border="0">
							<tr style="line-height: 37px;">
								<td>省：</td>
								<td>
									<select id="provinceId" name="provinceId" style="width:90px;height:36px" class="easyui-combobox" data-options="editable:false" >
									</select>
								</td>
								<td>市：</td>
								<td>
									<select id="cityId" name="cityId" style="width:90px;height:36px; " class="easyui-combobox" data-options="editable:false" >
									</select>
								</td>
								<td>县：</td>
								<td>
									<select id="countyId" name="countyId" style="width:90px;height:36px" class="easyui-combobox" data-options="editable:false" >
									</select>
								</td>
							</tr>
						</table>
			    </div>
			</div>

					<div class="layui-form-item">
			    <label class="layui-form-label">地址</label>
			    <div class="layui-input-block">
			    	<input type="text" id="address" name="address" class="layui-input" >
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">头像Url</label>
			    <div class="layui-input-block">	
				   <input type="file" id="file" name="file"  placeholder="上传图片">	                            
	               <button type="button" class="btn btn-primary" onclick="submitImg()" style="border: none;background: #009688;">上传</button>                    
				    <input type="hidden" class="form-control" id="imgUrl" name="imgUrl">
					<img src="" style="height:120px;display: none;" class="imgPre" id="image"/>    	
			    </div>
			</div>
			
			
		<div  id="dialog_buttons" class="layui-form-item" style="margin-left: 5%;">
		    <div class="layui-input-block">
		    	<button class="layui-btn" onclick="submitForm();">保存</button>
				<button class="layui-btn layui-btn-primary" onclick="closeFunction();">关闭</button>
		    </div>
		</div>
			
</div> 


<!-- 
 <blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
         
  <div id="userDialog" title="编辑个人资料" class="easyui-dialog" closed="false" style="width:420px;height:640px;padding:10px;"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
         <form class="easyui-form" id="userForm" method="post">
            <fieldset style="width:360px">
                <legend>带<b>*</b>为必填项</legend>
                <table border="0">
				    <tr>
                        <td><input id="userId" name="userId" type="hidden"/></td>
                    </tr>
                    <tr>
                        <td>手机号<b>*</b></td>
                        <td><input id="account" name="account" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'手机号不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td>真实姓名</td>
                        <td><input id="realName" name="realName" class="layui-input easyui-validatebox" type="text"
                                   ></input></td>
                    </tr>
                     <tr>
                       <td>身份证</td>
                        <td><input id="idCard" name="idCard" class="layui-input easyui-validatebox" type="text"
                                   ></input></td>
                     </tr>
                     <tr>
                       <td>邮箱</td>
                        <td><input id="email" name="email" class="layui-input easyui-validatebox" type="email"></input></td>
                     </tr>
                     <tr>
                        <td>性别</td>
                       <td ><select id="gender" class="easyui-combobox" name="gender" panelHeight="70" 
                       style="width: 175px;height: 38px;border-radius: 3px;border-color: #ffa8a8;background-color: #fff3f3"data-options="editable:false">
							<option value="1">男</option>
							<option value="0">女</option>
							<option value="2">未知</option>
							</select>
						</td>
                     </tr>
                     <tr>
                       <td>用户昵称</td>
                        <td><input id="name" name="name" class="layui-input easyui-validatebox" type="text"
                                  ></input></td>                                  
                    </tr>
                     <tr>
                       <td>区县名称</td>
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
                      <td>地址</td>
                        <td><input id="address" name="address" class="layui-input easyui-validatebox" type="text"
                                 ></input></td>
                     </tr>
                     <tr>
                             <td>头像Url</td>  
                            <td>
                             <input type="file" id="file" name="file"  placeholder="上传图片">	                            
                            <button type="button" class="btn btn-primary" onclick="submitImg()">上传</button>                    
							<input type="hidden" class="form-control" id="imgUrl" name="imgUrl">
							<img src="" style="height:120px;display: none;" class="imgPre" id="image"/>
                            </td> 
                     </tr>
                </table>
            </fieldset>
        </form>
    </div>
</div>

<div id="dialog_buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitForm();">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#userDialog').dialog('close');">关闭</a>
</div>
    
</blockquote>  -->

<script type="text/javascript">
$(function(){
	getUserPersonInfoDialog();
});	
function submitForm(){
	var provinceId = $("#provinceId").combobox('getText');
	var cityId = $("#cityId").combobox('getText');
	var countyId = $("#countyId").combobox('getText');
	var area = provinceId+"-"+cityId+"-"+countyId;		    	 
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
	/*  if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(account))){
		$.messager.alert('提示',"输入手机号码有误，请重新输入！",'warning');
		 return ;
	 };
	 if(idCard!=""){
		 if(!(/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/.test(idCard))){
			 $.messager.alert('提示',"身份证号码输入有误，请重新输入！",'warning');
			 return ;
		 }
	 }else if(email!=""){
		 if(!(/^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/ .test(email))){
			 $.messager.alert('提示',"邮箱输入有误，请重新输入！",'warning');
			 return ;
		 };
	 }  */
	 $.ajax({
		url:'${ctx}/user/updateUser',
		type:"POST",
		data:JSON.stringify({
			  'userId':$('#userId').val(),
			  'account':$('#account').val(),
			  'name':$('#name').val(),
			  'realName':$('#realName').val(),
			  'idCard':$('#idCard').val(),
			  'email':$('#email').val(),
			  'gender':$('#gender').combobox('getValue'),
			  'area':area,
			  'address':$('#address').val(),
			  'headUrl':headUrl,
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
			//alert("刷新");
			 parent.location.reload();
		},error:function(data){
			$.messager.alert('提示',data.msg,'error');
			hideLoading();
		}
	  }); 
     }
	function getUserPersonInfoDialog(){		    
		    	    showLoading();
		    		$.ajax({
		    			url:'${ctx}/user/getUserByAccount',
		    			type:"POST",
		    			data:{'account':'${account}'},
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
		  }
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
    //***********************************************************************************************//
    //********************************************** 华丽分割线 ***************************************//
    //***********************************************************************************************//    
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
   function closeFunction(){
	  // alert("刷新");
	   parent.location.reload();
   }
 
</script>
	</body>
</html>