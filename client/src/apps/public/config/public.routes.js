(function() {
  'use strict';

  angular.module('public')
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/');

    $stateProvider
        .state('public', {
            url:'/',
            resolve: {
                currentAccount: ['common.accountService' , function( accountService) {
                    return accountService.getAccount()
                }]
            },
            views: {
                '': {
                templateUrl: 'public/public.html',
                controller: 'PageController',
                controllerAs: 'page'
                },
                'header@public': {
                    template: '<fm-common-header />'
                },
                'content@public': {
                    template: '<fm-landingpage />'
                },
                'auth@public': {
                    template: '<fm-login-form />'
                },
                'profile@public': {
                    template: '<fm-profile />'
                }
            }
        })
        .state('public.login', {
            url:'login',
            views: {
                'auth@public': {
                    template: '<fm-login-form />'
                }
            }
        })
        .state('public.register', {
            url:'register',
            views: {
                'auth@public': {
                    template: '<fm-register-form />'
                }
            }
        })
        .state('public.registrationOk', {
            url:'registrationOk',
            views: {
                'auth@public': {
                    templateUrl: 'public/templates/public.registrationOk.html'
                }
            }
        })
        .state('public.requestpasswordreset', {
            url:'requestpasswordreset',
            views: {
                'auth@public': {
                    template: '<fm-request-password-reset-form />'
                }
            }
        })
        .state('public.requestpasswordresetOk', {
            url:'requestpasswordresetOk',
            views: {
                'auth@public': {
                    templateUrl: 'public/templates/public.requestpasswordresetOk.html'
                }
            }
        })
        .state('public.resetpassword', {
            url:'resetpassword/:token',
            views: {
                'auth@public': {
                    template: '<fm-reset-password-form />'
                }
            }
        })
        .state('public.unauthorised', {
            url:'unauthorised',
            views: {
                'content@public': {
                    templateUrl: 'public/templates/public.unauthorised.html'
                }
            }
        })
        .state('public.confirmemail', {
            url:'confirmemail/:token',
            resolve: {
                emailConfirmation: ['common.accountService', '$stateParams' , function( accountService , $stateParams) {
                    return accountService.confirmEmail( $stateParams )
                }]
            },
            views: {
                'auth@public': {
                    template: '<fm-login-form />',
                    controller: 'ConfirmEmailController'
                }
            }
        })
        .state('public.404', {
            url:'404',
            views: {
                'content@public': {
                    templateUrl: 'public/templates/public.404.html'
                }
            }
        })

    }])

})();
