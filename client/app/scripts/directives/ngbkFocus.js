(function() {
  define(['directives/directives'], function(directives) {
    return directives.directives(ngbkFocus, [
      $rootScope, function() {
        return {
          restrict: 'A',
          scope: true,
          link: function(scope, element, attrs) {
            return element[0].focus();
          }
        };
      }
    ]);
  });

}).call(this);
