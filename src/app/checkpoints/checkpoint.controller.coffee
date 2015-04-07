angular.module "checkpoints"
  .controller "CheckpointCtrl", ($scope, $state, Developer, Project) ->

    $scope.createCheckpoint = (checkPoint) ->
      checkPoint.created = new Date
      Project.checkPoints.create id: $state.params.projectId, checkPoint, () ->
        $state.go 'view-project', projectId: $state.params.projectId
    
