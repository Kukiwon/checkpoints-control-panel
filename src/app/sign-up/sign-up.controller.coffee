angular.module "checkpoints"
  .controller "SignUpCtrl", ($scope, $state, AuthService) ->
    $scope.user = {}
    $scope.register = (user) ->
      AuthService.register user.email, user.password
      .then () ->
        $state.go 'sign-up-complete'
