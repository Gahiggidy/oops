<cfcomponent displayname="TripGateway" output="false" accessors="true">

	<cfproperty name="beanFactory" />
	
	<cffunction name="getTripById" access="public" output="false">
	
		<cfargument name="tripId" required="yes" type="numeric">
		
		<cfset var qSearch = "">
		<cfset var objTrip = "">
		
		<cfquery name="qSearch">
			SELECT tripId, tripName, resortId, startDate, endDate, tripLeaderMemberId, tripAssistantMemberId
			FROM trip
			WHERE TripId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.TripId#">
		</cfquery>
		
		<cfif qSearch.recordcount>
			<cfset objTrip = variables.beanFactory.getBean("tripBean").init(
				tripId = qSearch.tripId,
				tripName = qSearch.tripName,
				resortId = qSearch.resortId,
				startDate = qSearch.startDate,
				endDate = qSearch.endDate,
				tripLeaderMemberId = qSearch.tripLeaderMemberId,
				tripAssistantMemberId = qSearch.tripAssistantMemberId) />
		</cfif>
		
		<cfreturn objTrip />
		
	</cffunction>
	
	<cffunction name="saveTrip" access="public" output="false">
		
		<cfargument name="trip" required="yes" type="beans.trip">
		
		<cfset var success = '' />
		
		<cfif exists(arguments.trip)>
			<cfset success = updateTrip(arguments.trip) />
		<cfelse>
			<cfset success = createNewTrip(arguments.trip) />
		</cfif>
		
		<cfreturn success />
		
	</cffunction>
	
	<cffunction name="exists" access="public" output="false">
		
		<cfargument name="trip" required="yes" type="beans.Trip">
		
		<cfset var qExists = '' />
		
		<cfquery name="qExists" maxrows="1">
			SELECT count(1) as idExists
			FROM trip
			WHERE tripId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getTripId()#">
		</cfquery>
		
		<cfif qExists.idExists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>			
					
	</cffunction>
	
	<cffunction name="updateTrip" access="public" output="false">
		
		<cfargument name="trip" required="yes" type="beans.Trip">
		
		<cfset var qUpdate = '' />
		<cfset var boolSuccess = true />
		
		<cftry>
			<cfquery name="qUpdate">
				UPDATE trip
				SET
				tripName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.trip.getTripName()#">,
				resortId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getResortId()#">,
                startDate = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.trip.getStartDate()#">,
                endDate = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.trip.getEndDate()#">,
                tripLeaderMemberId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getTripLeaderMemberId()#">,
                tripAssistantMemberId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getTripAssistantMemberId()#">
				WHERE tripId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getTripId()#">
			</cfquery>
			<cfcatch type="database">
				<cfset boolSuccess = false />
			</cfcatch>
		</cftry>
		
		<cfreturn boolSuccess />
		
	</cffunction>
	
	<cffunction name="createNewTripSignup" access="public" output="false">
		
		<cfargument name="signup" required="yes" type="beans.Signup">
		
		<cfset var qInsert = '' />
		<cfset var insertResult = 0 />
		
		<cfquery name="qInsert" result="insertResult">
			INSERT INTO signUp(
				tripId, memberId)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.signup.getTripId()#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.signup.getMemberId()#">
			)
		</cfquery>
		
		<cfreturn insertResult.generatedkey />		
			
	</cffunction>
	
	
	<cffunction name="createNewTrip" access="public" output="false">
		
		<cfargument name="trip" required="yes" type="beans.Trip">
		
		<cfset var qInsert = '' />
		<cfset var insertResult = 0 />
		
		<cfquery name="qInsert" result="insertResult">
			INSERT INTO Trip(
				tripName, resortId, startDate, endDate, tripLeaderMemberId, tripAssistantMemberId)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.trip.getTripName()#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getResortId()#">,
			<cfqueryparam cfsqltype="cf_sql_date" value="#arguments.trip.getStartDate()#">,
			<cfqueryparam cfsqltype="cf_sql_date" value="#arguments.trip.getEndDate()#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getTripLeaderMemberId()#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.trip.getTripAssistantMemberId()#">
			)
		</cfquery>
		
		<cfreturn insertResult.generatedkey />		
		
	</cffunction>
	
	
	<cffunction name="getAllTrips" access="public" output="false">	
		<cfreturn filterAllTrips() />
	</cffunction>
	
	<cffunction name="filterTripSignupsByTripId" access="public" output="false">
		
		<cfargument name="tripId" required="yes" type="numeric">
		
		<cfset stuFilter = { tripId = arguments.tripId } />
	
		<cfreturn filterAllTripSignups(stuFilter) />
		
	</cffunction>
	
	<cffunction name="filterAllTripSignups" access="public" output="false">
		
		<cfargument name="filter" required="no" type="struct" default="#structNew()#">
		
		<cfset var qSearch = '' />
		
		<cfquery name="qSearch">
			SELECT t.tripId, tripName, resortId, startDate, endDate, tripLeaderMemberId, tripAssistantMemberId
			, firstName, lastName, email, m.skiLevelId, m.memberId, sl.skiLevel
			FROM trip t
			LEFT JOIN signUp s
			ON t.tripId = s.tripId
			INNER JOIN member m
			ON s.memberId = m.memberId
			LEFT JOIN skiLevel sl
			ON m.skiLevelId = sl.skiLevelId
			WHERE 1 = 1
			<cfif NOT structIsEmpty(arguments.filter)>
				<cfif structKeyExists(arguments.filter, 'tripId')>
					AND s.tripId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.filter.tripId#">
				</cfif>
			</cfif>
		</cfquery>
		
		<cfreturn qSearch />
		
	</cffunction>
	
	<cffunction name="filterAllTrips" access="public" output="false">
	
		<cfargument name="filter" required="no" type="struct" default="#structNew()#">
		
		<cfset var qSearch = '' />
		
		<cfquery name="qSearch">
			SELECT tripId, tripName, t.resortId, startDate, endDate, tripLeaderMemberId, tripAssistantMemberId
			, tl.firstName AS tripLeaderFirstName, tl.lastName AS tripLeaderLastName
			, ta.firstName AS tripAssitantFirstName, ta.lastName AS tripAssitantLastName
			, resortName
			FROM trip t
			LEFT JOIN member tl
			ON t.tripLeaderMemberId = tl.memberId
			LEFT JOIN member ta
			ON t.tripAssistantMemberId = ta.memberId
			LEFT JOIN resort r
			ON t.resortId = r.resortId
			WHERE 1 = 1
			<cfif NOT structIsEmpty(arguments.filter)>
				<cfif structKeyExists(arguments.filter, 'tripName')>
					AND tripName like <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.tripName#">
				</cfif>
			</cfif>
		</cfquery>
		
		<cfreturn qSearch />
		
	</cffunction>
	
</cfcomponent>