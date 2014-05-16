(function() {
  "use strict";
  angular.module("clientApp").controller("MainCtrl", function($scope) {
    var updateClock;
    $scope.clock = new Date();
    updateClock = function() {
      return $scope.clock = new Date();
    };
    setInterval(function() {
      return $scope.$apply(updateClock, 1000);
    });
    updateClock();
  });

}).call(this);
