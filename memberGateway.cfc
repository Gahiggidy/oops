<cfcomponent displayname="MemberGateway" output="false">

	<cfset variables.instance = { datasource = '' } />
	
	<cffunction name="init" output="false" returntype="any">
	
		<cfargument name="datasource" required="yes" type="demo.beans.Datasource">
		
		<cfscript>
			variables.instance.datasource = arguments.datasource;
		</cfscript>
		
		<cfreturn this />
	
	</cffunction>
	
	<cffunction name="getAllMembers" access="public" output="false">	
		<cfreturn filterAllMembers() />
	</cffunction>
	
	<cffunction name="filterByLastName" access="public" output="false">
		
		<cfargument name="lastNameFilter" required="yes" type="string">
		
		<cfset stuFilter = { lastName = arguments.lastNameFilter} />
	
		<cfreturn filterAllMembers(stuFilter) />
		
	</cffunction>
	
	<cffunction name="filterByEmail" access="public" output="false">
		
		<cfargument name="email" required="yes" type="string">
		
		<cfset stuFilter = { emailAddress = arguments.email} />
	
		<cfreturn filterAllMembers(stuFilter) />
		
	</cffunction>
	
	<cffunction name="filterAllMembers" access="public" output="false">
	
		<cfargument name="filter" required="no" type="struct" default="#structNew()#">
		
		<cfset var qSearch = '' />
		
		<cfquery name="qSearch"
			datasource="#variables.instance.datasource.getDSName()#"
			username="#variables.instance.datasource.getUsername()#"
			password="#variables.instance.datasource.getPassword()#">
			SELECT MemberId, firstName, lastName, email, joinDate, skiLevelId
			FROM member
			WHERE 1 = 1
			<cfif NOT structIsEmpty(arguments.filter)>
				<cfif structKeyExists(arguments.filter, 'lastName')>
					AND lastName like <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.lastName#">
				</cfif>
				<cfif structKeyExists(arguments.filter, 'email')>
					AND email like <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.email#">
				</cfif>
			</cfif>
		</cfquery>
		
		<cfreturn qSearch />
		
	</cffunction>
	
</cfcomponent>