(function() {
  'use strict';

	angular
		.module('common')
		.directive('fmCompareTo' , comparetoDirective)

	  function comparetoDirective() {
	    var directive = {
            require: "ngModel",
            scope: {
                otherModelValue: "=fmCompareTo"
            },
            link: function(scope, element, attributes, ngModel) {
                ngModel.$validators.fmCompareTo = function(modelValue) {
                    return modelValue == scope.otherModelValue;
                };

                scope.$watch("otherModelValue", function() {
                    ngModel.$validate();
                });
            }
	    };

	    return directive;

	  }

})();
