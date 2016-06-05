(function() {
  'use strict';

	angular
		.module('public.resetpassword')
		.directive('fmResetPasswordForm' , resetpasswordDirective)

	  function resetpasswordDirective() {
	    var directive = {
            restrict: 'E',
            templateUrl: 'public/components/resetpassword/public.resetpassword.html',
            controller: 'ResetPasswordController',
            controllerAs: 'vm',
            bindToController: true
	    };

	    return directive;

	  }

})();
