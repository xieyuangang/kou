var myApp = angular.module('myApp', ['ui.router']);

myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/Pict');
    $stateProvider.state('Pict', {
        url: '/Pict',
        templateUrl: './Pict.html'
    })
});
myApp.directive('fileModel', ['$parse', 'fileReader', function ($parse, fileReader) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs, ngModel) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;
            var imgviewID = attrs["imgViewId"];
            var imgView = angular.element(document.querySelector("." + imgviewID));
            element.bind('change', function (event) {
                scope.$apply(function () {
                    modelSetter(scope, element[0].files[0]);
                });
                //附件预览
                scope.file = (event.srcElement || event.target).files[0];
                fileReader.readAsDataUrl(scope.file, scope).then(function (result) {
                    imgView.attr("src", result);
                });
            });
        }
    }
}]);
myApp.factory('fileReader', ["$q", "$log", function ($q, $log) {
    var onLoad = function (reader, deferred, scope) {
        return function () {
            scope.$apply(function () {
                deferred.resolve(reader.result);
            });
        }
    };

    var onError = function (reader, deferred, scope) {
        return function () {
            scope.$apply(function () {
                deferred.reject(reader.result);
            });
        };
    };

    var getReader = function (deferred, scope) {
        var reader = new FileReader();
        reader.onload = onLoad(reader, deferred, scope);
        reader.onerror = onError(reader, deferred, scope);
        return reader;
    };

    var readAsDataURL = function (file, scope) {
        var deferred = $q.defer();
        var reader = getReader(deferred, scope);
        reader.readAsDataURL(file);
        return deferred.promise;
    };
    return {
        readAsDataUrl: readAsDataURL
    };
}
]);
myApp.controller("homo", function ($scope, $http, $rootScope) {

    $scope.ppt=function () {//移除事件
        angular.element(document.querySelector('.nameSt').remove())
    };


    $scope.sub = function () {
        /* var Img = angular.element(document.querySelector(".idCardFace"))[0].src;

         var id = $(" input[type='checkbox']:checked").val();
         if ($scope.shopName == id) {
             alert("请输入店铺名字")
         } else if ($scope.commodityName == id) {
             alert("请输入商品名字")
         } else if ($scope.commodityPrice == id) {
             alert("请输入价格")
         } else if ($scope.commodityNumber == id) {
             alert("请输入数量")
         } else if (Img == "") {
             alert("请上传照片")
         } else {
             $scope.postData = {
                 shopName: $scope.shopName, commodityName: $scope.commodityName, commodityPrice: $scope.commodityPrice,
                 commodityNumber: $scope.commodityNumber, Img: Img
             };
             console.log($scope.postData)
         }*/




    };



    $scope.cancel = function () {
       // location.reload()
    }
});

$(function(){
    // 初始化插件
    $("#zyupload").zyUpload({
        width            :   "100%",                 // 宽度
        height           :   "165px",                 // 宽度
        itemWidth        :   "90px",                 // 文件项的宽度
        itemHeight       :   "90px",                 // 文件项的高度
        url              :   "./up.php",              // 上传文件的路径
        fileType         :   ["jpg","png","js","exe"],// 上传文件的类型
        fileSize         :   51200000,                // 上传文件的大小
        multiple         :   true,                    // 是否可以多个文件上传
        dragDrop         :   false,                   // 是否可以拖动上传文件
        tailor           :   false,                   // 是否可以裁剪图片
        del              :   true,                    // 是否可以删除文件
        finishDel        :   false,  				  // 是否在上传文件完成后删除预览
        /* 外部获得的回调接口 */
        onSelect: function(selectFiles, allFiles){    // 选择文件的回调方法  selectFile:当前选中的文件  allFiles:还没上传的全部文件
            console.info("当前选择了以下文件：");
            console.info(selectFiles);
        },
        onDelete: function(file, files){              // 删除一个文件的回调方法 file:当前删除的文件  files:删除之后的文件
            console.info("当前删除了此文件：");
            console.info(file.name);
        },
        onSuccess: function(file, response){          // 文件上传成功的回调方法
            console.info("此文件上传成功：");
            console.info(file.name);
            console.info("此文件上传到服务器地址：");
            console.info(response);
            $("#uploadInf").append("<p>上传成功，文件地址是：" + response + "</p>");
        },
        onFailure: function(file, response){          // 文件上传失败的回调方法
            console.info("此文件上传失败：");
            console.info(file.name);
        },
        onComplete: function(response){           	  // 上传完成的回调方法
            console.info("文件上传完成");
            console.info(response);
        }
    });

});