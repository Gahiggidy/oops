<cfcomponent displayname="TripController" output="false" accessors="true">

	<cfproperty name="tripGateway" />
	<cfproperty name="memberGateway" />
	<cfproperty name="resortGateway" />
	<cfproperty name="beanFactory" />
	
	<cfscript>
	 function init( fw ) {
        variables.fw = fw;
    }
	</cfscript>
	
	<cffunction name="list">
		
		<cfset rc.data = variables.tripGateway.getAllTrips() />
		
	</cffunction>
	
	<cffunction name="edit">
		
		<cfif IsDefined('rc.tripId')>
			<cfset rc.data = variables.tripGateway.getTripById(rc.tripId) />
			<cfset rc.pageTitle = "Update Ski Trip - #rc.data.getTripName()#" />
		<cfelse>
			<cfset rc.data = variables.beanFactory.getBean("tripBean") />
			<cfset rc.pageTitle = "Add New Ski Trip" />
		</cfif>
		
		<cfset rc.memberData = variables.memberGateway.getAllMembers() />
		<cfset rc.ResortData = variables.resortGateway.getAllResorts() />
		
	</cffunction>
	
	<cffunction name="signups">
		<cfif IsDefined('rc.tripId')>
			<cfset rc.signupData = variables.tripGateway.filterTripSignupsByTripId(rc.tripId) />
		<cfelse>
			<cfset rc.signupData = variables.tripGateway.filterAllTripSignups() />
		</cfif>

	</cffunction>

	<cffunction name="addSignup">
	
		<cfset rc.memberData = variables.memberGateway.getAllMembers() />
		<cfset rc.tripData = variables.tripGateway.getAllTrips() />
		
	</cffunction>

	<cffunction name="addperson">
		
		<cfscript>
		var signUp = variables.beanFactory.getBean("signupBean").init(argumentCollection = FORM);
		variables.tripGateway.createNewTripSignup(signUp);
		</cfscript>
        
		<cfset redirect = variables.fw.redirect( "trip.signups" ) />
	
	</cffunction>
	
	<cfscript>
	    function save( rc ) {

		var trip = variables.beanFactory.getBean("tripBean").init(argumentCollection = FORM);
		
        variables.tripGateway.saveTrip(trip);
        variables.fw.redirect( "trip.list" );
    }
	</cfscript>

</cfcomponent>