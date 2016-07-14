<cfcomponent displayname="Trip Bean" output="false" accessors="true">

	<cfproperty name="tripId" type="numeric" default="0" />
	<cfproperty name="tripName" type="string" default="" />
	<cfproperty name="resortId" type="string" default="0" />
    <cfproperty name="startDate" type="date" default="" />
    <cfproperty name="endDate" type="date" default="" />
    <cfproperty name="tripLeaderMemberId" type="numeric" default="0" />
    <cfproperty name="tripAssistantMemberId" type="numeric" default="0" />
	
	<cffunction name="init" access="public" output="false" returntype="any">
	
		<cfargument name="tripId" required="no" type="numeric" default="0" />
		<cfargument name="tripName" required="no" type="string" default="" />
		<cfargument name="resortId" required="no" type="string" default="0" />
        <cfargument name="startDate" required="no" type="date" default="#now()#" />
        <cfargument name="endDate" required="no" type="date" default="#now()#" />
        <cfargument name="tripLeaderMemberId" required="no" type="numeric" default="0" />
        <cfargument name="tripAssistantMemberId" required="no" type="numeric" default="0" />
		
		<cfscript>
			variables.tripId = arguments.tripId;
			variables.tripName = arguments.tripName;
			variables.resortId = arguments.resortId;
			variables.startDate = arguments.startDate;
			variables.endDate = arguments.endDate;
			variables.tripLeaderMemberId = arguments.tripLeaderMemberId;
			variables.tripAssistantMemberId = arguments.tripAssistantMemberId;
		</cfscript>
		
		<cfreturn this />
		
	</cffunction>
		
</cfcomponent>
