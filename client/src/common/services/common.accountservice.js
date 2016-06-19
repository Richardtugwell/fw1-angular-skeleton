(function() {
  'use strict';

	angular
		.module('common')
		.factory('common.accountService' , accountService )

	accountService.$inject = [ '$http' ]

    function accountService( $http ) {

        var service    = {};
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

            return $http( {
                method : "POST",
                url : "api/public/authenticate" ,
                data : data })
        }

        function getAccount( ) {

            if ( accountPromise == null ) {
            // Caches the account promise so we only need one xhr call
                accountPromise = $http.get( 'api/public/getaccount')
                    .then(function (response) {
                        return response.data;
                    });
            }
            return accountPromise;
        }

        function setAccount( ) {

            accountPromise = null;
            return getAccount();
        }

        function registerAccount( registerdata ) {

            return $http( {
                method : "POST",
                url : "api/public/register" ,
                data : registerdata })

        }

        function confirmEmail( data ) {

            return $http( {
                method : "POST",
                url : "api/public/confirmemail" ,
                data : data })

        }

        function requestPasswordReset( formdata ) {

            return $http( {
                method : "POST",
                url : "api/public/requestpasswordreset" ,
                data : formdata })

        }

        function resetPassword( formdata ) {

            return $http( {
                method : "POST",
                url : "api/public/resetpassword" ,
                data : formdata })

        }
    }

})();
