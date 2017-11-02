define(function(require, exports, module) {
    exports.init = function(page) {
        var msa="";
        msa+='<header><a href="JavaScript:history.back(-1)" style="text-align: left" data-rel="back"><i class="iconfont icon-fanhui" style="color:#fff;"><</i></a><span>中奖纪录</span><a href="javascript:void(0)" style="text-align: right;">完成</a></header><div class="content" style="overflow: auto;height:80%; "><ul class="lists"></ul></div>';
		page.innerHTML =msa;
	};
   var pp=0;
    $(".page1").click(function () {
        if(pp===0){
            setTimeout(function() {
                fen($(".content"),'../update.json',$(".lists"))
            },400);
            pp++;
        }
    });
});
function fen(content,url,lists) {
    var counter = 0;
    // 每页展示4个
    var num = 4;
    var pageStart = 0, pageEnd = 0;
    // dropload
    content.dropload({
        scrollArea: window,
        domDown: {
            domClass: 'dropload-down',
            domRefresh: '<div class="dropload-refresh">↑上拉加载更多-自定义内容</div>',
            domLoad: '<div class="dropload-load"><span class="loadin"></span>加载中-自定义内容...</div>',
            domNoData: '<div class="dropload-noData">暂无数据-自定义内容</div>'
        },
        loadDownFn: function (me) {
            $.ajax({
                type: 'GET',
               // url: '../update.json',
                url:url,
                dataType: 'json',
                success: function (data) {
                    var result = '';
                    counter++;
                    pageEnd = num * counter;
                    pageStart = pageEnd - num;
                    for (var i = pageStart; i < pageEnd; i++) {
                        result += '<li><div style="color:#999;"><b>12:20</b><b>8月9号</b></div><div><span style="color: #666;font-weight: 400">' + data.lists[i].title + '</span></div><div><b style="color: #666">' + data.lists[i].date + '</b><b style="color: #999;">"红码有礼"抽中一等奖</b></div><div><span style="color: red">去领奖</span></div></li>';
                        if ((i + 1) >= data.lists.length) {
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                            break;
                        }
                    }
                    // 为了测试，延迟1秒加载
                    setTimeout(function () {
                        lists.append(result);
                        // 每次数据加载完，必须重置
                        me.resetload();
                    }, 800);
                },
                error: function (xhr, type) {
                    alert('Ajax error!');
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        },
        threshold: 50
    });
}