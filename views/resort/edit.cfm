
<cfset objResort = rc.data />

<cfoutput>

<h3 class="heading_b uk-margin-bottom">
	#rc.pageTitle#
</h3>

<div class="uk-grid" data-uk-grid-margin="">
<div class="uk-width-medium-3-4">
<div class="md-card">
<div class="md-card-content large-padding">

	<form name="createResort" action="index.cfm?action=resort.save" method="post">
		
		<input type="hidden" name="resortId" value="#objResort.getResortId()#" />
		
		<div class="uk-grid" data-uk-grid-margin="">
			<div class="uk-width-medium-1-1">
				<div class="uk-form-row">
					<label for="resortName">Resort Name</label>
					<input type="text" name="resortName" value="#objResort.getResortName()#" class="md-input">
				</div>
			</div>
		</div>
		<div class="uk-grid">
			<div class="uk-width-1-1">
				<button type="submit" class="md-btn md-btn-primary" name="submitResort_btn">Submit</button>
			</div>
		</div>
	</form>
</div>
</div>
</div>
</div>

</cfoutput>