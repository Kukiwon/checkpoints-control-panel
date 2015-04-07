angular.module "checkpoints"
  .controller "ProjectsCtrl", ($scope, $state, $window, Developer) ->

    $scope.create = () ->
    	$state.go 'create-project'

    $scope.init = () ->
    	$scope.projects = Developer.projects id: Developer.getCurrentId(), filter:
        include: ['checkPoints', 'sessions']


    $scope.view = (project) ->
    	$state.go 'view-project', projectId: project.id

   	$scope.delete = (project) ->
   		if $window.confirm 'Are you sure that you want to delete this project? Your tracking applications will lose all references to this project!'
   			project.$delete()
   			.then () ->
   				console.log 'yo'
   				$scope.init()
   			.catch (e) ->
   				console.log e