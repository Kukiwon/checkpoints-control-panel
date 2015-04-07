angular.module "checkpoints"
  .controller "NavbarCtrl", ($scope, $rootScope, Developer, AuthService) ->
    $rootScope.$watch 'currentUser', (newValue, oldValue) ->
    	$scope.isAuthenticated = Developer.isAuthenticated()
    	$scope.user = Developer.getCurrent()

    $scope.logOut = () ->
    	AuthService.logout()
