component  accessors="true" {

	property sessionservice;

	// we need the rules struct ordered, because it is searched for first match
	variables.rules = createObject("java", "java.util.LinkedHashMap").init(
		{
			'admin' : 4,
			'user' : 2,
			'public' : 1
		}
	)

	variables.roles = {
		"global" : {
			"name": "The Superaccount",
			"permissions": 15
		},
		"admin" : {
			"name": "Admin Account",
			"permissions": 7
		},
		"account" : {
			"name": "Standard Account",
			"permissions": 3
		},
		"anonymous" : {
			"name": "Public Account",
			"permissions": 1
		}
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
