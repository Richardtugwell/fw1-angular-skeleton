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
				function( data ){
					$state.go('public.login');
					messageCenterService.add(
						'success',
						'Password reset - you can now login with your new credentials'
					);
				},
		        function(err){
		           console.error(err);
		        }
			)
		};

	};
})();
