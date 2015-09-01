var getTradieServices = angular.module('getTradieServices', ['ngResource']);

getTradieServices.factory('Job', ['$resource',
  function($resource){
    return $resource('jobs/:job_id.json');
  }]);

getTradieServices.factory('UserJobs', ['$resource',
  function($resource){
    return $resource('users/:user_id/jobs/:job_id.json');
  }]);
