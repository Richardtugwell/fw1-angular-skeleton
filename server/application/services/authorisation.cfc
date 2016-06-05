component  accessors="true" {

	property sessionservice;

	// we need the rules struct ordered, because it is searched for first match
	variables.rules = createObject("java", "java.util.LinkedHashMap").init() ;
	variables.rules['admin'] = 4;
	variables.rules['user'] = 2;
	variables.rules['public'] = 1;

	// if desired, we can use a roles structure to asign permissions (not implemnted)
	variables.roles = structNew() ;
	variables.roles["global"] = {
		"name": "The Superaccount",
		"permissions": 15
	}
	variables.roles["admin"] = {
		"name": "Admin Account",
		"permissions": 7
	}
	variables.roles["account"] = {
		"name": "Standard Account",
		"permissions": 3
	}
	variables.roles["anonymous"] = {
		"name": "Public Account",
		"permissions": 1
	}

	public struct function getRoles(){

		return variables.roles;
	}

	public struct function getRole( role ){

		return variables.roles[ role ];
	}

	public number function getPermissions( role ){

		return variables.roles[ role ].permissions;
	}

	public struct function getRules( ) {

		return variables.rules;
	}

	public struct function authorise( required string role , required string resource  ) {

		var ret = { };
		ret["authorised"] = false;
		ret["response"] = "ok";

		for (keyName in variables.rules) {
			// search the rules struct for a match on resource (the FW1 section) and return authorisation
			// (returning more details than necessary for debugging purposes )
			if ( REfindNOCASE( '^' & keyName & '$' , resource) ) {
				ret["authkey"] = keyName;
				ret["resource"] = resource;
				ret["permissions"] = getPermissions( role );
				ret["role"] = role;
				ret["authorised"] = bitAnd( variables.rules[ keyName ] , getPermissions( role ) ) gt 0;
			}
		}

		if (!ret["authorised"]) {
			ret["response"] = sessionService.isLoggedIn() ? "unauthorised" : "needlogin";
		}

		return ret;

	}

}
