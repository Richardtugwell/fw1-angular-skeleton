<cfoutput>
<p>Thanks for registering with Intelligent Ranking</p>

<p>Please confirm your email address by clicking the following link:</p>

<p>
	<!--- <a href="http://#CGI.http_host##buildURL(action = ':public.confirmemail' , queryString = {token = local.token } )#">http://#CGI.http_host##buildURL(action = ':public.confirmemail' , queryString = {token = local.token } )#</a> --->
	<a href="http://#CGI.http_host##buildURL(action = ':public##/public/confirmemail/#local.token#' )#">http://#CGI.http_host##buildURL(action = ':public##/public/confirmemail/#local.token#' )#</a>
</p>
</cfoutput>
