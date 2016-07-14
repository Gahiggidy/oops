<cfset resortList = rc.data />

<div class="md-card uk-margin-medium-bottom">
	<div class="md-card-content">
		<div class="uk-overflow-container">
		
			<table id="dt_default" class="uk-table uk-table-nowrap">
				<thead>
					<tr>
						<th class="uk-width-8-10">Resort Name</th>
						<th class="uk-width-2-10 uk-text-center">Actions</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput query="resortList">
						<tr class="uk-table-middle">
							<td>#resortName#</td>
							<td class="uk-text-center">
								<a href="index.cfm?action=resort.edit&resortId=#resortId#"><i class="md-icon material-icons">mode_edit</i></a>
							</td>
						</tr>
						</cfoutput>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="md-fab-wrapper">
	<a class="md-fab md-fab-accent" href="index.cfm?action=resort.edit">
		<i class="material-icons">add</i>
	</a>
</div>