'use strict';
angular.module('myApp.job_view', ['ngRoute'])
.config(['$routeProvider', function($routeProvider)
  {
    $routeProvider.when('/job_view', {
      templateUrl: 'job_view/job_view.html',
      controller: 'JobViewCtrl'
    });

  } ])
.controller('JobViewCtrl', [function () {

}]);
