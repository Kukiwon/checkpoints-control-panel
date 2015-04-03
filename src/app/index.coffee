angular.module "checkpoints", ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'ui.router', 'ui.bootstrap', 'lbServices']
  .config ($stateProvider, $urlRouterProvider) ->
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

    $urlRouterProvider.otherwise '/'
