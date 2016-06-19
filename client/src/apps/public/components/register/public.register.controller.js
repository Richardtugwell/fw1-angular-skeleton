(function() {
angular
	.module('public.register')
	.controller('RegisterController' , registerCtrl);

	registerCtrl.$inject = [ '$state' , 'toaster' , 'common.accountService' , 'messageCenterService'];

	function registerCtrl( $state , toaster , accountService , messageCenterService ) {

		var vm = this;

		vm.submitRegister = function() {

			accountService.registerAccount( vm.registerData ).then(
				function(registerResult){
					if ( !registerResult.data.result ) {
			            toaster.pop({
							type: 'warning',
			        		title: 'Registration Failed',
			        		body: registerResult.data,
							timeout: 0,
							showCloseButton: true
						});
					}
					else {
						messageCenterService.add(
							'success',
							'Registration OK. Please check your email for activation instructions! (Remember to check your spam folders)',
							{ status: messageCenterService.status.next }
						);
						$state.go('public');
					}

				},
		        function(err){
		           console.error(err);
		        }
			)
		};


	};
})();
