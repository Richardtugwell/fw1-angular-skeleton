component accessors = true {

	property framework;

	public void function getData() {

		var data = {};

		data['h1'] = "Hello, I'm the User App";
		data['p'] = "I should only be accessible to logged-in users. Others should get 'unauthorised' if they access this endpoint"

		framework.renderData('JSON', data );

	}


}
