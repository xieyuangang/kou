var myApp = angular.module('myApp', ['ui.router']);

myApp.directive('fileModel', ['$parse', 'fileReader', function($parse, fileReader) {
    return {
        restrict:'A',
        link:function(scope, element, attrs, ngModel) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;
            var imgviewID = attrs["imgViewId"];
            var imgView = angular.element(document.querySelector("."+imgviewID));
            element.bind('change', function(event) {
                scope.$apply(function() {
                    modelSetter(scope, element[0].files[0]);
                });
                //附件预览
                scope.file = (event.srcElement || event.target).files[0];
                fileReader.readAsDataUrl(scope.file, scope).then(function(result) {
                    imgView.attr("src",result);
                });
            });
        }
    }
}]);
myApp.factory('fileReader', ["$q", "$log", function($q, $log) {
    var onLoad = function(reader, deferred, scope) {
        return function() {
            scope.$apply(function() {
                deferred.resolve(reader.result);

            });
        }
    };

    var onError = function(reader, deferred, scope) {
        return function() {
            scope.$apply(function() {
                deferred.reject(reader.result);
            });
        };
    };

    var getReader = function(deferred, scope) {
        var reader = new FileReader();
        reader.onload = onLoad(reader, deferred, scope);
        reader.onerror = onError(reader, deferred, scope);
        return reader;
    };

    var readAsDataURL = function(file, scope) {
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

myApp.controller("homo", ['$scope','$http', function ($scope,$http) {

    $scope.Submit=function () {
        $scope.postData = {
            idCardFace: angular.element(document.querySelector(".idCardFace"))[0].src,//获取html中的class选择器
            idCardBack: angular.element(document.querySelector(".idCardBack"))[0].src
        };
            console.log($scope.postData)
    };
/*       $http.post('style.js',$scope.postData).success(function(data){

       });*/
}]);

myApp.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/style8');
    $stateProvider.state('style8', {
        url: '/style8',
        templateUrl: './html/style8.html'
    })
});



