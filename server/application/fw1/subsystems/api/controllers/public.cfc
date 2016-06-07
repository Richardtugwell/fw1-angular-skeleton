component accessors = true {

	property framework;
	property menuservice;
	property accountservice;
	property sessionservice;

	public void function getaccount() {

		var ret = {};
		var account = accountservice.getCurrentAccountPublicDetails();
		var menu = menuservice.getMainAccountMenu( account.authrole );
		var ret = account;
		var ret['menu'] = menu;
		framework.renderData('JSON', ret );
	}

	public any function register( rc  ) {

		param name="rc.email" default="";
		param name="rc.firstname" default="";
		param name="rc.lastname" default="";
		param name="rc.password" default="";
		param name="rc.confirmpassword" default="";

		var data = rc;

		data.IDaccount = createUUID();
		data.token = hash( data.IDaccount );
		data.mailtemplate = framework.view(":email/confirmemail" , { token = data.token } );
		framework.renderData("JSON" , accountservice.register( data ) );

		}

	public any function requestPasswordReset( rc  ) {

		param name="rc.email" default="";

		var ret = structNew();
		ret.msg = "";
		ret["result"] = false;
		var account = entityload("account" , {email = rc.email} , "true");

		if ( !isNull(account)) {

			var token = toBase64( account.getPasswordReset( )  ) ;
			var data = {
				email=rc.email,
				mailtemplate = framework.view(":email/requestPasswordReset" , { token = token })
			 };
			ret = accountservice.requestPasswordReset( data );
		}
		else ret.msg = "Account not found";

		framework.renderdata("JSON" , ret);

		}

	public any function resetPassword( rc  ) {

		param name="rc.token" default="";

		framework.renderData("JSON" , accountservice.resetPassword( rc ));

	}

	public any function authenticate( rc  ) {

		framework.renderData("JSON" , accountservice.authenticate( email = rc.email , password = rc.password ));

	}

	public any function confirmemail( rc  ) {

		param name="rc.token" default="";

		framework.renderdata("JSON" , accountservice.confirmemail( rc.token ) );

	}

}
