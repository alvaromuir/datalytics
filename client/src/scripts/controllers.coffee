myAppModule = angular.module 'myApp', []

myAppModule.controller 'dfpSitesController', ($scope, $http) ->
  $http.get('http://localhost:3000/api/placements').success (data, status, headers, config) ->
    $scope.placements = data
