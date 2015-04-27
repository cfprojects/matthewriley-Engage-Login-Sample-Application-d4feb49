<!---
Copyright 2010 MW Riley Consulting LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->

<cfcomponent name="customerDAO" output="false">

	<cffunction name="init" returntype="com.model.customer.customerDAO" access="public" output="false">
		<cfargument name="dsn" type="string" required="false" />
	    <cfset variables.dsn = arguments.dsn />
		<cfreturn this />
	</cffunction>

	<cffunction name="getProfile" returntype="query" access="public" output="false">
		<cfargument name="identifier" type="String" required="false" default="" />
		<cfset var getProfile = "">
		<cfquery name="getProfile" datasource="#variables.dsn#">
			exec proc_get_customers
				@identifier = '#arguments.identifier#'
		</cfquery>
		<cfreturn getProfile />
	</cffunction>

	<cffunction name="editProfile" returntype="query" access="public" output="false">
		<cfargument name="profileID" type="String" required="false" default="" />
		<cfargument name="displayName" type="String" required="false" default="" />
		<cfargument name="email" type="String" required="false" default="" />
		<cfargument name="userId" type="String" required="false" default="" />
		<cfargument name="identifier" type="String" required="false" default="" />
		<cfargument name="familyName" type="String" required="false" default="" />
		<cfargument name="formattedName" type="String" required="false" default="" />
		<cfargument name="givenName" type="String" required="false" default="" />
		<cfargument name="preferredUsername" type="String" required="false" default="" />
		<cfargument name="providerName" type="String" required="false" default="" />
		<cfargument name="url" type="String" required="false" default="" />
		<cfargument name="verifiedEmail" type="String" required="false" default="" />
		<cfargument name="lastLogin" type="String" required="false" default="" />
		<cfset var editData = "">
		<cfquery name="editData" datasource="#variables.dsn#">
			exec proc_edit_customers
				@profileID = <cfif Len(profileID)><cfqueryparam value="#arguments.profileID#" cfsqltype="cf_sql_integer"><cfelse>null</cfif>,
				@displayName = <cfif Len(displayName)><cfqueryparam value="#arguments.displayName#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@email = <cfif Len(email)><cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@userId = <cfif Len(userId)><cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@identifier = <cfif Len(identifier)><cfqueryparam value="#arguments.identifier#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@familyName = <cfif Len(familyName)><cfqueryparam value="#arguments.familyName#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@formattedName = <cfif Len(formattedName)><cfqueryparam value="#arguments.formattedName#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@givenName = <cfif Len(givenName)><cfqueryparam value="#arguments.givenName#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@preferredUsername = <cfif Len(preferredUsername)><cfqueryparam value="#arguments.preferredUsername#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@providerName = <cfif Len(providerName)><cfqueryparam value="#arguments.providerName#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@url = <cfif Len(url)><cfqueryparam value="#arguments.url#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@verifiedEmail = <cfif Len(verifiedEmail)><cfqueryparam value="#arguments.verifiedEmail#" cfsqltype="cf_sql_varchar"><cfelse>null</cfif>,
				@lastLogin = <cfif Len(lastLogin)><cfqueryparam value="#arguments.lastLogin#" cfsqltype="cf_sql_timestamp"><cfelse>null</cfif>
		</cfquery>
		<cfreturn editData />
	</cffunction>

</cfcomponent>