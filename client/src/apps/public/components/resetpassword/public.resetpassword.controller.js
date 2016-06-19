(function() {
angular
	.module('public.resetpassword')
	.controller('ResetPasswordController' , resetpasswordCtrl);

	resetpasswordCtrl.$inject = [ '$state' , '$stateParams' , 'common.accountService' , 'messageCenterService' ];

	function resetpasswordCtrl( $state , $stateParams , accountService , messageCenterService ) {
		var vm = this;
		vm.formdata = {};
		vm.formdata.token = $stateParams.token;
		messageCenterService.add(
			'warning',
			'Use the form on the right to reset your password'
		);

		vm.submitResetPassword = function() {
			accountService.resetPassword( vm.formdata ).then(
				function( response ){
					if (response.data.result) {
						$state.go('public.login');
						messageCenterService.add(
							'success',
							'Password reset - you can now login with your new credentials',
							{ status: messageCenterService.status.next }
						)
					}
					else {
						messageCenterService.remove('Password reset - you can now login with your new credentials');
						messageCenterService.add(
							'warning',
							'Password reset failed - maybe the link had already been used or has expired'
						);
					}
				},
		        function(err){
		           console.error(err);
		        }
			)
		};

	};
})();
