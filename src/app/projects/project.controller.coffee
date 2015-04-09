angular.module "checkpoints"
  .controller "ProjectCtrl", ($scope, $window, $state, Developer, Project, CheckPoint, Session) ->

    $scope.init = () ->
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
    
    $scope.deleteCheckpoint = (checkPoint) ->
      if $window.confirm 'Are you sure that you want to delete this Checkpoint? All sessions and checkpoints related to this checkpoint will be deleted too.'
        CheckPoint.destroyById
          id: checkPoint.id
        .$promise.then () ->
          $scope.init()

    $scope.deleteSession = (session) ->
      if $window.confirm 'Are you sure that you want to delete this Session?'
        Session.destroyById
          id: session.id
        .$promise.then () ->
          $scope.init()



