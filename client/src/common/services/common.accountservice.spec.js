'use strict';

describe('Common Account Service', function () {

    var accountService;
    var result;
    var resultMock = "success"
    var Q;
    var rootScope;
    var httpBackend;
    var loginData = { email : 'email', password : 'pwd' };

    beforeEach(module('common'));

    beforeEach(inject(['common.accountService','$rootScope' , '$httpBackend' , '$q' , function ( commonAccountService, $rootScope , $httpBackend , $q ) {
        accountService = commonAccountService;
        httpBackend = $httpBackend;
        rootScope = $rootScope;
        Q = $q;
    }]));

    describe('Get/Set Account', function () {
        beforeEach( function() {
            httpBackend.whenGET('/api/public/getaccount')
              .respond( resultMock );
        })
        it('Get Account should call API return a promise.', function (done) {
            //Yeah, well this doesn't really prove much, does it? Ha ha ha.
            accountService.getAccount().then(function(data) {result = data;});
            httpBackend.flush();
            rootScope.$digest();
            expect( result ).toEqual( resultMock ) ;
            done();
        });
        it('Set Account should call API return a promise.', function (done) {

            accountService.setAccount().then(function(data) {result = data;});
            httpBackend.flush();
            rootScope.$digest();
            expect( result ).toEqual( resultMock ) ;
            done();
        });

    })
    describe('Login Account', function () {
        it('should call API and return a promise.', function (done) {
            httpBackend.whenPOST('/api/public/authenticate').respond( resultMock );
            accountService.loginAccount().then(function(data) {result = data;});
            httpBackend.flush();
            rootScope.$digest();
            expect( result ).toEqual( resultMock ) ;
            done();
        });
    });
    describe('Confirm Email', function () {
        it('should call API and return a promise.', function (done) {
            httpBackend.whenPOST('/api/public/confirmemail').respond( resultMock );
            accountService.confirmEmail().then(function(data) {result = data;});
            httpBackend.flush();
            rootScope.$digest();
            expect( result ).toEqual( resultMock ) ;
            done();
        });
    });
    describe('Request Password Reset', function () {
        it('should call API and return a promise.', function (done) {
            httpBackend.whenPOST('/api/public/requestpasswordreset').respond( resultMock );
            accountService.requestPasswordReset().then(function(data) {result = data;});
            httpBackend.flush();
            rootScope.$digest();
            expect( result ).toEqual( resultMock ) ;
            done();
        });
    });
    describe('Reset Password', function () {
        it('should call API and return a promise.', function (done) {
            httpBackend.whenPOST('/api/public/resetpassword').respond( resultMock );
            accountService.resetPassword().then(function(data) {result = data;});
            httpBackend.flush();
            rootScope.$digest();
            expect( result ).toEqual( resultMock ) ;
            done();
        });
    });
});
