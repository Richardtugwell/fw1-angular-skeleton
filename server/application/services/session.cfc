component {

	public any function isLoggedIn(  ) {

	    if ( structKeyExists( session , "IDaccount" ) )
	    	{
	    	if ( len( trim( session['IDaccount'] ) ) )
	    		{
				return true;
	    		}
	    	}
	    return false;

	}

	public any function setCredentials( IDaccount , authrole  ) {

	    session["IDaccount"] = IDaccount;
	    session["authrole"] = authrole;

	    }

	public any function getIDaccount(  ) {

	    if ( structKeyExists( session , "IDaccount" ) )
	    	{
	    	if ( len( trim( session['IDaccount'] ) ) )
	    		{
				return session['IDaccount'];
	    		}
	    	else
	    		return 0;
	    	}

	    }
	public any function getRole(  ) {

	    if ( structKeyExists( session , "authrole" ) )
	    	{
	    	if ( len( trim( session['authrole'] ) ) )
	    		{
				return session['authrole'];
	    		}
	    	else
	    		return 'anonymous';
	    	}
				return 'anonymous';


	    }

}
