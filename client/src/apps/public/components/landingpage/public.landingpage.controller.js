(function() {
angular
	.module('public.landingpage')
	.controller('LandingpageController' , landingpageCtrl);

	landingpageCtrl.$inject = ['common.accountService' , 'landingpage.contentService'];

	function landingpageCtrl( accountService , contentService  ) {

		var vm = this;
		vm.content = contentService.getContent();
		};

})();
