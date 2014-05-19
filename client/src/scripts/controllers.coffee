myAppModule = angular.module 'myApp', []

myAppModule.controller 'dfpSitesController', ($scope, $http) ->
  $http.get('http://localhost:3000/api/media/months/2014-04').success (data, status, headers, config) ->
    $scope.placements = data
