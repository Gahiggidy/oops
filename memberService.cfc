<cfcomponent displayname="MemberService" output="false" extends="core">

	<cfset variables.instance = {
		memberDAO = '',
		memberGW = ''
		} />
	
	<cffunction name="init" access="public" output="false">
	
		<cfargument name="datasource" required="yes" type="demo.beans.Datasource">
		
		<cfscript>
			variables.instance.memberDAO = createObject('component', 'memberDAO').init(arguments.datasource);
			variables.instance.memberGW = createObject('component', 'memberGateway').init(arguments.datasource);
		</cfscript>
		
		<cfreturn this />
	
	</cffunction>
	
	<cffunction name="save" access="public" output="false">
		
		<cfargument name="member" required="yes" type="demo.beans.Member">
		
		<cfreturn variables.instance.memberDAO.saveMember(arguments.member) />
	
	</cffunction>
	
	<cffunction name="read" access="public" output="false">
		
		<cfargument name="memberId" required="yes" type="numeric">
		
		<cfreturn variables.instance.memberDAO.getMemberById(arguments.memberId) />
	
	</cffunction>
	
	<cffunction name="delete" access="public" output="false">
		
		<cfargument name="memberId" required="yes" type="numeric">
		
		<cfreturn variables.instance.memberDAO.deleteMemberById(arguments.memberId) />
	
	</cffunction>
	
	<cffunction name="getAllMembers" access="public" output="false">
		<cfreturn variables.instance.memberGW.filterAllMembers() />	
	</cffunction>
	
	<cffunction name="filterByLastName" access="public" output="false">
	
		<cfargument name="lastNameFilter" required="yes" type="string">
		
		<cfset var stuFilter = { lastname = arguments.lastNameFilter } />
		
		<cfreturn variables.instance.memberGW.filterAllMembers(stuFilter) />		
		
	</cffunction>
	
	<cffunction name="filterByEmailAddress" access="public" output="false">
		
		<cfargument name="emailAddress" required="yes" type="string">
		
		<cfset var stuFilter = { emailAddress = arguments.emailAddress} />
	
		<cfreturn variables.instance.userGW.filterAllMembers(stuFilter) />
		
	</cffunction>

</cfcomponent>