component accessors = true	{

	property config;

	public any function init( ) {

		variables.from = "r.tugwell@forthmedia.com";

	}

	public any function sendEmail( data ) {

		var mailer = new mail();
		mailer.setServer("127.0.0.1");
		mailer.setSubject( data.subject );
		mailer.setFrom( variables.from );
		mailer.setTo( data.to );
		mailer.setBody( data.template );
		mailer.setType( "html" );
		mailer.send( );

		return true;
	}


}
