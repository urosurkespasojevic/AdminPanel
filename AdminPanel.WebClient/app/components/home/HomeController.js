angular.module('app.controllers.home', [])

.controller('HomeController', ['$scope', 'auth', function ($scope, auth) {
    $scope.title = "Home page";
}]);