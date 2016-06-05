(function() {
  'use strict';

	angular
		.module('public.profile')
		.directive('fmProfile' , profileDirective)

	  function profileDirective() {
	    var directive = {
            restrict: 'E',
            templateUrl: 'public/components/profile/public.profile.html',
            controller: 'ProfileController',
            controllerAs: 'vm',
            bindToController: true
	    };

	    return directive;

	  }

})();
