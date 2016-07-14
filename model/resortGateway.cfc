<cfcomponent displayname="ResortGateway" output="false" accessors="true">

	<cfproperty name="beanFactory" />
	
	<cffunction name="getResortById" access="public" output="false">
	
		<cfargument name="resortId" required="yes" type="numeric">
		
		<cfset var qSearch = "">
		<cfset var objResort = "">
		
		<cfquery name="qSearch">
			SELECT ResortId, resortName
			FROM resort
			WHERE ResortId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ResortId#">
		</cfquery>
		
		<cfif qSearch.recordcount>
			<cfset objResort = variables.beanFactory.getBean("resortBean").init(
				ResortId = qSearch.resortId,
				resortName = qSearch.resortName) />
		</cfif>
		
		<cfreturn objResort />
		
	</cffunction>
	
	<cffunction name="saveResort" access="public" output="false">
		
		<cfargument name="resort" required="yes" type="beans.resort">
		
		<cfset var success = '' />
		
		<cfif exists(arguments.resort)>
			<cfset success = updateResort(arguments.resort) />
		<cfelse>
			<cfset success = createNewResort(arguments.resort) />
		</cfif>
		
		<cfreturn success />
		
	</cffunction>
	
	<cffunction name="exists" access="public" output="false">
		
		<cfargument name="resort" required="yes" type="beans.Resort">
		
		<cfset var qExists = '' />
		
		<cfquery name="qExists" maxrows="1">
			SELECT count(1) as idExists
			FROM resort
			WHERE resortId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.resort.getResortId()#">
		</cfquery>
		
		<cfif qExists.idExists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>			
					
	</cffunction>
	
	<cffunction name="updateResort" access="public" output="false">
		
		<cfargument name="resort" required="yes" type="beans.Resort">
		
		<cfset var qUpdate = '' />
		<cfset var boolSuccess = true />
		
		<cftry>
			<cfquery name="qUpdate">
				UPDATE resort
				SET
				resortName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.resort.getResortName()#">
				WHERE resortId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.resort.getResortId()#">
			</cfquery>
			<cfcatch type="database">
				<cfset boolSuccess = false />
			</cfcatch>
		</cftry>
		
		<cfreturn boolSuccess />
		
	</cffunction>
	
	<cffunction name="createNewResort" access="public" output="false">
		
		<cfargument name="resort" required="yes" type="beans.Resort">
		
		<cfset var qInsert = '' />
		<cfset var insertResult = 0 />
		
		<cfquery name="qInsert" result="insertResult">
			INSERT INTO Resort(
				resortName)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.resort.getResortName()#">
			)
		</cfquery>
		
		<cfreturn insertResult.generatedkey />		
		
	</cffunction>
	
	
	<cffunction name="getAllResorts" access="public" output="false">	
		<cfreturn filterAllResorts() />
	</cffunction>
	
	<cffunction name="filterAllResorts" access="public" output="false">
	
		<cfargument name="filter" required="no" type="struct" default="#structNew()#">
		
		<cfset var qSearch = '' />
		
		<cfquery name="qSearch">
			SELECT ResortId, resortName
			FROM resort
			WHERE 1 = 1
			<cfif NOT structIsEmpty(arguments.filter)>
				<cfif structKeyExists(arguments.filter, 'resortName')>
					AND resortName like <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.resortName#">
				</cfif>
			</cfif>
		</cfquery>
		
		<cfreturn qSearch />
		
	</cffunction>
	
</cfcomponent>