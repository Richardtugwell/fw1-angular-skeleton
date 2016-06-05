(function() {
  'use strict';

	angular
		.module('common')
		.factory('common.accountService' , accountService )

	accountService.$inject = ['Restangular']

    function accountService(restangular) {

        var service    = {};
        var publicAPI = restangular.all('/api/public');
        var accountPromise = null;

        service.loginAccount = loginAccount;
        service.getAccount = getAccount;
        service.setAccount = setAccount;
        service.registerAccount = registerAccount;
        service.confirmEmail = confirmEmail;
        service.requestPasswordReset = requestPasswordReset;
        service.resetPassword = resetPassword;


        return service;

        function loginAccount( data ) {

            return publicAPI.customPOST( data , 'authenticate');

        }

        function getAccount( ) {

            if ( accountPromise == null ) {
            // Caches the account promise so we only need one xhr call
                accountPromise = publicAPI.get( 'getaccount')
                    .then(function (data) {
                        return data.plain();
                    });
            }
            return accountPromise;
        }

        function setAccount( ) {

            accountPromise = null;
            return getAccount();
        }

        function registerAccount( registerdata ) {

            return publicAPI.customPOST( registerdata , 'register');

        }

        function confirmEmail( data ) {

            return publicAPI.customPOST( data , 'confirmemail');

        }

        function requestPasswordReset( formdata ) {

            return publicAPI.customPOST( formdata , 'requestpasswordreset');

        }

        function resetPassword( formdata ) {

            return publicAPI.customPOST( formdata , 'resetpassword');

        }
    }

})();
