(function() {
  'use strict';

  angular.module('public', [

    //common
    'common',


    //app components
    'public.landingpage',
    'public.profile',
    'public.login',
    'public.requestpasswordreset',
    'public.resetpassword',
    'public.register'
    ])

  angular.module('public.landingpage', [])
  angular.module('public.profile', [])
  angular.module('public.login', [])
  angular.module('public.register', [])
  angular.module('public.requestpasswordreset', [])
  angular.module('public.resetpassword', [])

})();
