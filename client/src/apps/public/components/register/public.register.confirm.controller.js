(function() {
angular
	.module('public.register')
	.controller('ConfirmEmailController' , confirmEmailCtrl );

	confirmEmailCtrl.$inject = [ 'emailConfirmation' , 'messageCenterService'];

	function confirmEmailCtrl( emailConfirmation , messageCenterService  ) {

		if ( emailConfirmation.data === "success" ) {
			messageCenterService.add(
				'success',
				'Email successfully confirmed! You can now login with your chosen credentials'
			);
		} else if ( emailConfirmation.data === "failure" ) {
			messageCenterService.add(
				'danger',
				'Email confirmation has failed - please check the URL and your email'
			);
		} else if ( emailConfirmation.data === "repeat" ) {
			messageCenterService.add(
				'info',
				'Email already confirmed!'
			);

		}

	};
})();
