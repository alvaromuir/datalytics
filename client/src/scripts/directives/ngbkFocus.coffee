

define ['directives/directives'], (directives) ->
  directives.directives ngbkFocus, [ $rootScope, () ->
    restrict: 'A'
    scope: true
    link: (scope, element, attrs) ->
      element[0].focus()
  ]
