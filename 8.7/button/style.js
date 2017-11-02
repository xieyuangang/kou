$(function () {
    var url = '/cigarette';
    var machine_code = '000000';
    var date = JSON.stringify({'machine_code': machine_code});
    $.ajax({
        url: url + '/consumer/getPorts',
        type: 'post',
        data: date,
        dataType: "json",
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        async: false,
        success: function (data) {
            //console.log(data);
            var cla = '';
            for (var i = 0; i < data.result.length; i++) {

                var app = data.result[i].port_status;
                var ppts=data.result[i].statusStr;
                cla += "<button att=" + app + " exception="+ppts+"><b>" + data.result[i].port + "</b>:号通道<br/><span>请点击取烟</span></button>"
            }
            $(".navs").empty().append(cla);
        },
        error: function (data) {
            alert("服务器繁忙");
            console.log(data)
        }
    });


    $('.navs').find("button").each(function () {

        var apps = $(this).attr("att");
        var appst = $(this).attr("exception");
        var ben = $(this);
        if (apps == '5') {
            // clsts(appst,ben);
            $(this).css({background: "#eee", color: "#999"});
            $(this).find("span").html(appst)
        } else if (apps == '3') {
            // clsts(appst,ben);
            $(this).css({background: "#eee", color: "#999"});
            $(this).find("span").html(appst)
            
        } else {
            clst(ben)
        }
    });
});

function clst(ben) {
    ben.click(function () {

        var phone = $(".text").val();

        var port = $(this).find("b").html();

        if (!(/^1[3,4,5,7,8]\d{9}$/.test(phone))) {
            alert("手机号码不正确重新输入");
            return false;
        }
        $(".zhaun").show();
        var date = JSON.stringify({'machine_code': machine_code, 'phone': phone, 'port': port});
        console.log(date);
        $.ajax({
            url: url + '/consumer/getCigarette',
            type: 'post',
            data: date,
            dataType: "json",
            headers: {'Content-Type': 'application/json;charset=UTF-8'},
            async: true,
            success: function (data) {

                if (data.code == "0000") {
                    alert("领取成功\r\n" + port + "号通道正在出烟");
                    $(".zhaun").hide();

                } else {
                    alert(data.msg);
                    $(".zhaun").hide();
                }
            },
            error: function (data) {
                alert("服务器繁忙");
                console.log(data);
                $(".zhaun").hide();
            }
        })
    })
}






