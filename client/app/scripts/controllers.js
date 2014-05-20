(function() {
  var myAppModule;

  myAppModule = angular.module('myApp', []);

  myAppModule.controller('dfpSitesController', function($scope, $http) {
    $http.get('http://localhost:3000/api/media/business_days/year/2014/month/apr').success(function(data, status, headers, config) {
      return $scope.business_days = data;
    });
    return $http.get('http://localhost:3000/api/media/months/2014-04').success(function(data, status, headers, config) {
      return $scope.placements = data;
    });
  });

}).call(this);
