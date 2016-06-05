(function() {
  'use strict';

	angular
		.module('common.header')
		.directive('fmCommonHeader' , commonHeaderDirective)

	  function commonHeaderDirective() {
	    var directive = {
	      restrict: 'E',
	      templateUrl: 'common/components/header/common.header.html',
	      controller: 'CommonHeader',
	      controllerAs: 'vm',
	      bindToController: true
	    };

	    return directive;

	  }

})();
