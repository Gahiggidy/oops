<cfcomponent displayname="MemberController" output="false" accessors="true">

	<cfproperty name="memberGateway" />
	<cfproperty name="member" />
	<cfproperty name="beanFactory" />
	
	<cfscript>
	 function init( fw ) {
        variables.fw = fw;
    }
	</cfscript>
	
	<cffunction name="list">
		
		<cfset rc.data = variables.memberGateway.filterAllMembers() />
		
	</cffunction>
	
	<cffunction name="edit">
		
		<cfif IsDefined('rc.memberId')>
			<cfset rc.data = variables.memberGateway.getMemberById(rc.memberId) />
			<cfset rc.pageTitle = "Update Club Member - #rc.data.getFirstName()# #rc.data.getLastName()#" />
		<cfelse>
			<cfset rc.data = variables.beanFactory.getBean("member") />
			<cfset rc.pageTitle = "Add New Club Member" />
		</cfif>
		
	</cffunction>
	
	<cfscript>
	    function save( rc ) {

		var member = variables.beanFactory.getBean("member").init(argumentCollection = FORM);
		
        variables.memberGateway.saveMember(member);
        variables.fw.redirect( "member.list" );
    }
	</cfscript>

</cfcomponent>