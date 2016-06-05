(function() {
  'use strict';

	angular
		.module('public.landingpage')
		.directive('fmLandingpage' , landingpageDirective)

	  function landingpageDirective() {
	    var directive = {
	      restrict: 'E',
	      templateUrl: 'public/components/landingpage/public.landingpage.html',
	      controller: 'LandingpageController',
	      controllerAs: 'vm',
	      bindToController: true
	    };

	    return directive;

	  }

})();
