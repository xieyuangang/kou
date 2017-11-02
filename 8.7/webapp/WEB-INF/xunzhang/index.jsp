<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../pages/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=320,maximum-scale=1.3,user-scalable=no">
    <title>抽奖</title>
    <style type="text/css">
        body , html ,section{ width: 100%;height: 100%;padding: 0;margin: 0;}
        section{ background: #ffe368;}
        .headerImg{ display: block;}
        .contentBox{ width: 230px;height: 200px;background: url('${ctx}/images/draw_icon_4.png') no-repeat;background-size: 100% 100%;margin: auto;margin-top: 15px;display: table;}
        .cell{ display: table-cell;vertical-align: middle;text-align: center;}
        .cell img{ display: block;width: 72px;margin: auto;}
        .prompt{ font-size: 14px;color: #ff5250;margin-top: 25px;}
        .btn{ width: 210px;height: 44px;background: url('${ctx}/images/draw_icon_3.png') no-repeat;background-size: 100% 100%;border: none;display: block;margin: auto;margin-top: 33px;outline: none;}
    </style>
</head>
<body>
    <section>
        <img src="${ctx }/images/draw_icon_1.png" width="100%" class="headerImg"/>
        <div class="contentBox">
            <div class="cell">
                <img src="${ctx }/images/draw_icon_2.png" />
                <div class="prompt">恭喜您，获得${scoreNum }枚！</div>
            </div>
        </div>
        <input type="button" class="btn" onclick="javascript:location.href='${ctx}/medal/integralPage?memberId=${memberId}'"/>
    </section>
</body>
</html>