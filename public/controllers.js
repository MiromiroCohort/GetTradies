
(function () {
var getTradiesControllers = angular.module('getTradiesControllers', [])

getTradiesControllers.controller('JobController', ['$scope', 'Job', function ($scope, Job)
{

 $scope.jobs=Job.query(function() { console.log($scope.jobs)});

}]);

getTradiesControllers.controller('JobDetailController', ['$scope','$routeParams', 'Job', function ($scope, $routeParams, Job){
   console.log($routeParams.jobId)
   $scope.job = Job.get({ job_id: $routeParams.jobId }, function(job) {
    console.log($scope.job);
  }); // get() returns a single entry
}]);

getTradiesControllers.controller('UserJobsController', ['$scope','$routeParams', 'UserJobs', function ($scope,$routeParams, UserJobs)
{
  console.log($routeParams.user_id)
   $scope.jobs = UserJobs.query({ user_id: $routeParams.jobId }, function() {
    console.log($scope.jobs);
    });
}]);



var jobs=[{title:"dishwasher", description:"dishwasher", location:"Island Bay", id:1, moreLink: "jobs/1", showInterestLink:"/tenders", userJobsLink:"users/1/jobs" },
{title:"boyler", description:"boyler", location:"Quba street", id:1, moreLink: "jobs/2", showInterestLink:"/tenders", userJobsLink:"users/1/jobs" }]
})();
