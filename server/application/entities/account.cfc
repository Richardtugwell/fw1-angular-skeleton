component  output="false" persistent="true" table="taccounts" {

    property name="ID" fieldtype="id" generator="native";
    property name="IDaccount" ormtype="string" unique="true" ;
    property name="firstname" ormtype="string" ;
    property name="lastname" ormtype="string" ;
    property name="password" ormtype="string" ;
    property name="email" ormtype="string" unique="true"    ;
    property name="authrole" ormtype="string" default="admin"    ;
    property name="validemail" ormtype="string" ;
    property name="passwordreset" ormtype="string" ;
    property name="passwordresetexpiry" ormtype="timestamp" default=#now()# ;
    property name="isValid" ormtype="integer" default=0 ;

	public any function getPublicDetails( ) {

        var ret = {};

        ret["firstname"] = getFirstname();
        ret["lastname"] = getLastname();
        ret["email"] = getEmail();
        ret["authrole"] = getAuthrole();

		return ret;

	}



}
