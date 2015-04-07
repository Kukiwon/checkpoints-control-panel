angular.module "checkpoints"
  .controller "ProjectCtrl", ($scope, $state, Developer, Project) ->

    # load project
    if($state.params.projectId)
      $scope.project = Project.findOne
        id: $state.params.projectId,
        filter:
          include:
            [
              'sessions': ['sessionCheckPoints': ['checkPoint']],
              'checkPoints'
            ]
          where:
            id: $state.params.projectId

    $scope.create = (project) ->
      id = Developer.getCurrentId()
      project.created = new Date
      Developer.projects.create {id: id}, project, () ->
        $state.go 'projects'

    $scope.createCheckpoint = () ->
      $state.go 'create-checkpoint', projectId: $scope.project.id
    
