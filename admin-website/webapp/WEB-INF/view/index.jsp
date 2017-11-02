<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../page/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理模板</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta name="viewport"content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="${ctx}/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${ctx}/css/main.css" media="all" />
<link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/font_eolqem241z66flxr.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/js/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/leftNav.js"></script>
<script type="text/javascript" src="${ctx}/js/index.js"></script>
<script type="text/javascript" src="${ctx}/js/bodyTab.js"></script>
<style>
    .layui-side::-webkit-scrollbar{width:1px;}
 </style>
</head>
<body>
	<div class="layui-layout layui-layout-admin">
    <!-- 顶部 -->
    <div class="layui-header">
        <div class="layui-main">
            <a href="#" class="logo">红码后台管理系统</a>
           
            <!-- 顶部右侧菜单 -->
            <ul class="layui-nav top_menu">
                <li class="layui-nav-item showNotice" id="showNotice" pc>
                    <a href="javascript:;"><i class="iconfont icon-gonggao"></i><cite>系统公告</cite></a>
                </li>
                <li class="layui-nav-item" mobile>
                    <a href="javascript:;" data-url="page/user/changePwd.html"><i class="iconfont icon-shezhi1"
                                                                                  data-icon="icon-shezhi1"></i><cite>设置</cite></a>
                </li>
                <li class="layui-nav-item" mobile>
                    <a  href="javascript:;"><i class="iconfont icon-loginout"></i> 退出</a>
                </li>
                <li class="layui-nav-item lockcms" pc>
                    <a href="javascript:;"><i class="iconfont icon-lock1"></i><cite>锁屏</cite></a>
                </li>
                <li class="layui-nav-item" pc>
                    <a href="javascript:;"> 
                        <cite>${username}</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="kede('${ctx}/user/toUserPersonInfoPage?account=${username}')"><i class="iconfont icon-zhanghu"                                                             data-icon="icon-zhanghu"></i><cite>个人资料</cite></a>
                        </dd>
                        <dd><a href="javascript:;" onclick="kede('${ctx}/user/toUpdatePasswordPage?account=${username}')"><i class="iconfont icon-shezhi1"
                                                                                          data-icon="icon-shezhi1"></i><cite>修改密码</cite></a>
                        </dd>
                        <dd class="Sign"><a href="${ctx}/test/logout" target="_parent"><i class="iconfont icon-loginout"></i><cite>退出</cite></a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    
    <!-- 左侧导航 -->
    <div class="layui-side layui-bg-black">
        <div class="user-photo">
            <a class="img" title="我的头像"><img src='${headUrl}'></a>
            <p>你好！<span class="userName">${username}</span>, 欢迎登录</p>
        </div>
        <div class="navBar">
            <ul class="layui-nav layui-nav-tree" lay-filter="demo">
            
               <li class="layui-nav-item">
                    <a href="javascript:;" id="shou1">首页</a>
                </li>
 
            	<shiro:hasPermission name="merchant:view">
                	<li class="layui-nav-item">
                    	<a href="javascript:;">零售户管理</a>
                    	<dl class="layui-nav-child">
            				<shiro:hasPermission name="merchant:view">
                        		<dd><a href="javascript:;" onclick="kede('${ctx}/store/toMerchantInfoPage')">零售户信息</a></dd>
            				</shiro:hasPermission>
            				<shiro:hasPermission name="merchant:update">
                        		<dd><a href="javascript:;" onclick="kede('${ctx}/store/toUserAuthInfoPage?account=${username}')" >零售户实名认证</a></dd>
                        	</shiro:hasPermission>
                        	<shiro:hasPermission name="merchant:batch">
                        		<dd><a href="javascript:;" onclick="kede('${ctx}/task/toTaskPage?account=${username}')">批量导入</a></dd>
                        	</shiro:hasPermission>
                        	<shiro:hasPermission name="merchant:img">
                        		<dd><a href="javascript:;" onclick="kede('${ctx}/img/toImgPage')" >上传图片</a></dd>
                        	</shiro:hasPermission>
                   		</dl>
                	</li>
                </shiro:hasPermission>
                <shiro:hasPermission name="shop:view">
                	<li class="layui-nav-item">
	                    <a href="javascript:;">店铺管理</a>
	                    <dl class="layui-nav-child layui-nav-child">
	                        <dd><a href="javascript:;" onclick="kede('${ctx}/store/toShopInfoPage')">店铺信息</a></dd>
	                        <dd><a href="javascript:;" onclick="kede('${ctx}/store/toShopAuthInfoPage')">店铺资质</a></dd>
	                    </dl>
	                </li>
                </shiro:hasPermission>
                <shiro:hasPermission name="goods:view">
                <li class="layui-nav-item">
                    <a href="javascript:;">商品管理</a>
                    <dl class="layui-nav-child layui-nav-child">
	                    <shiro:hasPermission name="goods:info">
	                        <dd><a href="javascript:;" onclick="kede('${ctx}/actGoods/toactGoodsPage')">平台商品管理</a></dd>
	                    </shiro:hasPermission>
						<shiro:hasPermission name="goods:conf">
							<dd><a href="javascript:;" onclick="kede('${ctx}/shopRefGoods/toShopRefGoodsPage')">商户商品配置</a></dd>
						</shiro:hasPermission>
					</dl>
                </li>
                </shiro:hasPermission>
                <li class="layui-nav-item">
                    <a href="javascript:;">活动管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="kede('${ctx}/store/toWinningPage')">中奖记录查询</a></dd>
                    </dl>
                </li>
                  <li class="layui-nav-item">
                    <a href="javascript:;" onclick="kede('${ctx}/store/toOrderPage')">交易记录查询</a>
                   
                </li>
               <shiro:hasPermission name="sys:finance:view">
                <li class="layui-nav-item">
                    <a href="javascript:;">财务管理</a>
                    <dl class="layui-nav-child">
                       <shiro:hasPermission name="sys:dayCheck:view"> 
                        <dd><a href="javascript:;"onclick="kede('${ctx}/shopDayBills/toShopDayBillsPage')">日常对账</a></dd>
                       </shiro:hasPermission>
                       <shiro:hasPermission name="sys:activityCheck:view">
                        <dd><a href="javascript:;" onclick="kede('${ctx}/activityDayBills/toActivityDayBillsPage')">活动对账</a></dd>
                       </shiro:hasPermission> 
                    </dl>
                </li>
                </shiro:hasPermission>
                <shiro:hasPermission name="message:view">
                <li class="layui-nav-item">
                    <a href="javascript:;">奖品管理</a>
                    <dl class="layui-nav-child">
								<shiro:hasPermission name="message:send">
									<dd><a href="javascript:;" onclick="kede('${ctx}/award/toAwardPage')">平台奖品管理</a></dd>
								</shiro:hasPermission>
								<%-- <shiro:hasPermission name="message:audit">
									<dd><a href="javascript:;" onclick="kede('${ctx}/awardAreaStock/toAwardAreaStockPage')">区域库存管理</a></dd>
								</shiro:hasPermission>
								<shiro:hasPermission name="message:search">
									<dd><a href="javascript:;" onclick="kede('${ctx}/awardShopStock/toAwardShopStockPage')">店铺库存管理</a></dd>
								</shiro:hasPermission> --%>
							</dl>
						</li> 
                </shiro:hasPermission> 
                <shiro:hasPermission name="sys:sys:view">
                <li class="layui-nav-item">
                    <a href="javascript:;">系统管理</a>
                    <dl class="layui-nav-child">
                        <shiro:hasPermission name="sys:user:view"> 
                         <dd><a href="javascript:;" onclick="kede('${ctx}/user/toUserPage')">用户管理</a></dd>
                          </shiro:hasPermission>
                          <shiro:hasPermission name="sys:role:view">
                         <dd><a href="javascript:;" onclick="kede('${ctx}/role/toRolePage')">角色管理</a></dd>
                         </shiro:hasPermission>
                         <shiro:hasPermission name="sys:menu:view">
                         <dd><a href="javascript:;" onclick="kede('${ctx}/menu/toMenuPage')">菜单管理</a></dd>
                         </shiro:hasPermission>
                    </dl>
                </li> 
                </shiro:hasPermission>
                <shiro:hasPermission name="message:view">
                <li class="layui-nav-item">
                    <a href="javascript:;">消息中心</a>
                    <dl class="layui-nav-child">
								<shiro:hasPermission name="message:send">
									<dd><a href="javascript:;" onclick="kede('${ctx}/send/toSmsSendPage')">消息发送</a></dd>
								</shiro:hasPermission>
								<shiro:hasPermission name="message:audit">
									<dd><a href="javascript:;" onclick="kede('${ctx}/audit/toSmsAuditPage')">消息审核</a></dd>
								</shiro:hasPermission>
								<shiro:hasPermission name="message:search">
									<dd><a href="javascript:;" onclick="kede('${ctx}/sms/toSmsInfoPage')">消息查询</a></dd>
								</shiro:hasPermission>
							</dl>
						</li> 
                </shiro:hasPermission>
                <shiro:hasPermission name="sys:sys:view">
                <li class="layui-nav-item">
                    <a href="javascript:;">手机订烟</a>
                    <dl class="layui-nav-child">
                    <shiro:hasPermission name="sys:retailer:view">
                        <dd><a href="javascript:;" onclick="kede('${ctx}/retailer/toRetailerPage')">零售户管理</a></dd>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="sys:yxtcorder:view">
                        <dd><a href="javascript:;" onclick="kede('${ctx}/yxtcorder/toYxtcOrderPage')">订单查询</a></dd>
                        </shiro:hasPermission>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">烟草信使</a>
                    <dl class="layui-nav-child">
                    <shiro:hasPermission name="sys:ycxsorder:view">
                     <dd><a href="javascript:;" onclick="kede('${ctx}/ycxsorder/toYcxsOrderPage')">发送统计</a></dd>
                    </shiro:hasPermission>
                    </dl>
                </li>
                 </shiro:hasPermission>
            </ul>
        </div>
    </div>
    <!-- 右侧内容 -->
    <div class="layui-body layui-form">
        <div class="layui-tab marg0">
            <div class="layui-tab-content  clildFrame">
                <div class="layui-tab-item" style="display: block;">
		 <div class="childrenBody"  id="shou">
				<blockquote class="layui-elem-quote news_search" style="width: 96.5%;height:20px;">
				      <p><span style="float:right;"><b id="nowTime"></b> <b id="xin"></b></span>	</p>	
				</blockquote>
				 
				<div class="panel_box row">
				    <div class="panel col" style="width: 32.666%;">
				        <a href="javascript:;" onclick="kede('${ctx}/store/toUserAuthInfoPage?account=${username}')">
				            <div class="panel_icon">
				                
				                  <i class="iconfont icon-dongtaifensishu" data-icon="icon-dongtaifensishu"></i>
				            </div>
				            <div class="panel_word newMessage">
				                <span class="shopAuthSize"></span>
				                <cite>用户实名审核</cite>
				            </div>
				        </a>
				    </div>
				    <div class="panel col" style="width: 32.666%;">
				        <a href="javascript:;" onclick="kede('${ctx}/store/toShopAuthInfoPage')">
				            <div class="panel_icon" style="background-color:#FF5722;">
				              <i class="layui-icon">&#xe600;</i>
				            </div>
				            <div class="panel_word userAll">
				                <span class="userAuthSize"></span>
				                <cite>店铺审核</cite>
				            </div>
				        </a>
				    </div>
				    <div class="panel col" style="width: 32.666%;">
				        <a href="javascript:;">
				            <div class="panel_icon" style="background-color:#009688;">
				                 <i class="iconfont icon-dongtaifensishu" data-icon="icon-dongtaifensishu"></i>
				            </div>
				            <div class="panel_word userAll">
				                <span>0</span>
				                <cite>用户强制换卡申请</cite>
				            </div>
				        </a>
				    </div>
				</div>
				<script>
				    layui.use('element', function(){});
				</script>
				<script>
				  $(function(){
					  function current(){
						  var p=new Date(),str='';
						  str +=p.getFullYear()+"年";
						  str +=p.getMonth()+1+"月";
						  str +=p.getDate()+"日 ";
						  return str;}
					  var p=new Date();
					  var today = new Array('星期日','星期一','星期二','星期三','星期四','星期五','星期六');
					  var week = today[p.getDay()];
					  setInterval(function(){$("#nowTime").html(current); $("#xin").html(week)},1000);
				  })
				
				</script>
				</div>
                
                
                    <iframe  style="display:none;margin-top:28px;"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部 -->
    <div class="layui-footer footer">
        <p>红码后台管理系统</p>
    </div>
</div>
<!-- 锁屏 -->
<div class="admin-header-lock" id="lock-box" style="display: none;">
    <div class="admin-header-lock-img"><img src="${ctx}/images/face.jpg"/></div>
    <div class="admin-header-lock-name" id="lockUserName">XXX</div>
    <div class="input_btn">
        <input type="password" class="admin-header-lock-input layui-input" placeholder="请输入密码解锁.." name="lockPwd"
               id="lockPwd"/>
        <button class="layui-btn" id="unlock">解锁</button>
    </div>
    <!--<p>请输入“123456”，否则不会解锁成功哦！！！</p>-->
</div>

<script>
    layui.use(['jquery'], function () {
        var $ = layui.jquery;

        $.ajax({
        	url:'${ctx}/store/getNews',
        	success: function (data) {
        		
             		var shen=JSON.parse(data);
             		
        		$(".shopAuthSize").html(shen.shopAuthSize)
        		$(".userAuthSize").html(shen.userAuthSize)
    
             }, error: function (data) {
	 
                 alert(data)
             }
        })

    });
    $("#shou1").click(function(){
    	$("iframe").hide()
        $("#shou").show();
    })
    
    function kede(obj) {
    	$("#shou").hide();
        $("iframe").show();
        $("iframe").prop("src", obj);
    }
    
</script>
</body>
</html>