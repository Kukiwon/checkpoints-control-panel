angular.module "checkpoints"
  .controller "SignInCtrl", ($scope, $state, AuthService) ->
    $scope.user = {}
    $scope.signIn = (user) ->
      AuthService.login user.email, user.password
      .then () ->
        $state.go 'projects'
      .catch (e) ->
      	console.log(e)
      	if(e.status === 401)
      		$scope.error = "Your email address and password combination was not correct"
      	else
      		$scope.error = "Oops. Something went wrong. Please try again."
