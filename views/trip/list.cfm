<cfset tripList = rc.data />

<div class="md-card uk-margin-medium-bottom">
	<div class="md-card-content">
		<div class="uk-overflow-container">
		
			<table id="dt_default" class="uk-table uk-table-nowrap">
				<thead>
					<tr>
						<th class="uk-width-2-10">Trip Name</th>
						<th class="uk-width-2-10">Resort</th>
						<th class="uk-width-2-10">Dates</th>
						<th class="uk-width-2-10">Trip Leader</th>
						<th class="uk-width-2-10 uk-text-center">Actions</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput query="tripList">
						<tr class="uk-table-middle">
							<td>#tripName#</td>
							<td>#resortName#</td>
							<td>#dateFormat(startDate, "mm/dd/yyyy")#</td>
							<td>#tripLeaderFirstName# #tripLeaderLastName#</td>
							<td class="uk-text-center">
								<a href="index.cfm?action=trip.edit&tripId=#tripId#"><i class="md-icon material-icons">mode_edit</i></a>
								<a href="index.cfm?action=trip.signups&tripId=#tripId#"><i class="md-icon material-icons">person_add</i></a>
							</td>
						</tr>
						</cfoutput>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="md-fab-wrapper">
	<a class="md-fab md-fab-accent" href="index.cfm?action=trip.edit">
		<i class="material-icons">add</i>
	</a>
</div>