(function() {
    'use strict';

    angular
    .module('admin')
    .factory('adminService' , adminService )

    adminService.$inject = ['Restangular']

    function adminService(restangular) {

        var service    = {};
        var api = restangular.all('/api');
        service.getData = getData;

        return service;

        // Local functions follow

        function getData() {
            return api.get('admin/getData');
        }


    }

})();
