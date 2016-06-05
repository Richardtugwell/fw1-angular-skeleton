(function() {
  'use strict';

  angular.module('user')
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/');

    $stateProvider
        .state('root', {
            abstract: true,
            templateUrl: 'user/user.html',
            resolve: {
                currentAccount: ['common.accountService' , function( accountService) {
                    return accountService.getAccount()
                }]
            },
            controller: 'PageController',
            controllerAs: 'page'
        })
        .state('user', {
            url:'/',
            parent: 'root',
            views: {
                'header': {
                    template: '<fm-common-header />'
                },
                'content': {
                    template: '<fm-user-landingpage />'
                }
            }
        })

    }])

})();
