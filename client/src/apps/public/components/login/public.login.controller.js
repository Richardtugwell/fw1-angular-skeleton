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
				function(loginResult){
					if (loginResult.result) {
						accountService.setAccount( )
						.then( function(data) {
							$state.go('public' , {} , {reload : true });
						});
					}
					else {
			            toaster.pop({
							type: 'warning',
			        		title: 'Login Failed',
			        		body: loginResult.message,
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
