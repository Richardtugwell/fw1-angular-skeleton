(function() {
  'use strict';

  angular.module('common', [
    'ui.router',
    'ngAnimate',
    'ngSanitize',
    'ngMessages',
    'restangular',
    'ui.bootstrap',
    'toaster',
    'MessageCenterModule',
    //app components
    'common.header',
    'common.messagecenter'
  ])

  angular.module('common.header', [])
  angular.module('common.messagecenter', [])

})();
