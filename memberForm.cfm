<cfif structKeyExists(FORM, 'submitMember_btn')>
	
	<cfset objMemberBean = createobject('component', 'beans.Member').init(
		argumentCollection = FORM
	) />
	
	<cfset intNewID = application.MemberSVC.save(member=objMemberBean) />
	
	<cflocation url="members.cfm" addtoken="no">

</cfif>

<cfif IsDefined('url.memberId')>
	<cfset objMember = application.MemberSVC.read(url.memberId) />	
<cfelse>
	<cfset objMember = createObject('component', 'beans.member').init() />
</cfif>

<cfoutput>

<h3 class="heading_b uk-margin-bottom">
	Add New Club Member
</h3>

<div class="uk-grid" data-uk-grid-margin="">
<div class="uk-width-medium-3-4">
<div class="md-card">
<div class="md-card-content large-padding">

	<form name="createMember" action="memberForm.cfm" method="post">
		
		<input type="hidden" name="memberId" value="#objMember.getMemberId()#" />
		
		<div class="uk-grid" data-uk-grid-margin="">
			<div class="uk-width-medium-1-2">
				<div class="uk-form-row">
					<label for="firstName">First Name</label>
					<input type="text" name="firstName" value="#objMember.getFirstName()#" class="md-input">
				</div>
			</div>
			<div class="uk-width-medium-1-2">
				<div class="uk-form-row">
					<label for="lastName">Last Name</label>
					<input type="text" name="lastName" value="#objMember.getLastName()#" class="md-input">
				</div>
			</div>
			<div class="uk-width-medium-1-2">
				<div class="uk-form-row">
					<label for="firstName">Email</label>
					<input type="text" name="email" value="#objMember.getEmail()#" class="md-input">
				</div>
			</div>
		</div>
		<div class="uk-grid uk-grid-divider" data-uk-grid-margin="">
			
			<div class="uk-width-medium-1-2">
				<h3 class="heading_a">Join Date</h3>
				
				<div class="uk-grid" data-uk-grid-margin="">
					<div class="uk-input-group">
						<span class="uk-input-group-addon"><i class="uk-input-group-icon uk-icon-calendar"></i></span>
						<label for="uk_dp_1">Select date</label>
						<input class="md-input" type="text" name="joinDate" value="#DateFormat(objMember.getJoinDate(), 'MM-DD-YYYY')#" data-uk-datepicker="{format:'MM-DD-YYYY'}">
					</div>
				</div>
			</div>
			<div class="uk-width-medium-1-2">
				<h3 class="heading_a">Ski Level</h3>
				
				<cfset selectedHtml = 'checked="checked"' />
				
				<div class="uk-grid" data-uk-grid-margin="">
					<div class="uk-width-medium-1-1">
						<p>
							<input type="radio" name="skiLevelId" value="3" id="skilLevel_3" data-md-icheck <cfif objMember.getSkiLevelId() EQ 3>#selectedHTML#</cfif> />
							<label for="skilLevel_3" class="inline-label">Black (Expert)</label>
						</p>
						<p>
							<input type="radio" name="skiLevelId" value="2" id="skilLevel_2" data-md-icheck <cfif objMember.getSkiLevelId() EQ 2>#selectedHTML#</cfif> />
							<label for="skilLevel_2" class="inline-label">Blue (Intermediate)</label>
						</p>
						<p>
							<input type="radio" name="skiLevelId" value="1" id="skilLevel_1" data-md-icheck <cfif objMember.getSkiLevelId() EQ 1>#selectedHTML#</cfif> />
							<label for="skilLevel_1" class="inline-label">Green (Beginner)</label>
						</p>
					</div>
				</div>
			</div>	
		</div>
		<div class="uk-grid">
			<div class="uk-width-1-1">
				<button type="submit" class="md-btn md-btn-primary" name="submitMember_btn">Submit</button>
			</div>
		</div>
	</form>
</div>
</div>
</div>
</div>

</cfoutput>