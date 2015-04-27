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

<cfcomponent name="customerManager" output="false">

	<cffunction name="init" returntype="com.model.customer.customerManager" access="public" output="false">
		<cfargument name="customer" type="Struct" required="true" />
		<cfargument name="customerDAO" type="Struct" required="true" />
		<cfset variables.customer = arguments.customer />
		<cfset variables.customerDAO = arguments.customerDAO />
		<cfreturn this />
	</cffunction>

	<cffunction name="processLogin" returntype="struct" access="public" output="false">
		<cfargument name="profile" type="struct" required="true" />
		
		<cfscript>
		var local = StructNew();
		// lookup up profile
		local.lookupResult = lookupProfile(arguments.profile.openIDData.profile.identifier);
		// process result
		if(local.lookupResult.recordcount NEQ 0){
			//populate bean
			local.profileBean = populateProfile(local.lookupResult);
			//set last login
			editProfile(
				profileID = local.lookupResult.profileID,
				lastLogin = Now()
			);
		}
		else{
			//add profile
			editProfile(
				displayName = arguments.profile.openIDData.profile.displayName,
				email = arguments.profile.openIDData.profile.email,
				userId = arguments.profile.openIDData.profile.googleUserId,
				identifier = arguments.profile.openIDData.profile.identifier,
				familyName = arguments.profile.openIDData.profile.name.familyName,
				formattedName = arguments.profile.openIDData.profile.name.formatted,
				givenName = arguments.profile.openIDData.profile.name.givenName,
				preferredUsername = arguments.profile.openIDData.profile.preferredUsername,
				providerName = arguments.profile.openIDData.profile.providerName,
				verifiedEmail = arguments.profile.openIDData.profile.verifiedEmail
			);
			//then populate bean
			local.lookupResult = lookupProfile(arguments.profile.openIDData.profile.identifier);
			local.profileBean = populateProfile(local.lookupResult);
		}
		return local.profileBean;
		</cfscript>
	</cffunction>
	
	<cffunction name="processLogout" access="public" returntype="void" output="false">
		<cfscript>
			try{
				StructDelete(session, 'profileBean');
			}
			catch(Any excpt){
				//nothing to see here
			}
		</cfscript>
	</cffunction>

	<cffunction name="lookupProfile" returntype="query" access="public" output="false">
		<cfargument name="identifier" type="string" required="true" />
		<cfscript>
			var lookupResult = variables.customerDAO.getProfile(
				identifier = arguments.identifier
			);
			return lookupResult;
		</cfscript>
	</cffunction>

	<cffunction name="editProfile" returntype="query" access="public" output="false">
		<cfargument name="profileID" type="String" required="false" default="" />
		<cfargument name="displayName" type="string" required="false" default="" />
		<cfargument name="email" type="string" required="false" default="" />
		<cfargument name="userId" type="string" required="false" default="" />
		<cfargument name="identifier" type="string" required="false" default="" />
		<cfargument name="familyName" type="string" required="false" default="" />
		<cfargument name="formattedName" type="string" required="false" default="" />
		<cfargument name="givenName" type="string" required="false" default="" />
		<cfargument name="preferredUsername" type="string" required="false" default="" />
		<cfargument name="providerName" type="string" required="false" default="" />
		<cfargument name="url" type="string" required="false" default="" />
		<cfargument name="verifiedEmail" type="string" required="false" default="" />
		<cfargument name="lastLogin" type="String" required="false" default="" />
		<cfscript>
			var updateResult = variables.customerDAO.editProfile(
				profileID = arguments.profileID,
				displayName = arguments.displayName,
				email = arguments.email,
				userId = arguments.userId,
				identifier = arguments.identifier,
				familyName = arguments.familyName,
				formattedName = arguments.formattedName,
				givenName = arguments.givenName,
				preferredUsername = arguments.preferredUsername,
				providerName = arguments.providerName,
				url = arguments.url,
				verifiedEmail = arguments.verifiedEmail,
				lastLogin = arguments.lastLogin
			);
			return updateResult;
		</cfscript>
	</cffunction>

	<cffunction name="populateProfile" returntype="struct" access="public" output="false">
		<cfargument name="profile" type="query" required="true" />
		<cfscript>
			//create a seperate instance of the customer bean
			/*
			yea, I know this isn't the fancy pants way of
			creating an actual instance but you get the idea
			of what's going on here
			*/
			session.profileBean = Duplicate(variables.customer);
			//populate the session customer bean
			session.profileBean.init(
				profileID = arguments.profile.profileID,
				displayName = arguments.profile.displayName,
				email = arguments.profile.email,
				userId = arguments.profile.userId,
				identifier = arguments.profile.identifier,
				familyName = arguments.profile.familyName,
				formattedName = arguments.profile.formattedName,
				givenName = arguments.profile.givenName,
				preferredUsername = arguments.profile.preferredUsername,
				providerName = arguments.profile.providerName,
				url = arguments.profile.url,
				verifiedEmail = arguments.profile.verifiedEmail,
				systemCreationDate = arguments.profile.systemCreationDate,
				lastLogin = arguments.profile.lastLogin
			);
			return session.profileBean;
		</cfscript>
	</cffunction>
	
</cfcomponent>