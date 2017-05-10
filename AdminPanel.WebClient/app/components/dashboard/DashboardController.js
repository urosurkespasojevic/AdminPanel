angular.module('app.controllers.dashboard', [])

.controller('DashboardController', ['$scope', 'auth', function ($scope, auth) {
    function activate() {
        console.log(auth.profile);
    }
    activate();
}]);