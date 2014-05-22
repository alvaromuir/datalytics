define ['angular'], (angular) ->
  'use strict';

  datalytics = angular.module 'datalytics', []


  datalytics.controller 'dmpController', ($scope, $http) ->

    $http.get('http://localhost:3000/api/media/business_days/year/2014/month/apr').success (data, status, headers, config) ->
      $scope.business_days = data

    $http.get('http://localhost:3000/api/media/months/2014-04').success (data, status, headers, config) ->
      $scope.placements = data
