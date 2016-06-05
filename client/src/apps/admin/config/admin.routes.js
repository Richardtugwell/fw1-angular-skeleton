(function() {
  'use strict';

  angular.module('admin')
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/');

    $stateProvider
        .state('root', {
            abstract: true,
            templateUrl: 'admin/admin.html',
            resolve: {
                currentAccount: ['common.accountService' , function( accountService) {
                    return accountService.getAccount()
                }]
            },
            controller: 'PageController',
            controllerAs: 'page'
        })
        .state('admin', {
            url:'/',
            parent: 'root',
            views: {
                'header': {
                    template: '<fm-common-header />'
                },
                'content': {
                    template: '<fm-admin-display data="vm.data" />'
                }
            }
        })
        .state('admin.votes', {
            url:'votes',
            views: {
                'content@root': {
                    template: 'Votes stuff goes here'
                }
            }
        })
        .state('admin.accounts', {
            url:'accounts',
            views: {
                'content@root': {
                    template: 'Accounts stuff goes here'
                }
            }
        })

    }])

})();
