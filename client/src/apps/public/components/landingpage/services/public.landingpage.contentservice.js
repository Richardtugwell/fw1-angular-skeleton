(function() {
    'use strict';

    angular
    .module('public.landingpage')
    .factory('landingpage.contentService' , contentService )

    function contentService( ) {

        var service    = {};
        service.getContent = getContent;

        return service;

        // Local functions follow

        function getContent() {

    		var data = {};
    		data['h1'] = "An AngularJS / FW1 skeleton app";
    		data['lead'] = "A POC illustrating how a modular angular app can be integrated with FW1 / Coldfusion "
            return data;
        }
    }

})();
