(function() {
angular
	.module('public.login')
	.controller('LoginController' , loginCtrl);

	loginCtrl.$inject = ['$state' , 'toaster' , 'common.accountService'];

	function loginCtrl($state , toaster , accountService) {

		var vm = this;
		vm.loginData = {};
		vm.submitLogin = function() {

			accountService.loginAccount( vm.loginData ).then(
				function(result){
					if (result.data.authenticated) {
						accountService.setAccount( )
						.then( function(data) {
							$state.go('public' , {} , {reload : true });
						});
					}
					else {
			            toaster.pop({
							type: 'warning',
			        		title: 'Login Failed',
			        		body: result.data.message,
							timeout: 0,
							showCloseButton: true
						});
					}
				},
		        function(err){
		           console.error(err);
		        }
			)
		};
	}


})();
