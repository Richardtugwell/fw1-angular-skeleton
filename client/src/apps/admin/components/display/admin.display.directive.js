(function() {
  'use strict';

	angular
        .module('admin.display')
		.directive('fmAdminDisplay' , adminDisplayDirective)

    function adminDisplayDirective() {
        var directive = {
            restrict: 'E',
            scope: {
                data: '='
            },
            templateUrl: 'admin/components/display/admin.display.html',
            controller: 'DisplayController',
            controllerAs: 'vm'
        };

        return directive;

    }

})();
