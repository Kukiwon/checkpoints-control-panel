angular.module "checkpoints"
  .controller "ProjectCtrl", ($scope, $window, $state, $interval, Developer, Project, CheckPoint, Session, localStorageService) ->

    $scope.init = () ->

      showCheckPoints = localStorageService.get('show-checkpoints')
      showLastOnly = localStorageService.get('show-last-checkpoint')
      sessionsShowingAll = localStorageService.get('sessions-showing-all')
      if sessionsShowingAll == null
        sessionsShowingAll = {}

      # bind variables to scope
      $scope.showCheckPoints =  showCheckPoints == null || showCheckPoints == 'true'
      $scope.showLastOnly = showLastOnly != null && showLastOnly == 'true'
      $scope.sessionsShowingAll = sessionsShowingAll
      
      $scope.fetchProject (project) ->
        $scope.project = project;
        if(!$scope.project.checkPoints.length)
          $scope.showCheckPoints = true
      $interval () ->
        $scope.fetchProject (project) ->
          $scope.project.sessions = project.sessions
      , 5000

    $scope.fetchProject = (cb) ->
      # load project
      if($state.params.projectId)
        return Project.findOne
          id: $state.params.projectId,
          filter:
            include:
              [
                'sessions': ['sessionCheckPoints': ['checkPoint']],
                'checkPoints'
              ]
            where:
              id: $state.params.projectId,
          (project) ->
            if(cb)
              cb(project)

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

    $scope.toggleShowCheckPoints = () ->
      $scope.showCheckPoints = !$scope.showCheckPoints
      localStorageService.set 'show-checkpoints', $scope.showCheckPoints

    $scope.toggleShowLastOnly = () ->
      $scope.showLastOnly = !$scope.showLastOnly
      localStorageService.set 'show-last-checkpoint', $scope.showLastOnly

    $scope.toggleShowAll = (session) ->
      $scope.sessionsShowingAll[session.id] = !!!$scope.sessionsShowingAll[session.id]
      localStorageService.set 'sessions-showing-all', $scope.sessionsShowingAll



