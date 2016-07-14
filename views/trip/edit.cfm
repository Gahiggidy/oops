<cfset objTrip = rc.data />
<cfset resortList = rc.resortData />
<cfset memberList = rc.memberData />

<cfoutput>

<h3 class="heading_b uk-margin-bottom">
	#rc.pageTitle#
</h3>

<div class="uk-grid" data-uk-grid-margin="">
<div class="uk-width-medium-3-4">
<div class="md-card">
<div class="md-card-content large-padding">

	<form name="createTrip" action="index.cfm?action=trip.save" method="post">
		
		<input type="hidden" name="tripId" value="#objTrip.getTripId()#" />
		
		<div class="uk-grid" data-uk-grid-margin="">
			<div class="uk-width-medium-1-1">
				<div class="uk-form-row">
					<label for="tripName">Trip Name</label>
					<input type="text" name="tripName" value="#objTrip.getTripName()#" class="md-input">
				</div>
			</div>
			
			<div class="uk-width-medium-1-2">
				<select id="resortId" name="resortId" data-md-selectize>
					<option value="">Select resort...</option>
					<cfloop query="resortList">
						<option value="#resortId#" <cfif objTrip.getResortId() EQ resortId>selected</cfif>>#resortName#</option>
					</cfloop>
				</select>
			</div>
			
			<div class="uk-width-medium-1-2">
				<select id="tripLeaderMemberId" name="tripLeaderMemberId" data-md-selectize>
					<option value="">Select Trip Leader...</option>
					<cfloop query="memberList">
						<option value="#memberId#" <cfif objTrip.getTripLeaderMemberId() EQ memberId>selected</cfif>>#firstName# #lastName#</option>
					</cfloop>
				</select>
			</div>
			
			<div class="uk-width-medium-1-1">
				<select id="tripAssistantMemberId" name="tripAssistantMemberId" data-md-selectize>
					<option value="">Select Trip Assistant...</option>
					<cfloop query="memberList">
						<option value="#memberId#" <cfif objTrip.getTripAssistantMemberId() EQ memberId>selected</cfif>>#firstName# #lastName#</option>
					</cfloop>
				</select>
			</div>
			
			<div class="uk-width-medium-1-1">
				<h3 class="heading_a">Travel Dates</h3>
			</div>
			
			<div class="uk-width-medium-1-2">
				
				
				<div class="uk-grid" data-uk-grid-margin="">
					<div class="uk-input-group">
						<span class="uk-input-group-addon"><i class="uk-input-group-icon uk-icon-calendar"></i></span>
						<label for="uk_dp_1">Select departure date</label>
						<input class="md-input" type="text" name="startDate" value="#DateFormat(objTrip.getStartDate(), 'MM-DD-YYYY')#" data-uk-datepicker="{format:'MM-DD-YYYY'}">
					</div>
				</div>
			</div>
			
			<div class="uk-width-medium-1-2">
				
				<div class="uk-grid" data-uk-grid-margin="">
					<div class="uk-input-group">
						<span class="uk-input-group-addon"><i class="uk-input-group-icon uk-icon-calendar"></i></span>
						<label for="uk_dp_1">Select return date</label>
						<input class="md-input" type="text" name="endDate" value="#DateFormat(objTrip.getEndDate(), 'MM-DD-YYYY')#" data-uk-datepicker="{format:'MM-DD-YYYY'}">
					</div>
				</div>
			</div>
			
			
		</div>
		<div class="uk-grid">
			<div class="uk-width-1-1">
				<button type="submit" class="md-btn md-btn-primary" name="submitTrip_btn">Submit</button>
			</div>
		</div>
	</form>
</div>
</div>
</div>
</div>

</cfoutput>