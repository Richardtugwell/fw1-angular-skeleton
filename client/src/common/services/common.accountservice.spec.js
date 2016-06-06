'use strict';

describe('Common Account Service', function () {

    var accountService;
    var account;
    var accountMock = "success"
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

    describe('Account functions', function () {
        beforeEach( function() {
            httpBackend.whenGET('/api/public/getaccount')
              .respond( accountMock );
        })
        it('Get Account should return a promise.', function (done) {
            //Yeah, well this doesn't really prove much, does it? Ha ha ha.
            accountService.getAccount().then(
                function(data) {
                    account = data;
                }
            );
            httpBackend.flush();
            rootScope.$digest();
            expect( account ).toEqual( accountMock ) ;
            done();
        });
        it('Set Account should return a promise.', function (done) {

            accountService.setAccount().then(
                function(data) {
                    account = data;
                }
            );
            httpBackend.flush();
            rootScope.$digest();
            expect( account ).toEqual( accountMock ) ;
            done();
        });

    })
});
