component accessors = true {

	property framework;

	public void function default() {

		// In case you need to do something before returning the app default

	}

	public void function logout() {

		structClear(session);
		framework.redirect( action = "public" );

	}

}
