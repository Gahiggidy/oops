<cfcomponent displayname="Datasource" output="false">
	
	<cfproperty name="DSName" type="string" default="" />
	<cfproperty name="username" type="string" default="" />
	<cfproperty name="password" type="string" default="" />
	
	<cfset variables.instance = {
			DSName = '',
			username = '',
			password = ''
		} />
	
	<cffunction name="init" access="public" output="false">
		
		<cfargument name="DSName" required="yes" type="string">
		<cfargument name="username" required="yes" type="string">
		<cfargument name="password" required="yes" type="string">
		
		<cfscript>
			variables.instance.DSName = arguments.DSName;
			variables.instance.username = arguments.username;
			variables.instance.password = arguments.password;
		</cfscript>
		
		<cfreturn this />
	
	</cffunction>
	
	<cffunction name="getDSName" access="public" output="false">
		<cfreturn variables.instance.DSName />
	</cffunction>

	<cffunction name="getUsername" access="public" output="false">
		<cfreturn variables.instance.username />
	</cffunction>
	
	<cffunction name="getPassword" access="public" output="false">
		<cfreturn variables.instance.password />
	</cffunction>

</cfcomponent>