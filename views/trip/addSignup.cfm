<cfset memberList = rc.memberData />
<cfset tripList = rc.tripData />

<cfoutput>

<h3 class="heading_b uk-margin-bottom">
	Add New Signup
</h3>

<div class="uk-grid" data-uk-grid-margin="">
<div class="uk-width-medium-3-4">
<div class="md-card">
<div class="md-card-content large-padding">

	<form name="createTrip" action="index.cfm?action=trip.addperson" method="post">
		<div class="uk-grid" data-uk-grid-margin="">
			<div class="uk-width-medium-1-2">
				<select id="memberId" name="memberId" data-md-selectize>
					<option value="">Select Club Member...</option>
					<cfloop query="memberList">
						<option value="#memberId#">#firstName# #lastName#</option>
					</cfloop>
				</select>
			</div>
			<div class="uk-width-medium-1-2">
				<select id="tripId" name="tripId" data-md-selectize>
					<option value="">Select Ski Trip...</option>
					<cfloop query="tripList">
						<option value="#tripId#">#tripName#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="uk-grid">
			<div class="uk-width-1-1">
				<button type="submit" class="md-btn md-btn-primary" name="submit">Submit</button>
			</div>
		</div>
	</form>

</div>
</div>
</div>
</div>

</cfoutput>