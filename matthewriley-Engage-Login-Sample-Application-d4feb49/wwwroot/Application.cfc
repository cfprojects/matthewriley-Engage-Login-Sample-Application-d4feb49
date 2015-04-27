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

<cfcomponent name="Application" displayname="Application" extends="MachII.mach-ii" output="false">

	<!---
	PROPERTIES - APPLICATION SPECIFIC
	--->
	<cfscript>
		this.name = "EngageLogin";
		this.loginStorage = "session";
		this.sessionManagement = true;
		this.setClientCookies = true;
		this.setDomainCookies = true;
		this.sessionTimeOut = CreateTimeSpan(0,1,0,0);
		this.applicationTimeOut = CreateTimeSpan(1,0,0,0);

		// DYNAMIC APPLICATION PROPERTIES

		// let the application determine where it is
		basePath = getDirectoryFromPath(getCurrentTemplatePath());
		pathLen = ListLen(basePath, '\');
		rootPath = ListDeleteAt(basePath, pathLen, '\')&'\';
		// set the com path dynamically
		comPath = rootPath&'com\';
		this.mappings["/com"] = comPath;

		// MACH-II SPECIFIC PROPERTIES

		// Set the path to the application's mach-ii.xml file.
		MACHII_CONFIG_PATH = comPath&'/config/mach-ii.xml';
		// Set the app key for sub-applications within a single cf-application.
		MACHII_APP_KEY = 'EngageLogin';
		// Set the configuration mode (when to reinit): -1=never, 0=dynamic, 1=always
		MACHII_CONFIG_MODE = 0;
	</cfscript>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="onRequestStart" returnType="void" output="true" hint="Run at the start of a page request.">
		<cfargument name="targetPage" type="string" required="true" />
		
		<!--- Temporarily override the default config mode. Set the configuration mode (when to reinit): -1=never, 0=dynamic, 1=always --->
		<cfif StructKeyExists(url, "reload") AND IsNumeric(URL.reload) AND Len(Trim(URL.reload)) LTE 2>
			<cfset MACHII_CONFIG_MODE = URL.reload />
			<cfset onApplicationStart() />
			<cflocation url="./" addToken="no">
		</cfif>

		<!--- Handle the request. Make sure we only process Mach-II requests. --->
		<cfset super.onRequestStart(arguments.targetPage) />
	</cffunction>

</cfcomponent>