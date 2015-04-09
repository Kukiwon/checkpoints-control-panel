angular.module "checkpoints", ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize',
'ngResource', 'ui.router', 'ui.bootstrap', 'lbServices', 'LocalStorageModule']
  .config ($stateProvider, $urlRouterProvider, LoopBackResourceProvider, $httpProvider) ->
    $stateProvider
      .state "home",
        url: "/",
        templateUrl: "app/main/main.html",
        controller: "MainCtrl"
      .state "sign-up",
      	url: "/sign-up",
      	templateUrl: "app/sign-up/sign-up.html",
      	controller: "SignUpCtrl"
      .state "sign-up-complete",
      	url: "/sign-up-complete",
      	templateUrl: "app/sign-up/sign-up-complete.html"
      .state "sign-in",
      	url: "/sign-in",
      	templateUrl: "app/sign-in/sign-in.html",
      	controller: "SignInCtrl"
      .state "projects",
        url: "/projects",
        templateUrl: "app/projects/projects.html",
        controller: "ProjectsCtrl"
      .state "create-project",
        url: "/projects/create",
        templateUrl: "app/projects/create-project.html",
        controller: "ProjectCtrl"
      .state "view-project",
        url: "/project/:projectId",
        templateUrl: "app/projects/project.html",
        controller: "ProjectCtrl"
      .state "create-checkpoint",
        url: "/project/:projectId/checkpoints/create",
        templateUrl: "app/checkpoints/create.html",
        controller: "CheckpointCtrl"

    LoopBackResourceProvider.setUrlBase 'http://checkpoints.elasticbeanstalk.com/api'
    #LoopBackResourceProvider.setUrlBase 'http://localhost:8081/api'
    #LoopBackResourceProvider.setUrlBase '/api'

    $urlRouterProvider.otherwise '/'

    $httpProvider.interceptors.push ($q, $location) ->
      {
        responseError: (rejection) ->
          if (rejection.status == 401)
            $location.nextAfterLogin = $location.path()
            $location.path('/sign-in')
          $q.reject(rejection)
      }
    
  .run () ->
