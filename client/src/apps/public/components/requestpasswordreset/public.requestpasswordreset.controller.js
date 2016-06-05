(function() {
angular
	.module('public.requestpasswordreset')
	.controller('RequestPasswordResetController' , requestpasswordresetCtrl);

	requestpasswordresetCtrl.$inject = [ '$state' , 'messageCenterService' , 'common.accountService' ];

	function requestpasswordresetCtrl( $state , messageCenterService , accountService ) {

		var vm = this;

		vm.submitRequestPasswordReset = function() {

			accountService.requestPasswordReset( vm.formdata ).then(
				function(resetResult){
					messageCenterService.add(
						'success',
						'Please check your email for password reset instructions! (Remember to check your spam folders)'
					);
				},
		        function(err){
		           console.error(err);
		        }
			)
		};

	};
})();
