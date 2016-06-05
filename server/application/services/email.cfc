component accessors = true	{

	// property config; config service not implemented yet

	public any function init( ) {

		//TODO: should get this from some config file
		variables.from = "r.tugwell@forthmedia.com";
		variables.SMTP = "127.0.0.1";
		variables.user = "";
		variables.psddeord = "";

	}

	public any function sendEmail( data ) {

		var mailer = new mail();
		mailer.setServer( variables.SMTP );
		mailer.setSubject( data.subject );
		mailer.setFrom( variables.from );
		mailer.setTo( data.to );
		mailer.setBody( data.template );
		mailer.setType( "html" );
		mailer.send( );

		//TODO: should return something meaningful
		return true;
	}


}
