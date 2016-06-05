(function() {
  'use strict';

  angular.module('admin')
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/');

    $stateProvider
        .state('root', {
            abstract: true,
            templateUrl: 'admin/admin.html'
        })
        .state('admin', {
            url:'/',
            parent: 'root',
            views: {
                'header': {
                    template: '<fm-common-header />'
                }
            }
        })

    }])

})();
