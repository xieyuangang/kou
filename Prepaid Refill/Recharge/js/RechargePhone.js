$(function () {
    //苹果弹框兼容
    window.alert = function (name) {
        var iframe = document.createElement("IFRAME");
        iframe.style.display = "none";
        iframe.setAttribute("src", 'data:text/plain,');
        document.documentElement.appendChild(iframe);
        window.frames[0].window.alert(name);
        iframe.parentNode.removeChild(iframe);
    };
    //获取
    var memberIdL = window.location.href;
    var href_part = memberIdL.split('?');
    var hours = href_part[1].split("=")[1];
    var hoursH = href_part[1].split("=")[2];
	
    //var  hours='bwgzydVRnlfJjGmJ';
    //var  hoursH='18261573278';
    // console.log(hoursH);
    //console.log(hours);
      if(hoursH==undefined || hours==undefined){
          alert("暂时无法充值");
          return false;
      }
    var ListM;
    var BaseURL = 'http://125.69.76.146:12002/server/wsq';
    $("#Close").click(function () {
        $(".Mask").hide();
    });
    $("#InputBox").blur(function () {
		   var timer = null;
        var destNo = $("#InputBox").val();
        var MobileNumber = /^(134|135|136|137|138|139|150|151|152|157|158|159|182|183|184|187|188)[0-9]{8}$/;
        var UnicomNumber = /^(130|131|132|145|155|156|185|186)[0-9]{8}$/;
        var telecomNumber = /^(133|153|180|181|189)[0-9]{8}$/;
        $(".yin").html(destNo);

        if (destNo.length == "") {
            timer =  setInterval(function(){
                alert("请输入手机号码");
                clearInterval(timer);
            },510);
            return false;
        } else if (destNo.length != 11) {
            alert("手机号码不正确，请重新输入");
            $("#InputBox").val("");
            return false;
        }
        if (MobileNumber.test(destNo)) {
            $(".move").html('中国移动');
        } else if (UnicomNumber.test(destNo)) {
            $(".move").html('中国联通');
        } else if (telecomNumber.test(destNo)) {
            console.log("这是一个电信号码");
            $(".move").html('中国电信');
        }
        var destNo = $("#InputBox").val();
        //var date=JSON.stringify({"queryType":queryType,"destNo":destNo});
        var queryType = '1';
        var date = {queryType: queryType, destNo: destNo};
         //console.log(date);
        $.ajax({
            url: BaseURL + "/queryPhoneInfo",
            type: 'post',
            data: date,
            dataType: "jsonp",
            jsonpCallback: "success_jsonpCallback",
            contentType: 'application/jsonp;charset=utf-8',
            success: function (data) {	//成功回调函数
                //console.log(data);
                var Cycle = "";
                var list = "";
                Cycle += "<span><b>" + data.body.province + "</b>省<b>" + data.body.city + "</b>市</span><span>" + data.body.userName + "</span>";
                $(".address").empty().append(Cycle);
                if (data.body.code == 0) {
                    alert(data.body.msg)
                } else {
                    ListM = data.body.operators;
                    if (data.body.listAmt && data.body.listAmt.length > 0) {
                        for (var i = 0; i <= data.body.listAmt.length - 1; i++) {
                            list += "<li class='liston'><span class='text'>" + data.body.listAmt[i] + "元</span><span>售价<b class='vmoney'>" + data.body.listAmt[i] + "</b> 元</span></li>";
                        }
                        $(".list").empty().append(list);
                    }
                }
            },
            error: function (data) {	//失败回调函数
                alert(data.body.msg)
            }
        });
        return false;
    });
    $(".list").unbind().on("click", ".liston", function () {
        $(".Mask").show();
        var destNo = $("#InputBox").val();
        var vmoney = $(this).find(".vmoney").html();
        $(".Mmoney b").html(vmoney);
        $(".Mnumber").html(destNo);
        $(".MOperate").html(ListM);
    });

    $(".Button").click(function () {
        $(".Mask").hide();
        PwdBox.init('123456', 'img/pwd_keyboard.png', '请输入支付密码', '安全支付环境，请放心使用！');
        PwdBox.show(function (res) {
            //console.log(password);

            //alert(JSON.stringify(arguments));
            var password = arguments[0].password;
            $(".password-box").hide();
            var mobileNo = hoursH;
            //var mobileNo = "18608009015";
            //var memberId = "29c00f6dcfe1d729a6c02b16b444ad0b18608009015";
            var memberId = hours;
            var password = password;
            var destNo = $(".yin").html();
            var chargeType = '1';
            var productType = '0';
            var productSize = $(".Mmoney b").html();
            var date = {
                mobileNo: mobileNo,
                memberId: memberId,
                password: password,
                destNo: destNo,
                chargeType: chargeType,
                productType: productType,
                productSize: productSize
            };
            console.log(date);
            $.ajax({
                url: BaseURL + "/charge",
                type: 'post',
                data: date,
                dataType: "jsonp",
                jsonp: "callback",
                jsonpCallback: 'success_jsonpCallback',
                contentType: 'application/jsonp;charset=utf-8',
                success: function (data) {
                    $(".Mask").hide();
                    if (data.body.code == 1) {
                        alert(data.body.msg);
                        //window.location.href = "./RechargeRecord.html";
                    } else {
                        alert(data.body.msg);
                        //window.location.href = "./RechargeRecord.html";
                    }
                    //console.log(data);
                },
                error: function (data) {
                    alert(data.body.msg)
                }
            })
         /*   if (res.status) {
                // alert('密码正确');
                // PwdBox.reset();
                $(".password-box").hide();
            } else {
            }*/
        });
    })
});