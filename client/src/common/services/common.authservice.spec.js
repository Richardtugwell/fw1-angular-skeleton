'use strict';

describe('Common Auth Service', function () {

    var accountService;
    var user;
    var loginData = { email : 'email', password : 'pwd' };
    beforeEach(module('common'));

    beforeEach(inject(['common.accountService' , function ( commonAuthService ) {

        accountService = commonAuthService;
    }]));

    it('Should get a user.', function () {

        user = accountService.getAccount();
        console.log(user);
        expect( user).toBeDefined() ;
    });

});
