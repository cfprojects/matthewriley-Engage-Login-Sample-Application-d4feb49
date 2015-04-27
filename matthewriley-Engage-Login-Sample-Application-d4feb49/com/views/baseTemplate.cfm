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

<cfscript>
	content = event.getArg('content');
	loginScripts = event.getArg('loginScripts');
</cfscript>
<!DOCTYPE html>

<html lang="en-US">
<head>
	<title>Engage Login Sample Application</title>
	<meta charset="utf-8" />
</head>
<body>
<!--- 
Hold your breath and look away. I'm using a table for layout!
Of course I'm assuming you have your own layout anyway. This is
for demo only so I kept it as simple as possible so you can see
what's going on here.
--->
<table align="center" width="50%" border="1">
	<tr>
		<td align="center" width="33%"><a href="<cfoutput>#BuildUrlToModule('', 'home')#</cfoutput>">Home</a></td>
		<td align="center" width="34%"><a href="<cfoutput>#BuildUrlToModule('customer', 'home')#</cfoutput>">Customer Home</a></td>
		<td align="center" width="33%">
		<cfif StructKeyExists(session, 'profileBean')>
			<a href="<cfoutput>#BuildUrlToModule('', 'logout')#</cfoutput>">Logout</a>
		<cfelse>
<cfoutput>#loginScripts#</cfoutput>
		</cfif>
		</td>
	</tr>
</table>

<cfoutput>#content#</cfoutput>

</body>
</html>