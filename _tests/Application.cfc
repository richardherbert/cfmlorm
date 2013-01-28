component {

	this.applicationroot = ReReplace( getDirectoryFromPath( getCurrentTemplatePath() ), "_tests.$", "", "all" );
	this.name = ReReplace( "[^W]", this.applicationroot & "_tests", "", "all" );

	this.mappings[ "/model" ] = this.applicationroot & "model/";

	this.datasource = "cfmlorm";
	this.ormenabled = true;
	this.ormsettings = {
		flushatrequestend = false
		, automanagesession = false
		, cfclocation = this.mappings[ "/model" ]
		, useDBForMapping = false
	};
	
}