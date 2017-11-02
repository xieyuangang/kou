layui.use(['jquery', 'layer', 'form'], function () {
    'use strict';
    var $ = layui.jquery, layer = layui.layer, form = layui.form();    
    $(window).on('resize', function () {
        var w = $(window).width();
        var h = $(window).height();
        $('.larry-canvas').width(w).height(h)
    }).resize();
    $(function () {
        $("#canvas").jParticle({background: "#141414", color: "#E5E5E5"})
    })
});
