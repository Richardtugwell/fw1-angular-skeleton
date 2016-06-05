component accessors="true" {

	property authorisationservice;

	public any function getMainAccountMenu( role ) {

		// just hard code a menu structure for now
		var menuitems =
			[
				{'name':'Admin' , 'link':  'admin'},
				{'name':'User' , 'link':  'user'}
			];

		var accountmenuitems = [];

		// if role is authorised for the resource, add the menu item
		for (var item in menuitems ) {
			var resource = listFirst( item.link , '/');
        	if (authorisationservice.authorise( arguments.role, resource ).authorised ) {
					arrayAppend(accountmenuitems, item);
				}
		}

		return accountmenuitems;

	}
}
