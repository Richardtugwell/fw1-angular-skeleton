(function() {
  'use strict';

	angular
		.module('public.register')
		.directive('fmRegisterForm' , registerFormDirective)

	  function registerFormDirective() {
	    var directive = {
            restrict: 'E',
            templateUrl: 'public/components/register/public.register.html',
            controller: 'RegisterController',
            controllerAs: 'vm',
            bindToController: true
	    };

	    return directive;

	  }

})();
