(function() {
  'use strict';

	angular
		.module('common.header')
		.controller('CommonHeader' , commonHeaderController);

	commonHeaderController.$inject = ['common.accountService' , 'APP_CONSTANTS']

	function commonHeaderController( accountService , appConstants  ) {

		var vm = this;
        vm.account = [];
	    vm.isCollapsed = true;
        vm.appName = appConstants.APP_NAME;
        accountService.getAccount()
        .then( function(data) {
            vm.account = data;
        });

    }

})();
