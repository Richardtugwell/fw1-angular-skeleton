component accessors = true {

	property framework;
	property voteservice;
	property voterservice;
	property reportservice;
	property datauploadservice;

public any function default( rc  ) {

	}

public void function vote( rc ) {

	param name="rc.ID" default=#createUUID()#;
/*	if ( !isValid("UUID" , rc.ID)) {
		framework.redirect("admin/vote/ID/#createUUID()#");
		}	*/
	}

public void function votes( rc ) {

	rc.votes = voteService.getVotes();

}

public any function report( rc  ) {

	param name="rc.ID" default="0";
	}

// API METHODS

public void function getVotes( ) {

	param name="rc.IDvote" default="0";
	framework.renderData("JSON" , voteservice.getVotes( ) );

	}

public void function getVote( rc ) {

	param name="rc.ID" default=#createUUID()#;
	var vote = voteservice.getVote(  IDvote = rc.ID );
	framework.renderData("JSON" , vote  );

	}

public any function saveVote( rc  ) {
    var vote = deserializeJSON( rc.data );
    framework.renderdata("JSON" , voteservice.saveVote( vote )  );

	}

public any function uploadVoters( rc  ) {
	var ret = {};
	var errors = arrayNew(1);
	var result = fileUpload( "#expandpath('../tempuploads/')#" , "file" , "" , "overwrite");
	var file = result.serverfile;
	ret.errors = arrayNew(1);
	ret.success = false;
/*	try {
	var obj = SpreadsheetRead( "#expandpath('../tempuploads/')#" & file);
		} catch ( any _ )
			{
				arrayAppend( ret.errors , "Invalid File Format" );
			};*/
	var obj = SpreadsheetRead( "#expandpath('../tempuploads/')#" & file);
	if ( not arrayLen( ret.errors ) ) {
		errors = datauploadservice.checkSheetNames( obj , ret.errors , "users");
		}
	if ( not arrayLen( ret.errors ) ) {
		obj.setActiveSheet("users");
		errors = datauploadservice.checkSheetHeaders( obj , ret.errors , "email");
	}
	if ( not arrayLen( ret.errors ) ) {
		var attributes = datauploadservice.getSheetHeaders( obj );
		var newsheet = Spreadsheetnew();
		var users = newsheet.read(src="#expandpath('../tempuploads/')#" & file , sheetname="users" , query="q" , headerrow="1" , excludeheaderrow="true");
		var reviewers = voterservice.populate( IDvote = rc.IDvote , userquery = users ,  attributes = attributes );
		ret.success = true;
	}
	framework.renderdata("json" , ret);

}


public void function getVoters( rc ) {

	param name="rc.ID" default=#createUUID()#;
	var voters = voterservice.getVoters(  IDvote = rc.IDvote );
	framework.renderData("JSON" , voters  );

	}

public any function getAllVoteReportData( rc  ) {

	param name="rc.IDvote" default="0";
	param name="rc.filter" default="";

    framework.renderdata("json" , reportservice.getAllVoteReportData( IDvote = rc.IDvote , filter = rc.filter )  );

    }

}
