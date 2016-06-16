component extends="framework.one" {

	// FW/1 - configuration:
	variables.framework = {
		base : "/application/fw1/" ,
		dilocations : '/application/services',
		error : 'public.error',
		reloadApplicationOnEveryRequest : true,
		enableJSONPOST : true,
        generateSES : true,
        SESOmitIndex : true,
		routes = [ //simple route definintions, mainly to map /api/ endpoints
		  { "/api/:section/:item/:test" = "/api::section/:item/:test/" },
		  { "/api/:section/:item" = "/api::section/:item/" },
		  { "/:section/:item" = "/:section/:item/" },
		  { "/:section" = "/:section/default/" },
		  { "*" = "/public/default/" }
		]
	}

	function before( struct rc ) {
	}
	function setupRequest() {
//		dump (var:getbeanfactory().getbeaninfo());abort;

		request.context.FW1Version = framework.version;
		request.context.LuceeVersion = "4.5.3.001";
		var authService = getBeanfactory().getBean( "authorisation" );
		var sessionService = getBeanfactory().getBean( "session" ) ;
		var accountRole = sessionService.getRole();

    if (structKeyexists(URL,"trace")) {
			variables.framework.trace = "true";
			}
    if (structKeyexists(URL,"ORMreload")) {
			ORMFlush();
			ORMReload();
			}
    if (structKeyexists(URL,"killsession")) {
			structClear(session);
			redirect('public.default');
			}
		if (structKeyexists(URL,"ORMreloadFull")) {
			ORMFlush();
			ORMReload();
			structClear(session);
			redirect('public.default');
			}

    var authresult = authService.authorise( accountRole , getSection() );
//	dump(var:authresult);abort;
    if ( !authresult.authorised ) {
			if ( getSubsystem() eq 'api' ) {
				redirect(action = 'api:public.unauthorised');
			}
			else if ( authresult.response eq "needlogin") {
				redirect(action = 'public.default');
			}
			else if ( authresult.response eq "unauthorised") {
				redirect(action = 'public.default' , queryString ='##/unauthorised');
			}
		}
    }

	function onMissingView() {
//		redirect(action = 'public.default' , queryString ='##/404');

    }

	function failure( exception, event ) { // "private"

		if ( structKeyExists(exception, 'rootCause') ) {
			exception = exception.rootCause;
		}
		writeOutput( '<h1>Something bad happened in #event#</h1>' );
		if ( structKeyExists( request, 'failedAction' ) ) {
			writeOutput( '<p>The action #request.failedAction# failed.</p>' );
		}
		writeOutput( '<h2>#exception.message#</h2>' );
		writeOutput( '<p>#exception.detail# (#exception.type#)</p>' );
		dumpException(exception);
		//	dumpException(session);
		//	dumpException(request);

	}

}
