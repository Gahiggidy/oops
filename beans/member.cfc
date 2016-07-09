<cfcomponent displayname="Club Member" output="false" accessors="true">

	<cfproperty name="memberId" type="numeric" default="0" />
	<cfproperty name="firstName" type="string" default="" />
	<cfproperty name="lastName" type="string" default="" />
    <cfproperty name="email" type="string" default="" />
	<cfproperty name="joinDate" type="date" default="" />
	<cfproperty name="skiLevelId" type="numeric" default="0" />
	
	<cffunction name="init" access="public" output="false" returntype="any">
	
		<cfargument name="memberId" required="yes" type="numeric" default="0" />
		<cfargument name="firstName" required="yes" type="string" default="" />
		<cfargument name="lastName" required="yes" type="string" default="" />
		<cfargument name="email" required="yes" type="string" default="" />
		<cfargument name="joinDate" required="yes" type="date" default="#now()#" />
		<cfargument name="skiLevelId" required="yes" type="numeric" default="0" />
		
		<cfscript>
			variables.memberId = arguments.memberId;
			variables.firstName = arguments.firstName;
			variables.lastName = arguments.lastName;
			variables.email = arguments.email;
			variables.joinDate = arguments.joinDate;
			variables.skiLevelId = arguments.skiLevelId;
		</cfscript>
		
		<cfreturn this />
		
	</cffunction>
	
	<cffunction name="getFullName" access="public" output="false">
		<cfset strFullName = variables.firstName & ' ' & variables.lastName />
		<cfreturn strFullName />
	</cffunction>
	
	<cffunction name="getMemento" access="public">
		<cfreturn variables />
	</cffunction>

</cfcomponent>