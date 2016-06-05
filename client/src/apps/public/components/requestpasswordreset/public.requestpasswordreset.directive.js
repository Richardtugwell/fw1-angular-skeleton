(function() {
  'use strict';

	angular
		.module('public.requestpasswordreset')
		.directive('fmRequestPasswordResetForm' , requestPasswordResetDirective)

	  function requestPasswordResetDirective() {
	    var directive = {
            restrict: 'E',
            templateUrl: 'public/components/requestpasswordreset/public.requestpasswordreset.html',
            controller: 'RequestPasswordResetController',
            controllerAs: 'vm',
            bindToController: true
	    };

	    return directive;

	  }

})();
