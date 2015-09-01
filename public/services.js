var getTradieServices = angular.module('getTradieServices', ['ngResource']);

getTradieServices.factory('Job', ['$resource',
  function($resource){
    return $resource('jobs/:job_id.json');
  }]);
