(function() {
  var myAppModule;

  myAppModule = angular.module('myApp', []);

  myAppModule.controller('dfpSitesController', function($scope, $http) {
    return $http.get('http://localhost:3000/api/placements').success(function(data, status, headers, config) {
      return $scope.placements = data;
    });
  });

}).call(this);
