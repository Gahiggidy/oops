<cfcomponent displayname="MemberDAO" output="false">

	<cfset variables.instance = {
			datasource = ''
		} />

	<cffunction name="init" access="public" output="false" returntype="any">
		
		<cfargument name="datasource" required="true" type="demo.beans.Datasource">
		
		<cfscript>
			variables.instance.datasource = arguments.datasource;
		</cfscript>
		
		<cfreturn this />
		
	</cffunction>
	
	<cffunction name="getMemberById" access="public" output="false">
	
		<cfargument name="memberId" required="yes" type="numeric">
		
		<cfset var qSearch = "">
		<cfset var objMember = "">
		
		<cfquery  name="qSearch"
			datasource="#variables.instance.datasource.getDSName()#"
			username="#variables.instance.datasource.getUsername()#"
			password="#variables.instance.datasource.getPassword()#">
			SELECT MemberId, firstName, lastName, email, joinDate, skiLevelId
			FROM member
			WHERE MemberId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.MemberId#">
		</cfquery>
		
		<cfif qSearch.recordcount>
			<cfset objMember = createObject('component', 'demo.beans.Member').init(
				MemberId = qSearch.memberId,
				firstName = qSearch.firstName,
				lastName = qSearch.lastName,
				email = qSearch.email,
				joinDate = qSearch.joinDate,
				skiLevelId = qSearch.skiLevelId) />
		</cfif>
		
		<cfreturn objMember />
		
	</cffunction>
	
	<cffunction name="deleteMemberById" access="public" output="false">
		
		<cfargument name="memberId" required="yes">
		
		<cfset var qDelete = '' />
		<cfset var boolSuccess = true />
		
		<cftry>
			<cfquery name="qDelete"
				datasource="#variables.instance.datasource.getDSName()#"
				username="#variables.instance.datasource.getUsername()#"
				password="#variables.instance.datasource.getPassword()#">
				DELETE FORM member
				WHERE memberId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberId#">
			</cfquery>
			<cfcatch type="database">
				<cfset boolSuccess = false />
			</cfcatch>
		</cftry>
		
		<cfreturn boolSuccess />
		
	</cffunction>
	
	<cffunction name="saveMember" access="public" output="false">
		
		<cfargument name="member" required="yes" type="demo.beans.member">
		
		<cfset var success = '' />
		
		<cfif exists(arguments.member)>
			<cfset success = updateMember(arguments.member) />
		<cfelse>
			<cfset success = createNewMember(arguments.member) />
		</cfif>
		
		<cfreturn success />
		
	</cffunction>
	
	<cffunction name="exists" access="public" output="false">
		
		<cfargument name="member" required="yes" type="demo.beans.Member">
		
		<cfset var qExists = '' />
		
		<cfquery name="qExists"
			datasource="#variables.instance.datasource.getDSName()#"
			username="#variables.instance.datasource.getUsername()#"
			password="#variables.instance.datasource.getPassword()#"
			maxrows="1">
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
		
		<cfargument name="member" required="yes" type="demo.beans.Member">
		
		<!---<cfdump var="#arguments.member.getFirstName()#">
		
		<cfabort>--->
		
		<cfset var qUpdate = '' />
		<cfset var boolSuccess = true />
		
		<cftry>
			<cfquery name="qUpdate"
				datasource="#variables.instance.datasource.getDSName()#"
				username="#variables.instance.datasource.getUsername()#"
				password="#variables.instance.datasource.getPassword()#">
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
		
		<cfargument name="member" required="yes" type="demo.beans.Member">
		
		<cfset var qInsert = '' />
		<cfset var insertResult = 0 />
		
		<cfquery name="qInsert"
			datasource="#variables.instance.datasource.getDSName()#"
			username="#variables.instance.datasource.getUsername()#"
			password="#variables.instance.datasource.getPassword()#"
			result="insertResult">
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

</cfcomponent>