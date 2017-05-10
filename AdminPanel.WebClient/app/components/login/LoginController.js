angular.module('app.controllers.login', [])

.controller('LoginController', ['$scope', '$location', 'auth', function ($scope, $location, auth) {

    $scope.login = function () {
        auth.signin({}, function (profile, token) {
            $location.path('/dashboard');
            console.log(profile);
        }, function (err) {
            console.log(err);
        });
    }();
}]);