$(document).ready(function () {
    window.alert = function (name) {
        var iframe = document.createElement("IFRAME");
        iframe.style.display = "none";
        iframe.setAttribute("src", 'data:text/plain,');
        document.documentElement.appendChild(iframe);
        window.frames[0].window.alert(name);
        iframe.parentNode.removeChild(iframe);
    };
    var calendar = new lCalendar();
    calendar.init({
        'trigger': '#demo1',
        'type': 'date'
    });
    var myDate = new Date();
//获取当前年
    var year = myDate.getFullYear();
//获取当前月
    var month = myDate.getMonth() + 1;
//获取当前日
    var date = myDate.getDate();
    var now = year + '年' + p(month) + "月" + p(date) + "日";
    $("#demo1").val(now);
});
$(function () {
    var BaseURL = 'http://125.69.76.146:12002/server/wsq';
    //  var  transDate  =$(this).val().replace(/年/,"").replace(/月/,"").replace(/日/,"");
    //获取a标签带过来的值
    var location = window.location.href;
    var href = location + "";
    var href_part = href.split('?');
    var num = (href_part);
    //console.log(num[1]);
    //获取时间
    var myDate = new Date();
    //获取当前年
    var year = myDate.getFullYear();
    //获取当前月
    var month = myDate.getMonth() + 1;
    //获取当前日
    var date = myDate.getDate();
    var now = year + p(month) + p(date);
    //var mobileNo =num[1];
    //var transDate =now;
    var memberId = 'bwgzydVRnlfJjGmJ';
    var transDate = "20171027";
    var date = {transDate: transDate, memberId: memberId};

    var counter = 0;
    // 每页展示4个
    var num = 4;
    var pageStart = 0, pageEnd = 0;
    // dropload
    $('.content').dropload({
        scrollArea: window,
        domUp: {
            domClass: 'dropload-up',
            domRefresh: '<div class="dropload-refresh">↓下拉刷新</div>',
            domUpdate: '<div class="dropload-update">↑释放更新</div>',
            domLoad: '<div class="dropload-load"><span class="loading"></span>加载中...</div>'
        },
        domDown: {
            domClass: 'dropload-down',
            domRefresh: '<div class="dropload-refresh">↑上拉加载更多...</div>',
            domLoad: '<div class="dropload-load"><span class="loadin"></span>加载中...</div>',
            domNoData: '<div class="dropload-noData">加载完成...</div>'
        },
        loadDownFn: function (me) {
            $.ajax({
                url: BaseURL + "/getTransrecords",
                type: 'post',
                data: date,
                dataType: "jsonp",
                jsonpCallback: "success_jsonpCallback",
                contentType: 'application/jsonp;charset=utf-8',
                success: function (data) {

                    var Total = data.body.totalMoney;
                    $("#Total").html(Total);
                    var result = '';
                    counter++;
                    pageEnd = num * counter;
                    pageStart = pageEnd - num;
                    if (data.body.transrecordList.length == '0') {
                        result += '<h3 style="text-align: center;line-height: 60px;">暂无充值记录...</h3>';
                        $('.lists').append(result);
                    } else {
                        for (var i = pageStart; i < pageEnd; i++) {
                            var str = data.body.transrecordList[i].createTime;
                            var time = str.split(" ");
                            var hours = time[1].split(":")[0];
                            var appType = data.body.transrecordList[i].appType;

                            var status = data.body.transrecordList[i].status;

                            result += "<li><div style='width:20% '>";
                            if (hours < 12) {
                                result += "<span class='morning'>上午</span>";
                            } else {
                                result += "<span class='morning'>下午</span>";
                            }
                            result += "<span>" + time[1] + "</span></div><div style='width:25% '>";
                            if (appType == 1000) {
                                result += "<h4>话费充值</h4>";
                            } else {
                                result += "<h4>话费流量</h4>";
                            }
                            result += "</div><div style='width:41% '><span>-" + data.body.transrecordList[i].realAmt + "</span> <span style='font-size: 0.9rem;line-height: 1rem;'>给" + data.body.transrecordList[i].destNo + "充值</span></div> "
                            if (status == 0) {
                                result += "<div style='width: 7%'><span class='Result' style='color:#999;white-space:nowrap'>充值</br>失败</span></div>";
                            } else if (status == 1) {
                                result += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>充值</br>成功</span></div>";
                            } else if (status == 2) {
                                result += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>等待</br>充值</span></div>";
                            }
                            if (status == 3) {
                                result += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>充值</br>中</span></div>";
                            }
                            if (status == 4) {
                                result += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>返销</br>审核中</span></div>";
                            }
                            if (status == 5) {
                                result += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>返销中</span></div>";
                            }
                            if (status == 6) {
                                result += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>返销</br>成功</span></div>";
                            }
                            result += "</li>";

                            if ((i + 1) >= data.body.transrecordList.length) {
                                // 锁定
                                me.lock();
                                // 无数据
                                me.noData();
                                break;
                            }
                        }
                        // 为了测试，延迟1秒加载
                        setTimeout(function () {
                            $('.lists').append(result);
                            // 每次数据加载完，必须重置
                            me.resetload();
                        }, 800);
                    }
                },
                error: function (data) {
                    alert("服务器请求异常");
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        },
        threshold: 50
    });
    /*$.ajax({
        url: BaseURL + "/getTransrecords",
        type: 'post',
        data: date,
        dataType: "jsonp",
        jsonpCallback: "success_jsonpCallback",
        contentType: 'application/jsonp;charset=utf-8',
        success: function (data) {	//成功回调
           console.log(data.body);
             var  Total=data.body.totalMoney;
              $("#Total").html(Total);
            var Cycle = "";
            for (var i = 0; i < data.body.transrecordList.length; i++) {
                var str=data.body.transrecordList[i].createTime;
                var  time=str.split(" ");
                var hours=time[1].split(":")[0];
                var appType=data.body.transrecordList[i].appType;

                var status=data.body.transrecordList[i].status;

                Cycle += "<li><div style='width:20% '>";
                if(hours<12){
                    Cycle+="<span class='morning'>上午</span>" ;
                }else{
                    Cycle+="<span class='morning'>下午</span>" ;
                }
                Cycle+="<span>"+time[1]+"</span></div><div style='width:25% '>";
                if(appType==1000){
                    Cycle+="<h4>话费充值</h4>";
                }else{
                    Cycle+="<h4>话费流量</h4>";
                }
                Cycle+="</div><div style='width:41% '><span>-"+data.body.transrecordList[i].realAmt+"</span> <span style='font-size: 0.9rem;line-height: 1rem;'>给"+data.body.transrecordList[i].destNo+"充值</span></div> "
                 if(status==0){
                     Cycle+="<div style='width: 7%'><span class='Result' style='color:#999'>充值失败</span></div>";
                 }else if(status==1){
                     Cycle+="<div style='width: 7%'><span class='Result' style='color: #55a532'>充值成功</span></div>";
                 }else if(status==2){
                     Cycle+="<div style='width: 7%'><span class='Result' style='color: #55a532'>等待充值</span></div>";
                 }if(status==3){
                    Cycle+="<div style='width: 7%'><span class='Result' style='color: #55a532'>充值中</span></div>";
                }if(status==4){
                    Cycle+="<div style='width: 7%'><span class='Result' style='color: #55a532'>返销审核中</span></div>";
                }if(status==5){
                    Cycle+="<div style='width: 7%'><span class='Result' style='color: #55a532'>返销中</span></div>";
                }if(status==6){
                    Cycle+="<div style='width: 7%'><span class='Result' style='color: #55a532'>返销成功</span></div>";
                }
                Cycle+="</li>"
            }
            $(".calendarList").empty().append(Cycle);
        },
        error: function (data) {	//失败回调函数
            console.log(data);
        }
    });*/
    $('#demo1').bind('input propertychange', function () {
        $(".calendarListY").empty();
        var dateL = $(this).val().replace(/年/, "").replace(/月/, "").replace(/日/, "");
        // console.log(date);
        //var memberId =num[1];
        var memberId = 'bwgzydVRnlfJjGmJ';
        var transDate = dateL;
        var date = {transDate: transDate, memberId: memberId};
        $(".content").hide();
        $(".contentY").show();
      $.ajax({
             url: BaseURL + "/getTransrecords",
             type: 'post',
             data: date,
             dataType: "jsonp",
             jsonpCallback: "success_jsonpCallback",
             contentType: 'application/jsonp;charset=utf-8',
             success: function (data) {	//成功回调函数
                 var Cycle = "";
                 if (data.body.transrecordList.length == '0') {
                     Cycle+= '<h3 style="text-align: center;line-height: 60px;">暂无充值记录...</h3>';
                     $('.calendarListY').append(Cycle);
                 } else {
                     for (var i = 0; i < data.body.transrecordList.length; i++) {
                         var str = data.body.transrecordList[i].createTime;
                         var time = str.split(" ");
                         var hours = time[1].split(":")[0];
                         var appType = data.body.transrecordList[i].appType;

                         var status = data.body.transrecordList[i].status;

                         Cycle += "<li><div style='width:20% '>";
                         if (hours < 12) {
                             Cycle += "<span class='morning'>上午</span>";
                         } else {
                             Cycle += "<span class='morning'>下午</span>";
                         }
                         Cycle += "<span>" + time[1] + "</span></div><div style='width:25% '>";
                         if (appType == 1000) {
                             Cycle += "<h4>话费充值</h4>";
                         } else {
                             Cycle += "<h4>话费流量</h4>";
                         }
                         Cycle += "</div><div style='width:41% '><span>-" + data.body.transrecordList[i].realAmt + "</span> <span style='font-size: 0.9rem;line-height: 1rem;'>给" + data.body.transrecordList[i].destNo + "充值</span></div> "
                         if (status == 0) {
                             Cycle += "<div style='width: 7%'><span class='Result' style='color:#999;white-space:nowrap'>充值</br>失败</span></div>";
                         } else if (status == 1) {
                             Cycle += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>充值</br>成功</span></div>";
                         } else if (status == 2) {
                             Cycle += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>等待</br>充值</span></div>";
                         }
                         if (status == 3) {
                             Cycle += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>充值</br>中</span></div>";
                         }
                         if (status == 4) {
                             Cycle += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>返销</br>审核中</span></div>";
                         }
                         if (status == 5) {
                             Cycle += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>返销中</span></div>";
                         }
                         if (status == 6) {
                             Cycle += "<div style='width: 7%'><span class='Result' style='color: #55a532;white-space:nowrap'>返销</br>成功</span></div>";
                         }
                         Cycle += "</li>"
                     }
                     $(".calendarListY").empty().append(Cycle);
                 }
             },
             error: function (data) {	//失败回调函数
                 console.log(data);
             }
         });
    });
});
function p(s) {
    return s < 10 ? '0' + s : s;
}