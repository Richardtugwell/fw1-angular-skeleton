<cfoutput>
<p>We received a request to reset your Intelligent Ranking Password</p>

<p>If you initiated the request please click the following link. Otherwise lease ignore this email. NB The link can only be used once.</p>

<p>
	<a href="http://#CGI.http_host##buildURL(action = ':public##/resetpassword/#local.token#' )#">http://#CGI.http_host##buildURL(action = ':public##/resetpassword/#local.token#' )#</a>
</p>
</cfoutput>
