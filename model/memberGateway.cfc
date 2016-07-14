<cfcomponent displayname="MemberGateway" output="false" accessors="true">

	<cfproperty name="beanFactory" />
	
	<cffunction name="getMemberById" access="public" output="false">
	
		<cfargument name="memberId" required="yes" type="numeric">
		
		<cfset var qSearch = "">
		<cfset var objMember = "">
		
		<cfquery name="qSearch">
			SELECT MemberId, firstName, lastName, email, joinDate, skiLevelId
			FROM member
			WHERE MemberId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.MemberId#">
		</cfquery>
		
		<cfif qSearch.recordcount>
			<cfset objMember = variables.beanFactory.getBean("memberBean").init(
				MemberId = qSearch.memberId,
				firstName = qSearch.firstName,
				lastName = qSearch.lastName,
				email = qSearch.email,
				joinDate = qSearch.joinDate,
				skiLevelId = qSearch.skiLevelId) />
		</cfif>
		
		<cfreturn objMember />
		
	</cffunction>
	
	<cffunction name="saveMember" access="public" output="false">
		
		<cfargument name="member" required="yes" type="beans.member">
		
		<cfset var success = '' />
		
		<cfif exists(arguments.member)>
			<cfset success = updateMember(arguments.member) />
		<cfelse>
			<cfset success = createNewMember(arguments.member) />
		</cfif>
		
		<cfreturn success />
		
	</cffunction>
	
	<cffunction name="exists" access="public" output="false">
		
		<cfargument name="member" required="yes" type="beans.Member">
		
		<cfset var qExists = '' />
		
		<cfquery name="qExists" maxrows="1">
			SELECT count(1) as idExists
			FROM member
			WHERE memberId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.member.getMemberId()#">
		</cfquery>
		
		<cfif qExists.idExists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>			
					
	</cffunction>
	
	<cffunction name="updateMember" access="public" output="false">
		
		<cfargument name="member" required="yes" type="beans.Member">
		
		<cfset var qUpdate = '' />
		<cfset var boolSuccess = true />
		
		<cftry>
			<cfquery name="qUpdate">
				UPDATE member
				SET
				firstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getFirstName()#">,
				lastName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getLastName()#">,
				email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getEmail()#">,
				joinDate = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.member.getJoinDate()#">,
                skiLevelId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.member.getSkiLevelId()#">
				WHERE memberId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.member.getMemberId()#">
			</cfquery>
			<cfcatch type="database">
				<cfset boolSuccess = false />
			</cfcatch>
		</cftry>
		
		<cfreturn boolSuccess />
		
	</cffunction>
	
	<cffunction name="createNewMember" access="public" output="false">
		
		<cfargument name="member" required="yes" type="beans.Member">
		
		<cfset var qInsert = '' />
		<cfset var insertResult = 0 />
		
		<cfquery name="qInsert" result="insertResult">
			INSERT INTO Member(
				firstName, lastName, email, joinDate, skiLevelId)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getFirstName()#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getLastName()#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getEmail()#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getJoinDate()#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.member.getSkiLevelId()#">
			)
		</cfquery>
		
		<cfreturn insertResult.generatedkey />		
		
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
		
		<cfquery name="qSearch">
			SELECT MemberId, firstName, lastName, email, joinDate, m.skiLevelId, s.skiLevel
			FROM member m
			LEFT JOIN skiLevel s
			ON m.skiLevelId = s.skiLevelId
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