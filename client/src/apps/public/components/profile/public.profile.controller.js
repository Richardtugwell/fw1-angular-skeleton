(function() {
angular
	.module('public.profile')
	.controller('ProfileController' , profileCtrl);

	profileCtrl.$inject = [ 'common.accountService'];

	function profileCtrl( accountService  ) {

		var vm = this;
		vm.account = null;
			accountService.getAccount().then(function(data) {
				console.log('gettingacccount');
				vm.account = data;
				},
		        function(err){
		           console.error(err);
		        }
			)
	};
})();
