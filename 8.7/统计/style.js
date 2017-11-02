
$(function () {
    $('#rise').date();
    $('#stop').date();

    var beginDate=minX();

    sum(beginDate,shopId,activityCode);

    list(shopId,activityCode);
    $(".button").click(function(){
        sum(beginDate,shopId,activityCode);
        list(shopId,activityCode);
    })

});

function sum(beginDate,shopId,activityCode,endDate){
    var rise = $("#rise").val();
    var stop = $("#stop").val();
    if(rise!=""){
        var beginDate = rise + " " + "00:00:00";
        var endDate = stop + " " + "23:59:59";
    }

    var date=JSON.stringify({beginDate:beginDate, endDate: endDate,  shopId: shopId, activityCode: activityCode});

    $.ajax({
        url: url+'/redpacket/infoSum',
        type: "post",
        data:date ,
        dataType: "json",
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        success: function (data) {

            var Cla = "";
            Cla += '<p class="p">'+max(data.data.beginDate)+'<b>日</b>至<b>'+max(data.data.endDate)+'日</b>，统计信息如下：</p>' +
                '<p class="p">使用红包数量<b>' + data.data.usedNum + '</b>个，抵扣金额<b>' + data.data.offset + '</b>元</p>' +
                '<p class="p">应收金额<b>' + data.data.shouldIn + '</b>元，实际收款<b>' + data.data.realIn + '</b>元</p>';

            $(".Ldata").empty().append(Cla);

        }, error: function (data) {
            console.log(data)
        }
    });
}
function  list(shopId,activityCode) {
    var rise = $("#rise").val();
    var stop = $("#stop").val();
    if(rise!=""){
        var beginDate = rise + " " + "00:00:00";
        var endDate = stop + " " + "23:59:59";
    }

    var date=JSON.stringify({beginDate:beginDate, endDate: endDate, shopId: shopId, activityCode: activityCode,})
    $.ajax({
        url: url+'/redpacket/infoList',
        type: "post",
        data: date,
        dataType: "json",
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        async: false,
        success: function (data) {

            if(data.data==null){
                $("#add").empty();
                return false;
            }
            var Cla="";
            for(var i=0;i<data.data.length;i++){
                Cla+='<div class="divL"><span class="red">'+max(data.data[i].time)+'日</span><span class="receivable">'+data.data[i].shouldAmt+'</span><span class="DeK">'+data.data[i].offset+'</span><span class="Actual">'+data.data[i].realAmt+'</span></div>'
            }
            $("#add").empty().append(Cla);

        }, error: function (data) {
            console.log(data)
        }
    });

}

function max(sce){//获取函数封装
    var dateS = new Date(sce);
    YS = dateS.getFullYear() + '年';
    MS = (dateS.getMonth()+1 < 10 ? '0'+(dateS.getMonth()+1) : dateS.getMonth()+1) + '月';
    DS = dateS.getDate() + ' ';
    return YS+MS+DS;
}

function minX(){
    var date = new Date();//获取当前时间
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var beginDate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + date.getHours() + seperator2 + date.getMinutes()
        + seperator2 + date.getSeconds();
    return beginDate;

}