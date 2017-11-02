<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>订烟零售户查询</title>
		<link href="${ctx}/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/icon.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/easyui.css" rel="stylesheet" type="text/css"/>
	    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
	    <link href="${ctx}/css/news.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript" src="${ctx}/layui/laydate/laydate.js"></script>
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
<!-- Modal -->
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<body class="childrenBody" style="width: 99%;box-sizing: border-box">
<blockquote class="layui-elem-quote news_search" style="width: 96.5%;">
    <form action="" class="layui-form layui-form-pane">
       <div class="layui-inline">
            <label class="layui-form-label">省份</label>
            <div class="layui-input-block">
               <!-- <input name="" type="text" maxlength="30" id="" class="layui-input easyui-textbox" style="width:120px;" value=""/>-->
                <select id="province" class=""
					name="province" panelHeight="70" style="width: 175px;"
						data-options="editable:false">
									<option value="四川">四川</option>
									<option value="广西">广西</option>
									<option value="贵州">贵州</option>
									<option value="云南">云南</option>
									<option value="甘肃">甘肃</option>
									<option value="西藏">西藏</option>
									<option value="江西">江西</option>
				</select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">地市</label>
            <div class="layui-input-block">
               <!-- <input name="" type="text" maxlength="30" id="" class="layui-input easyui-textbox" style="width:120px;" value=""/>-->
               <select id="city" class=""
								name="city" panelHeight="70" style="width:185px;"
								data-options="editable:false">
  <option value=11510101>成都烟草分公司</option>
  <option value=11511701>达州烟草分公司</option>
  <option value=11511901>巴中烟草公司</option>
  <option value=11510601>德阳烟草公司</option>
  <option value=11510102>都江堰烟草公司</option>
  <option value=11513301>甘孜州烟草公司</option>
  <option value=11511101>乐山烟草公司</option>
  <option value=11513401>凉山州烟草公司</option>
  <option value=11511401>眉山烟草公司</option>
  <option value=11510701>绵阳烟草公司</option>
  <option value=11511301>南充烟草公司</option>
  <option value=11511001>内江烟草公司</option>
  <option value=11510401>攀枝花烟草公司</option>
  <option value=11511801>雅安烟草公司</option>
  <option value=11512001>资阳烟草公司</option>
  <option value=11513201>阿坝州烟草公司</option>
<option value=11511601>广安烟草公司</option>
<option value=11510501>泸州烟草公司</option>
<option value=11510901>遂宁烟草公司</option>
<option value=11511501>宜宾烟草公司</option>
<option value=11510301>自贡烟草公司</option>
<option value=11510801>广元烟草公司</option>
<option value=11450101>南宁市烟草公司</option>
<option value=11450201>柳州市烟草公司</option>
<option value=11450301>桂林市烟草公司</option>
<option value=11450401>梧州市烟草公司</option>
<option value=11450501>北海市烟草公司</option>
<option value=11450701>钦州市烟草公司</option>
<option value=11450801>贵港市烟草公司</option>
<option value=11450901>玉林市烟草公司</option>
<option value=11451001>百色市烟草公司</option>
<option value=11451101>贺州市烟草公司</option>
<option value=11451201>河池市烟草公司</option>
<option value=11451301>来宾市烟草公司</option>
<option value=11451401>崇左市烟草公司</option>
<option value=11450603>防城港市烟草公司</option>
<option value=11520102>贵阳市公司</option>
<option value=11520201>六盘水分公司</option>
<option value=11520301>遵义市分公司</option>
<option value=11520401>安顺分公司</option>
<option value=11522201>铜仁分公司</option>
<option value=11522301>黔西南分公司</option>
<option value=11522401>毕节分公司</option>
<option value=11522601>黔东南分公司</option>
<option value=11522701>黔南分公</option>
<option value=11530101>昆明市公司</option>
<option value=11530301>曲靖市公司</option>
<option value=11530401>玉溪市公司</option>
<option value=11530501>保山市公司</option>
<option value=11530601>昭通市公司</option>
<option value=11530701>丽江市公司</option>
<option value=11532301>楚雄州公司</option>
<option value=11532501>红河州公司</option>
<option value=11532601>文山州公司</option>
<option value=11532701>普洱市公司</option>
<option value=11532801>西双版纳傣族自治州公司</option>
<option value=11532901>大理州公司</option>
<option value=11533101>德宏州公司</option>
<option value=11533301>怒江州公司</option>
<option value=11533401>迪庆州公司</option>
<option value=11533501>临沧市公司</option>
<option value=11620101>兰州市烟草公司</option>
<option value=11623006>甘肃甘南州迭部县公司</option>
<option value=11623005>甘肃甘南州夏河县公司</option>
<option value=11623002>临潭县营销部</option>
<option value=11623004>卓尼县营销部</option>
<option value=11620901>酒泉市烟草公司</option>
<option value=11620902>敦煌市烟草公司</option>
<option value=11620801>平凉市烟草公司</option>
<option value=11620701>张掖市烟草公司</option>
<option value=11620301>金昌市烟草公司</option>
<option value=11620501>天水市烟草公司</option>
<option value=11620601>武威市烟草公司</option>
<option value=11620401>白银市烟草公司</option>
<option value=11622601>陇南市烟草公司</option>
<option value=11621001>庆阳市烟草公司</option>
<option value=11622401>定西市烟草公司</option>
<option value=11620201>嘉峪关市烟草公司</option>
<option value=11622901>临夏州烟草公司</option>
<option value=11623001>甘南州烟草公司</option>
<option value=11623008>甘肃甘南州碌曲县公司</option>
<option value=11623007>玛曲县营销部</option>
<option value=11623003>舟曲县营销部</option>
<option value=﻿11540100>拉萨市公司</option>
<option value=11542101>昌都地区公司</option>
<option value=11542201>山南地区公司</option>
<option value=11542301>日喀则地区公司</option>
<option value=11542401>那曲地区公司</option>
<option value=11542501>阿里地区公司</option>
<option value=11542601>林芝地区公司</option>
				</select>
              </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">新商盟账号</label>
            <div class="layui-input-block">
                <input name="searchRetailercustId" type="text" maxlength="30" id="searchRetailercustId" class="layui-input easyui-textbox" style="width:120px;" value=""/>
            </div>
        </div> 
        <div class="layui-inline">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
              <select id="statebox" name="statebox" style="width:80px;" class="" data-options="editable:false" >
									<option value=""></option>
									<option value="0">注册</option>
									<option value="1">激活</option>
									<option value="2">停用</option>
									<option value="3">注销</option>
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
       <shiro:hasPermission name="sys:yxtcretailer:update">
	   <div class="layui-inline"  id="toRetailerPage" onclick="javascript:updateUserDialog();" >
        <a class="layui-btn layui-btn-normal batchDel"><i class="layui-icon">&#xe642;</i>修改</a>
       </div>
       </shiro:hasPermission>
       <shiro:hasPermission name="sys:yxtcretailer:add">
       <div class="layui-inline"  id="toRetailerPage" onclick="javascript:addUserDialog();" >
        <a class="layui-btn layui-btn batchDel"><i class="layui-icon">&#xe61f;</i>新增</a>
       </div>
       </shiro:hasPermission>
       <shiro:hasPermission name="sys:yxtcretailer:delete">
       <div class="layui-inline"  id="toRetailerPage" onclick="javascript:deleteretailer();" >
        <a class="layui-btn layui-btn batchDel"><i class="layui-icon">&#xe63f;</i>删除</a>
       </div>
       </shiro:hasPermission>
       <shiro:hasPermission name="sys:yxtcretailer:delete">
        <div class="layui-inline"  id="toRetailerPage" onclick="javascript:search();" >
        <a class="layui-btn layui-btn-primary batchDel"><i class="layui-icon">&#xe615;</i>查询</a>
       </div>
       </shiro:hasPermission> 	
    </form>
</blockquote>
 <!-- dialog -->
<div id="userDialog" title="编辑信息菜单" class="easyui-dialog" closed="true" style="width:420px;height:420px;padding:10px;"
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
                        <td>新商盟账号<b>*</b></td>
                        <td><input id="custid" name="custid" class="layui-input easyui-validatebox" type="text"
                                   data-options="required:true,missingMessage:'新商盟账号不能为空!'"></input></td>
                    </tr>
                    <tr>
                        <td>手机号<b>*</b></td>
                        <td><input id="cell" name="cell" class="layui-input easyui-validatebox"
                                   data-options="required:true,missingMessage:'手机号不能为空!'"></input></td>
                    </tr>
                     <tr>
                        <td>运营商<b>*</b></td>
                        <td><select id="oper" name="oper" style="width:80px;" class="easyui-combobox" data-options="required:true,editable:false" >
									<option value="0">移动</option>
									<option value="1">联通</option>
									<option value="2">电信</option>
			              </select>
			             </td>
                    </tr>
                     <tr>
                        <td>姓名</td>
                        <td><input id="realName" name="realName" class="layui-input easyui-validatebox" type="text"></input></td>
                     </tr>
                    <tr>
                        <td>状态</td>
                         <td><select id="statebox1" name="statebox1" style="width:80px;" class="easyui-combobox" data-options="editable:false" >
									<option value="0">注册</option>
									<option value="1">激活</option>
									<option value="2">停用</option>
									<option value="3">注销</option>
			               </select>
			               </td>
			           </tr>
                   </div>
                    </div>
                     <tr>
                       <td>省市</td>
                       <td><input id="area" name="area" type="hidden"/></td>
                        <table id="areaTable" border="0">
							<tr>
								<td>省：</td>
								<td>
									<select id="provinceId" name="provinceId" style="width:80px;" class="easyui-combobox" data-options="editable:false" >
									<option value="四川">四川</option>
									<option value="广西">广西</option>
									<option value="贵州">贵州</option>
									<option value="云南">云南</option>
									<option value="甘肃">甘肃</option>
									<option value="西藏">西藏</option>
									<option value="江西">江西</option>
									</select>
								</td>
								<td>市：</td>
								<td>
									<select id="cityId" name="cityId" style="width:125px;" class="easyui-combobox" data-options="editable:false" >
									<option value=11510101>成都烟草分公司</option>
<option value=11511701>达州烟草分公司</option>
<option value=11511901>巴中烟草公司</option>
<option value=11510601>德阳烟草公司</option>
<option value=11510102>都江堰烟草公司</option>
<option value=11513301>甘孜州烟草公司</option>
<option value=11511101>乐山烟草公司</option>
<option value=11513401>凉山州烟草公司</option>
<option value=11511401>眉山烟草公司</option>
<option value=11510701>绵阳烟草公司</option>
<option value=11511301>南充烟草公司</option>
<option value=11511001>内江烟草公司</option>
<option value=11510401>攀枝花烟草公司</option>
<option value=11511801>雅安烟草公司</option>
<option value=11512001>资阳烟草公司</option>
<option value=11513201>阿坝州烟草公司</option>
<option value=11511601>广安烟草公司</option>
<option value=11510501>泸州烟草公司</option>
<option value=11510901>遂宁烟草公司</option>
<option value=11511501>宜宾烟草公司</option>
<option value=11510301>自贡烟草公司</option>
<option value=11510801>广元烟草公司</option>
<option value=11450101>南宁市烟草公司</option>
<option value=11450201>柳州市烟草公司</option>
<option value=11450301>桂林市烟草公司</option>
<option value=11450401>梧州市烟草公司</option>
<option value=11450501>北海市烟草公司</option>
<option value=11450701>钦州市烟草公司</option>
<option value=11450801>贵港市烟草公司</option>
<option value=11450901>玉林市烟草公司</option>
<option value=11451001>百色市烟草公司</option>
<option value=11451101>贺州市烟草公司</option>
<option value=11451201>河池市烟草公司</option>
<option value=11451301>来宾市烟草公司</option>
<option value=11451401>崇左市烟草公司</option>
<option value=11450603>防城港市烟草公司</option>
<option value=11520102>贵阳市公司</option>
<option value=11520201>六盘水分公司</option>
<option value=11520301>遵义市分公司</option>
<option value=11520401>安顺分公司</option>
<option value=11522201>铜仁分公司</option>
<option value=11522301>黔西南分公司</option>
<option value=11522401>毕节分公司</option>
<option value=11522601>黔东南分公司</option>
<option value=11522701>黔南分公</option>
<option value=11530101>昆明市公司</option>
<option value=11530301>曲靖市公司</option>
<option value=11530401>玉溪市公司</option>
<option value=11530501>保山市公司</option>
<option value=11530601>昭通市公司</option>
<option value=11530701>丽江市公司</option>
<option value=11532301>楚雄州公司</option>
<option value=11532501>红河州公司</option>
<option value=11532601>文山州公司</option>
<option value=11532701>普洱市公司</option>
<option value=11532801>西双版纳傣族自治州公司</option>
<option value=11532901>大理州公司</option>
<option value=11533101>德宏州公司</option>
<option value=11533301>怒江州公司</option>
<option value=11533401>迪庆州公司</option>
<option value=11533501>临沧市公司</option>
<option value=11620101>兰州市烟草公司</option>
<option value=11623006>甘肃甘南州迭部县公司</option>
<option value=11623005>甘肃甘南州夏河县公司</option>
<option value=11623002>临潭县营销部</option>
<option value=11623004>卓尼县营销部</option>
<option value=11620901>酒泉市烟草公司</option>
<option value=11620902>敦煌市烟草公司</option>
<option value=11620801>平凉市烟草公司</option>
<option value=11620701>张掖市烟草公司</option>
<option value=11620301>金昌市烟草公司</option>
<option value=11620501>天水市烟草公司</option>
<option value=11620601>武威市烟草公司</option>
<option value=11620401>白银市烟草公司</option>
<option value=11622601>陇南市烟草公司</option>
<option value=11621001>庆阳市烟草公司</option>
<option value=11622401>定西市烟草公司</option>
<option value=11620201>嘉峪关市烟草公司</option>
<option value=11622901>临夏州烟草公司</option>
<option value=11623001>甘南州烟草公司</option>
<option value=11623008>甘肃甘南州碌曲县公司</option>
<option value=11623007>玛曲县营销部</option>
<option value=11623003>舟曲县营销部</option>
<option value=﻿11540100>拉萨市公司</option>
<option value=11542101>昌都地区公司</option>
<option value=11542201>山南地区公司</option>
<option value=11542301>日喀则地区公司</option>
<option value=11542401>那曲地区公司</option>
<option value=11542501>阿里地区公司</option>
<option value=11542601>林芝地区公司</option>
									</select>
								</td>
							</tr>
						</table>
                     </tr>
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
     <table id="tt" style="height:452px;"> </table>
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
			 var custid = $('#searchRetailercustId').val();
			 var begindate = $('#begindate').val();
			 var enddate = $('#enddate').val();
			 var state= $('#statebox').val();
				 $('#tt').datagrid({
						url:'${ctx}/retailer/getRetailerPage',
						queryParams:{
							cust_id:custid,
							begindate:begindate,
							enddate:enddate,
							state:state,
			    		},
						pagination: true,
						rownumbers : true,
						fitColumns : true,
						collapsible : true,
						autoRowHeight : true,
						loadMsg : "数据加载中,请稍等...",
						frozenColumns : [[{field : 'ck',checkbox : true}]],
						columns:[[
				             {title:'新商盟账号', field:'cust_id',width:50,align:'center'},
				             {title:'手机号', field:'cell_phone',width:50,align:'center'},
				             {title:'姓名', field:'cust_name',width:50,align:'center'},
				             {title:'运营商', field:'oper_info',width:120,align:'center'},
				             {title:'所属公司', field:'comp_name',width:120,align:'center'},
				             {title:'创建日期', field:'crt_date',width:120,align:'center'},
				             {title:'状态', field:'state',width:120,align:'center',
				            	 formatter:function(value){
				            			var str;
										if(value=='0') {
				                			str = '<font color=#FFA07A>注册</font>';
					            		}else if(value == '1'){
				                			str = '<font color=#FF83FA>激活</font>';
					            		}else if(value == '2'){
				                			str = '<font color=#00BFFF>停用</font>';
					            		}else if(value == '3'){
				                			str = '<font color=#00BFFF>注销</font>';
					            		}
				                		return str;
				            		 }
				             }
						]]
				 });
			}
			function search(){
				initGrid();
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
		    		url = "addRetailer";
		    	else if(flag==='update')
		    		url = "updateRetailer";
		    	$.ajax({
					url:'${ctx}/retailer/'+url,
					type:"POST",
					data:JSON.stringify({
					'cust_id':$('#custid').val(),
					'cell_phone':$('#cell').val(),
					'oper_info':$("#oper").combobox('getValue'),
					'cust_name':$('#realName').val(),
					'org_id':$("#cityId").combobox('getValue'),
					'state':$("#statebox1").combobox('getValue'),
					}),
					dataType:"json",
					headers: {'Content-Type':'application/json;charset=UTF-8'},
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
			    $('#custid').val(chks[0].cust_id);
				$('#cell').val(chks[0].cell_phone);
				$('#realName').val(chks[0].cust_name);
				$('#cityId').val(chks[0].org_id);
				$('#statebox1').val(chks[0].state);
				$('#oper').val(chks[0].oper_info);
    			$('#userDialog').dialog('open');
				$('#tt').datagrid('clearSelections');
		    	hideLoading();	
		    	}else{
		    		$.messager.alert('提示',"请选择一项进行修改!",'info');
		    	}
		    }
		    
		    function deleteretailer(){
		    	var chks = null;
	        	chks = $('#tt').datagrid('getChecked');
	        	if(chks.length<1){
	        		$.messager.alert('提示','请至少选择一项!','info');
	        		return ;
	        	}
	        	var arr = new Array();
	        	for(var c in chks){
	        		arr[c] = chks[c].cust_id;
	        	}
	        	
	        	$.messager.confirm('提示', '确定要删除该项目吗?', function(yes){
	        		if(yes){
	        			showLoading();
	        			$.ajax({
	        				url:'${ctx}/retailer/deleteRetailer',
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