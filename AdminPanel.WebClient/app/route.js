
angular.module('app.route', [])

.config(['$routeProvider', 'authProvider', 'CONSTANTS', function ($routeProvider, authProvider, CONSTANTS) {
    
    $routeProvider

    .when('/', {
        templateUrl: 'app/components/home/home.html',
        controller: 'HomeController'
    })

    .when('/login', {
        templateUrl: 'app/components/login/login.html',
        controller: 'LoginController'
    })

    .when('/dashboard', {
        templateUrl: 'app/components/dashboard/dashboard.html',
        controller: 'DashboardController',
        requiresLogin: true
    });
    
    authProvider.init({
        clientID: CONSTANTS.auth0ClientID,
        domain: CONSTANTS.auth0Domain,
        loginUrl: '/login'
    });

}])
.run(function (auth) {
    auth.hookEvents();
});