(function() {
  'use strict';

  angular.module('public')
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/public');

    $stateProvider
        .state('root', {
            abstract: true,
            templateUrl: 'public/public.html',
            resolve: {
                currentAccount: ['common.accountService' , function( accountService) {
                    return accountService.getAccount()
                }]
            },
            controller: 'PageController',
            controllerAs: 'page'
        })
        .state('public', {
            parent: 'root',
            url:'/public',
            views: {
                'header': {
                    template: '<fm-common-header />'
                },
                'content': {
                    template: '<fm-landingpage />'
                },
                'auth': {
                    template: '<fm-login-form />'
                },
                'profile': {
                    template: '<fm-profile />'
                }
            }
        })
        .state('public.login', {
            url:'/login',
            views: {
                'auth@root': {
                    template: '<fm-login-form />'
                }
            }
        })
        .state('public.register', {
            url:'/register',
            views: {
                'auth@root': {
                    template: '<fm-register-form />'
                }
            }
        })
        .state('public.registrationOk', {
            url:'/registrationOk',
            views: {
                'auth@root': {
                    templateUrl: 'public/templates/public.registrationOk.html'
                }
            }
        })
        .state('public.requestpasswordreset', {
            url:'/requestpasswordreset',
            views: {
                'auth@root': {
                    template: '<fm-request-password-reset-form />'
                }
            }
        })
        .state('public.requestpasswordresetOk', {
            url:'/requestpasswordresetOk',
            views: {
                'auth@root': {
                    templateUrl: 'public/templates/public.requestpasswordresetOk.html'
                }
            }
        })
        .state('public.resetpassword', {
            url:'/resetpassword/:token',
            views: {
                'auth@root': {
                    template: '<fm-reset-password-form />'
                }
            }
        })
        .state('public.unauthorised', {
            url:'/unauthorised',
            views: {
                'content@root': {
                    templateUrl: 'public/templates/public.unauthorised.html'
                }
            }
        })
        .state('public.confirmemail', {
            url:'/confirmemail/:token',
            resolve: {
                emailConfirmation: ['common.accountService', '$stateParams' , function( accountService , $stateParams) {
                    return accountService.confirmEmail( $stateParams )
                }]
            },
            views: {
                'auth@root': {
                    template: '<fm-login-form />',
                    controller: 'ConfirmEmailController'
                }
            }
        })
        .state('public.404', {
            url:'/404',
            views: {
                'content@root': {
                    templateUrl: 'public/templates/public.404.html'
                }
            }
        })

    }])

})();
