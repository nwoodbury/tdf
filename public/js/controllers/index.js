angular.module('tdf.system').controller('IndexController',
    ['$scope', 'Global', 'Users',
    function ($scope, Global, Users) {
        $scope.global = Global;

        $scope.loginerror = '';
        $scope.registererror = '';

        $scope.register = function() {
            var user = new Users($scope.newuser);
            user.$save(function(/*response*/) {
                // Successful Registration
                console.log('success');
                window.location.reload();
            }, function(msg) {
                // Failed Registration
                console.log('Failure');
                console.log(msg);
                $scope.registererror = msg.data.flash;
            });
        };

        $scope.login = function() {
            $scope.loginerror = '';
            Users.login($scope.loginuser, function() {
                // Successful Login
                // Reload everything so that angular can reconfigure itself
                window.location.reload();
            }, function(msg) {
                // Failed Login
                $scope.loginerror = msg.data.flash;
            });
        };
    }]);
