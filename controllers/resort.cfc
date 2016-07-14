<cfcomponent displayname="ResortController" output="false" accessors="true">

	<cfproperty name="resortGateway" />
	<cfproperty name="beanFactory" />
	
	<cfscript>
	 function init( fw ) {
        variables.fw = fw;
    }
	</cfscript>
	
	<cffunction name="list">
		
		<cfset rc.data = variables.resortGateway.getAllResorts() />
		
	</cffunction>
	
	<cffunction name="edit">
		
		<cfif IsDefined('rc.resortId')>
			<cfset rc.data = variables.resortGateway.getResortById(rc.resortId) />
			<cfset rc.pageTitle = "Update Ski Resort - #rc.data.getResortName()#" />
		<cfelse>
			<cfset rc.data = variables.beanFactory.getBean("resortBean") />
			<cfset rc.pageTitle = "Add New Ski Resort" />
		</cfif>
		
	</cffunction>
	
	<cfscript>
	    function save( rc ) {

		var resort = variables.beanFactory.getBean("resortBean").init(argumentCollection = FORM);
		
        variables.resortGateway.saveResort(resort);
        variables.fw.redirect( "resort.list" );
    }
	</cfscript>

</cfcomponent>