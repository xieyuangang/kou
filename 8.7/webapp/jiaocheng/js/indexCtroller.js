/**
 * Created by melanie on 2016/7/12.
 */

myApp.controller("courseCtrl" , function($scope , $http , tool){

});

myApp.controller("iscrollCtrl" , function($scope , $http , tool){
    var num = document.getElementsByClassName("flow").length;
    document.getElementById("wrapper").style.height = document.body.offsetHeight - 44 + "px";
    document.getElementById("scroller").style.width = document.body.offsetWidth * num + "px";
    eachImg();

    myScroll = new iScroll('wrapper', {
        snap: true,
        momentum: false,
        hScrollbar: false,
    });
});

function eachImg(){
    var imgs = document.getElementsByClassName("flow");
    for(var i = 0;i < imgs.length;i++){
        imgs[i].style.width = document.body.offsetWidth + "px";
    }
}