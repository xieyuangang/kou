define(function(require, exports, module) {
    exports.init = function(page) {
        var msa="";
        msa+='<header><a href="JavaScript:history.back(-1)" style="text-align: left" data-rel="back">' +
			'<i class="iconfont icon-fanhui" style="color:#fff;"><</i></a>' +
			'<span>中奖纪录</span><a href="javascript:void(0)" style="text-align: right;">完成</a>' +
			'</header>' +
			'<div class="Verification">\n' +
            '       <p><input type="text" placeholder="请输入手机号码" id="phone"></p>\n' +
            '       <p><input type="password" placeholder="请输入验证码">\n' +
            '           <span>\n' +
            '               <b class="btn btn-small get-code" onclick="getCode(this)" id="J_getCode">获取验证码</b>\n' +
            '               <b class="btn btn-small reset-code" id="J_resetCode" style="display:none;"><b id="J_second">60</b>秒后重发</b>\n' +
            '           </span>\n' +
            '       </p>\n' +
            '        <button class="#button">下一步</button>\n' +
            '   </div>';
        page.innerHTML =msa;
    };
});
    var isPhone = 1;
    function getCode(e){
        checkPhone(); //验证手机号码
        if(isPhone){
            resetCode(); //倒计时
        }else{
            $('#phone').focus();
        }
    }
    //验证手机号码
    function checkPhone(){
        var phone = $('#phone').val();
        var pattern = /^1[0-9]{10}$/;
        isPhone = 1;
        if(phone == '') {
            alert('请输入手机号码');
            isPhone = 0;
            return;
        }
        if(!pattern.test(phone)){
            alert('请输入正确的手机号码');
            isPhone = 0;
            return;
        }
    }
    //倒计时
    function resetCode(){
        $('#J_getCode').hide();
        $('#J_second').html('60');
        $('#J_resetCode').show();
        $(".Verification p span").css({background:"#e2e2e2"});
        var second = 60;
        var timer = null;
        timer = setInterval(function(){
            second -= 1;
            if(second >0 ){
                $('#J_second').html(second);
            }else{
                clearInterval(timer);
                $('#J_getCode').show();
                $('#J_resetCode').hide();
                $(".Verification p span").css({background:"red"});
            }
        },1000);
    }