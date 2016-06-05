(function() {
angular
	.module('public')
	.controller('PageController' , pageCtrl);

	pageCtrl.$inject = ['currentAccount' , 'messageCenterService' ];

	function pageCtrl(  currentAccount , messageCenterService  ) {

		var vm = this;
		vm.account = currentAccount;

	};

})();
