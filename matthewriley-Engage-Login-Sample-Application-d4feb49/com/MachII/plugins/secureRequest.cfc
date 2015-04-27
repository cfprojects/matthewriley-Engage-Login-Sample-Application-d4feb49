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

<cfcomponent extends="MachII.framework.plugin">

	<cffunction name="configure" returntype="void" access="public" output="false">
		<!--- get the parameters from the config and set them to local comoponet variables --->
		<cfscript>
			variables.secureEvents = getParameter("secureEvents", "");
			variables.secureModules = getParameter("secureModules", "");
			variables.secureRequestKey = getParameter("secureRequestKey", "user");
			variables.failureEvent = getParameter("failureEvent", "login");
		</cfscript>
	</cffunction>

	<cffunction name="preProcess" returntype="void" hint="request level check to ensure that security requirements.">
		<cfargument name="eventContext" type="MachII.framework.EventContext" />
		<cfscript>
			//peek at the first event in the queue store localy incase user is not autheticated:
			var func = structNew();
			func.nextEvent = arguments.eventContext.getNextEvent();
			func.moduleName = func.nextEvent.getModuleName();
			func.eventName = func.nextEvent.getName();
			func.moduleIsSecure = false;
			func.eventIsSecure = false;
			func.newEventArgs = structNew();

			//check to see if the event or module is in the secure list
			if (ListFindNoCase(variables.secureModules, func.moduleName) NEQ 0){
				func.moduleIsSecure = true;
			}
			if (ListFindNoCase(variables.secureEvents, func.eventName) NEQ 0){
				func.eventIsSecure = true;
			}

			//event or module is secured, check for the structKey to indicated if we are already authenticated
			if ((func.moduleIsSecure OR func.eventIsSecure) AND NOT StructKeyExists(session, variables.secureRequestKey)){

				//drop the first event into session so the redirect filter can
				//re-announce announceEventInModule("moduleName", "eventName", args) it once the authentication has occured.
				session.redirectEvent = func.nextEvent;

				//clear the event queue so we can call the failure event
				arguments.eventContext.clearEventQueue();

				//get the parameters struct to pass through as the
				//event args this way any event args can be set from the config file
				func.newEventArgs = duplicate(getParameters());
				arguments.eventContext.announceEvent(variables.failureEvent, func.newEventArgs);
			}
			//call cause the first even is handled already so the prrequest will catch it
			preEvent(eventContext);
		</cfscript>
	</cffunction>

</cfcomponent>