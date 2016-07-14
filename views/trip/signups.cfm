<cfset signupList = rc.signupData />

<div class="md-card uk-margin-medium-bottom">
	<div class="md-card-content">
		<div class="uk-overflow-container">
		
			<table id="dt_default" class="uk-table uk-table-nowrap">
				<thead>
					<tr>
						<th class="uk-width-2-10">First Name</th>
						<th class="uk-width-2-10">Last Name</th>
						<th class="uk-width-2-10">Trip</th>
						<th class="uk-width-1-10">Ski Level</th>
						<th class="uk-width-2-10 uk-text-center">Actions</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput query="signupList">
						<tr class="uk-table-middle">
							<td>#firstName#</td>
							<td>#lastName#</td>
							<td>#tripName#</td>
							<td>#SkiLevel#</td>
							<td class="uk-text-center">
								<a href="index.cfm?action=member.edit&memberId=#memberId#"><i class="md-icon material-icons">mode_edit</i></a>
							</td>
						</tr>
					</cfoutput>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="md-fab-wrapper">
	<a class="md-fab md-fab-accent" href="index.cfm?action=trip.addSignup">
		<i class="material-icons">add</i>
	</a>
</div>