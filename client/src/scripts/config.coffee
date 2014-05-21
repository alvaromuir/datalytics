require.config
  paths:
    'angular'          : '/vendor/angular/angular'
    'angularResource'  : '/vendor/angular-resource/angular-resource'
    'd3'               : '/vendor/d3/d3'
    'domReady'         : '/vendor/requirejs-domready/domReady'
    'jquery'           : '/vendor/jquery/jquery'
    'underscore'       : '/vendor/lodash/lodash.compat'
    'moment'           : '/vendor/moment/moment'

    'tools'            : './tools'

  shim:
    'underscore':
      exports: '_'

    'angular':
      deps: ['d3', 'jquery', 'moment']
      exports: 'angular'

    'angularResource':
      deps:['angular']
