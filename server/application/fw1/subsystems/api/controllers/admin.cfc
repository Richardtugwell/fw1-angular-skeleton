component accessors = true {

	property framework;
	public void function getData() {

		var data = {};

		data['h1'] = "Hello, I'm the Admin App";
		data['p'] = "I should only be accessible to users with at least Admin privileges. Others should get 'unauthorised' if they access this endpoint"

		framework.renderData('JSON', data );

	}


}
