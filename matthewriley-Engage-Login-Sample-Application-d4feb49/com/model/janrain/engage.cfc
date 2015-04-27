<!---
File: engage.cfc

Details: This serves as the OpenID callback file for
Janrain Engage. Engage is a service of Janrain. For
more information about Janrain Engage please
visit: http://www.janrain.com/products/engage

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

<cfcomponent name="engage" output="false">

	<cffunction name="init" returntype="engage" access="public" output="false">
		<cfargument name="apiKey" type="string" required="true" />
		<cfset variables.apiKey = arguments.apiKey />
		<cfreturn this />
	</cffunction>

	<cffunction name="loginOpenID" returntype="struct" access="public" output="false">
		<cfargument name="token" type="struct" required="true" />

		<cfhttp url="https://rpxnow.com/api/v2/auth_info" method="post">
			<cfhttpparam type="formfield" name="apiKey" value="#variables.apiKey#">
			<cfhttpparam type="formfield" name="token" value="#arguments.token.token#">
		</cfhttp>

		<cfscript>
			var callbackData = DeserializeJSON(cfhttp.filecontent);
			return callbackData;
		</cfscript>
	</cffunction>

</cfcomponent>