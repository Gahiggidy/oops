<cffunction name="onRequestStart">
	
	<cfset var objDatasource = createobject('component', 'demo.beans.datasource').init(
		DSName = 'Skiclub', username = '', password = ''		
		) />

	<cfset var objMemberSVC= createobject('component', 'demo.beans.memberService').init(
		datasource = objDatasource
		) />

	<cfset application.MemberSVC = objMemberSVC />

</cffunction>