<cfcomponent displayname="MemberService" output="false" accessors="true">

	<cfproperty name="memberGateway" />
	
	<cfscript>
	 function init( fw ) {
        variables.fw = fw;
    }
	</cfscript>
	
	<cffunction name="list">
		
		<cfset rc.data = variables.memberGateway.filterAllMembers() />
		
	</cffunction>
	
	<cffunction name="edit">
		
		<cfset rc.data = variables.memberGateway.getMemberById(rc.memberId) />
		
	</cffunction>
	
	<cfscript>
	    function save( rc ) {

		var member = createobject('component', 'model.beans.member').init(argumentCollection = FORM);
		
        //variables.fw.populate( cfc = user, trim = true );
        variables.memberGateway.saveMember(member);
        //variables.userService.save( user );
        variables.fw.redirect( "member.list" );
    }
	</cfscript>

	<cffunction name="delete">
		
		<cfset rc.data = variables.memberGateway.deletMemberById(rc.memberId) />
	
	</cffunction>
		
	<cffunction name="filterByLastName" access="public" output="false">
	
		<cfargument name="lastNameFilter" required="yes" type="string">
		
		<cfset var stuFilter = { lastname = arguments.lastNameFilter } />
		
		<cfreturn variables.memberGateway.filterAllMembers(stuFilter) />		
		
	</cffunction>
	
	<cffunction name="filterByEmailAddress" access="public" output="false">
		
		<cfargument name="emailAddress" required="yes" type="string">
		
		<cfset var stuFilter = { emailAddress = arguments.emailAddress} />
	
		<cfreturn variables.memberGateway.filterAllMembers(stuFilter) />
		
	</cffunction>

</cfcomponent>