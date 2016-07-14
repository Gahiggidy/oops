<cfcomponent displayname="Resort Bean" output="false" accessors="true">

	<cfproperty name="resortId" type="numeric" default="0" />
	<cfproperty name="resortName" type="string" default="" />
	
	<cffunction name="init" access="public" output="false" returntype="any">
	
		<cfargument name="resortId" required="no" type="numeric" default="0" />
		<cfargument name="resortName" required="no" type="string" default="" />
		
		<cfscript>
			variables.resortId = arguments.resortId;
			variables.resortName = arguments.resortName;
		</cfscript>
		
		<cfreturn this />
		
	</cffunction>
	
</cfcomponent>