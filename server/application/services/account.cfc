component accessors = true	{

	property config;
	property emailservice;
	property sessionservice;
	property pbkdf2service;

public any function checkEmail( email ) {

	return !isNull( entityLoad("account" , {email = email} , "true" ) );

}

public any function getCurrentAccountPublicDetails(  ) {

	var account = entityLoad('account', {IDaccount = sessionservice.getIDaccount()} , "true" );
	var publicDetails = {};

	if ( isNull(account) ) {
		account = entityNew('account')
		publicDetails = account.getPublicDetails();
		publicDetails["authenticated"] = 0;
		publicDetails["authrole"] = "anonymous";
		return publicDetails;
		}
		else {
		publicDetails = account.getPublicDetails();
		publicDetails["authenticated"] = 1;

		}

		return publicDetails;

}

public any function getAccountFromEmail( email  ) {

	var account = entityload("account" , {email = rc.email} , "true");

	if ( !isNull(account)) {
		return account
		}

}

public any function register( data  ) {

	var message = structNew();

	var ret = structNew();
	var ret["errors"] = arrayNew(1);
	var ret["result"] = true;
	var ret["message"] = "ok";
	var maildata = structNew();
	/*regex min length 8 , >=1 uppercase, >=1 lowercase , >=1 number , >=1 special
	var pwdcheck = "^(?=.*[A-Z])(?=.*[!@##$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$";
	if (
		( structKeyExists( data , "password" ) )
		AND
		( !arrayLen(REmatch( pwdcheck ,  data.password )) )
		) { arrayappend(ret.errors , "password fails rules"); }
	*/
	if ( !structKeyExists( data , "firstname" ) ) { arrayappend(ret.errors , "firstname is required"); }
	if ( !structKeyExists( data , "lastname" ) ) { arrayappend(ret.errors , "lastname is required"); }
	if ( !structKeyExists( data , "email" ) ) { arrayappend(ret.errors , "email is required"); }
	if ( !structKeyExists( data , "password" ) ) { arrayappend(ret.errors , "password is required"); }
	if ( !structKeyExists( data , "confirmpassword" ) ) { arrayappend(ret.errors , "confirm password is required"); }
	if (
		( structKeyExists( data , "password" ) )
		AND
		( structKeyExists( data , "confirmpassword" ) )
		AND
		( data.password != data.confirmpassword )
		) { arrayappend(ret.errors , "passwords are not equal"); }

	if ( checkEmail( data.email ) )  {

		arrayappend(ret.errors , "duplicate email");
		}

	if ( arrayLen(ret.errors) ) {

		ret.result = false;
		ret.message = "validation errors";
		return ret;
		}


	try {
	var account = entityNew("account");
	account.setfirstname( data.firstname );
	account.setlastname( data.lastname );
	account.setidaccount( data.IDaccount );
	account.setpassword( pbkdf2service.hashpassword( password = data.password ) );
	account.setvalidemail(  data.token  );
	account.setpasswordreset(  createUUID() );
	account.setemail( data.email ) ;
	entitySave(account);
	ormFlush();
	maildata.subject = "Confirm Account";
	maildata.to = data.email;
	maildata.template = data.mailtemplate;
	result = emailservice.sendEmail( maildata );
	}
	catch ( any e ) {
		dump(var:e);abort;
		ret.result = false;
		ret.message = "Failed to register new account";
	}
	return ret;
}

	public any function authenticate( required string email , required string password  ) {

		var ret = structNew();
		ret["authenticated"] = false;
		ret["result"] = false;
		ret["message"] = "Invalid Login Credentials";
		var account = entityLoad('account', {email = email} , "true");
		if ( !isNull(account) AND pbkdf2service.checkpassword(attemptedPassword = trim( password ) , storedPassword = account.getPassword() ) ) {

			if ( account.getIsValid() ) {

				ret["authenticated"] = true;
				ret["result"] = true;
				ret.message="Valid Login Credentials";
				sessionService.setCredentials( account.getIDaccount() , account.getAuthrole() );
			}
			else
			{

			ret["result"] = false;
			ret["message"] = "Account validation is not complete. Please check your inbox";

			}

		}

		return ret;

	}

public any function confirmemail( token  ) {

	var ret = "failure";

	var account = entityLoad('account', {validemail=token} , "true");
			if ( !isNull(account) ) {
				if ( account.getIsValid() eq 1 ) {
					return "repeat";
				} else {
					account.setIsValid(1);
					entitySave(account);
					ormFlush();
					return "success";
					}
				}

	return ret;

}
public any function requestPasswordReset( data  ) {

	var ret = structNew();
	ret["result"]=false;

	var account = entityLoad('account', { email=data.email } , "true");

	account.setPasswordResetExpiry( dateAdd( 'n' , 30 , now() ));
	entitysave( account );
	ormFlush();
	var maildata = structNew();
	maildata.subject = "Intelligent Ranking password request";
	maildata.to = data.email;
	maildata.template = data.mailtemplate;
	ret.result = emailservice.sendEmail( maildata );

	return ret;

}

public any function resetPassword( data  ) {

	var ret = {};

	var passwordreset = toString( toBinary (data.token ) );

	var acc = entityload("account" , {passwordReset = passwordreset} , "true");

	if ( !isNull(acc)) {
		acc.setpassword( pbkdf2service.hashpassword( password = data.password ) );
		acc.setPasswordReset( createUUID() );
		entitySave(acc);
		ormFlush();
		ret = structNew();
		ret["result"] = true;
		ret["text"] = "Password successfully changed";
		ret["style"] = "success";
		return ret ;

	}
	else {
		ret = structNew();
		ret["result"] = false;
		ret["text"] = "An error occurred. Perhaps the reset link has expired or has already been used? (It is only valid once and for 30 mins";
		ret["style"] = "warning";
		return ret ;
	}
}

}
