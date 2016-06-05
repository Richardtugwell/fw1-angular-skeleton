(function() {
angular
	.module('admin')
	.controller('PageController' , pageCtrl);

	pageCtrl.$inject = ['currentAccount' , 'APP_CONSTANTS'];

	function pageCtrl(  currentAccount , appConstants  ) {

		var vm = this;
		vm.constants = appConstants;
		vm.currentAccount = currentAccount;
	};

})();
