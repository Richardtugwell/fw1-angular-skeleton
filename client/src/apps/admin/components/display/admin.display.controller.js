(function() {
	angular
		.module('admin.display')
		.controller('DisplayController' , displayCtrl);

	displayCtrl.$inject = ['adminService'];

	function displayCtrl( adminService ) {

		var vm = this;
		adminService.getData().then( function(data) {
			vm.data = data;
		});

	};

})();
