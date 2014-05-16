"use strict"

angular.module("clientApp").controller "MainCtrl", ($scope) ->


  # clock
  $scope.clock = new Date()
  updateClock = () ->
    $scope.clock = new Date()

  setInterval () ->
    $scope.$apply updateClock
    , 1000

  updateClock()

  return
