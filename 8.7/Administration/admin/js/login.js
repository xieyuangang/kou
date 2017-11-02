layui.use(['jquery', 'layer', 'form'], function () {
    'use strict';
    var $ = layui.jquery, layer = layui.layer, form = layui.form();
    $(window).on('resize', function () {
        var w = $(window).width();
        var h = $(window).height();
        $('.larry-canvas').width(w).height(h)
    }).resize();
   /* $(".submit_btn").click(function () {
        var nam=$(".nam").val();
        var word=$(".word").val();
        var naml="admin";
        var wordl="123456";
        if(nam==naml || word==wordl){
            location.href="index.html"
        }else {
            layer.msg("密码不正确")
        }
    });*/
    $(function () {
        $("#canvas").jParticle({background: "#141414", color: "#E5E5E5"})
    })
});
