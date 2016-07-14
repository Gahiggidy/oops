<cfcomponent displayname="Signup Bean" output="false" accessors="true">

	<cfproperty name="signupId" type="numeric" default="0" />
	<cfproperty name="memberId" type="numeric" default="0" />
	<cfproperty name="tripId" type="numeric" default="0" />
	
	<cffunction name="init" access="public" output="false" returntype="any">
	
		<cfargument name="signupId" required="no" type="numeric" default="0" />
		<cfargument name="memberId" required="no" type="numeric" default="0" />
		<cfargument name="tripId" required="no" type="numeric" default="0" />
		
		<cfscript>
			variables.signupId = arguments.signupId;
			variables.memberId = arguments.memberId;
			variables.tripId = arguments.tripId;
		</cfscript>
		
		<cfreturn this />
		
	</cffunction>
	
</cfcomponent>