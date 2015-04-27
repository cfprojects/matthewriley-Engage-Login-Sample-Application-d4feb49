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
			//set the callback url
			variables.callbackURL = 'http://'&cgi.http_host&BuildUrlToModule('', 'openIDLogin');
			variables.callbackEncoded = URLEncodedFormat(variables.callbackurl);
			</cfscript>
			<script type="text/javascript">
				var rpxJsHost = (("https:" == document.location.protocol) ? "https://" : "http://static.");
				document.write(unescape("%3Cscript src='" + rpxJsHost + "rpxnow.com/js/lib/rpx.js' type='text/javascript'%3E%3C/script%3E"));
			</script>
			<script type="text/javascript">
				RPXNOW.overlay = true;
				RPXNOW.language_preference = 'en';
			</script>
			<cfoutput><a class="rpxnow" onclick="return false;" href="https://#getProperty('rpxNowDomain')#/openid/v2/signin?token_url=#variables.callbackEncoded#">Login</a></cfoutput>