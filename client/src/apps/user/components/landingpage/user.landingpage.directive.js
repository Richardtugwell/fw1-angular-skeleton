(function() {
  'use strict';

	angular
		.module('user.landingpage')
		.directive('fmUserLandingpage' , landingpageDirective)

	  function landingpageDirective() {
	    var directive = {
	      restrict: 'E',
	      templateUrl: 'user/components/landingpage/user.landingpage.html',
	      controller: 'LandingpageController',
	      controllerAs: 'vm',
	      bindToController: true
	    };

	    return directive;

	  }

})();
