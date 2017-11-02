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
 <blockquote class="layui-elem-quote news_search" style="width: 96.5%;"></blockquote>
 <div id="passworwDialog" style="width:30%;">
   <div class="layui-form-item">
		    <label class="layui-form-label">原始密码</label>
		    <div class="layui-input-block">
		    	<input type="password" placeholder="原始密码" id="password" name="password" class="layui-input">
		    </div>
		</div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">新密码</label>
		    <div class="layui-input-block">
		    	<input type="password" placeholder="新密码"  id="newPassword"  name="newPassword" class="layui-input">
		    </div>
		</div>
		 <div class="layui-form-item">
		    <label class="layui-form-label">确认密码</label>
		    <div class="layui-input-block">
		    	<input type="password" placeholder="确认密码" id="surePassword" name="surePassword" class="layui-input">
		    </div>
		</div>
		
			<div class="layui-form-item">
		    <div class="layui-input-block" id="dialog_buttons">
		    	<button class="layui-btn" onclick="submitForm();">确认</button>
				<button class="layui-btn layui-btn-primary" onclick="closeFunction();">关闭</button>
		    </div>
		</div>
	</div>	
          
    <!-- <div id="passworwDialog" title="修改密码" class="easyui-dialog" closed="false" style="width:240px;height:240px;padding:10px"
     data-options="iconCls:'icon-save',modal:true" buttons="#dialog_buttons">
    <div class="tab">
         <form action=""  method = 'post'>
          <fieldset style="width:160px;height:80px;">
	        <div class="layui-user-icon larry-login">
	            <input type="password" placeholder="原始密码" id="password" name="password" class="login_txtbx word"/>
	        </div>
	        <div class="layui-pwd-icon larry-login">
	            <input type="password" placeholder="新密码"  id="newPassword"  name="newPassword" class="login_txtbx word"/>
	        </div>
	        <div class="layui-user-icon larry-login">
	            <input type="password" placeholder="确认密码" id="surePassword" name="surePassword" class="login_txtbx word"/>
	        </div>
	        
	        </fieldset>
         </form>
      </div>
   </div>
	
	<div id="dialog_buttons">
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitForm();">确认</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
	       onclick="$('#passworwDialog').dialog('close');">关闭</a>
	</div>  -->
    


<script type="text/javascript">		
		    function submitForm(){
		    	var password = $("#password").val();
		    	var newPassword = $("#newPassword").val();
		    	var surePassword = $("#surePassword").val();
		    	var account = '${account}';
		    	if(password==""||newPassword==""||surePassword==""){
		    		$.messager.alert('提示',"原始密码、新密码、确认密码不一致!",'info');
		    		return;	
		    	}
		    	if(!(newPassword.length>=6&&newPassword.length<=12)){
		    		$.messager.alert('提示',"密码长度大等于6，小等于12!",'info');
		    		return;
		    	}
		    	if(newPassword!=surePassword){
		    		$.messager.alert('提示',"新密码和确认密码不一致!",'info');
		    		return;	
		    	}		    	
		    	 $.ajax({
					url:'${ctx}/user/updatePasswordByAccount',
					type:"POST",
					data:JSON.stringify({
						  'account':account,
						  'password':password,
						  'newPassword':newPassword,
					}),
					dataType:"json",
					headers: { 'Content-Type': 'application/json;charset=UTF-8'},
					async: false,
					success:function(data){
						$.messager.alert('提示',data.msg,'info');
						alert(data.code);
						alert(data.code=="0000");
						if(data.code=="0000"){
							parent.location.reload();
						}
					},error:function(data){
						$.messager.alert('提示',data.msg,'error');
						hideLoading();
					}
				}); 
	        }
		    
		   function closeFunction(){
			   //alert("刷新");
			   parent.location.reload();
		   }
		   
    //***********************************************************************************************//
    //********************************************** 华丽分割线 ***************************************//
    //***********************************************************************************************//    
  
 
</script>
	</body>
</html>