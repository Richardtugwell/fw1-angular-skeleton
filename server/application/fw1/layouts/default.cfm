<!DOCTYPE html>
<html lang="en">
<html lang="en" ng-app="<cfoutput>#getSection()#</cfoutput>">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>FW1 / Angular</title>
	<link rel="stylesheet" href="/assets/css/app.<cfoutput>#getSection()#</cfoutput>.css">
</head>
<body>
	<cfoutput>#body#</cfoutput>
	<toaster-container></toaster-container>
	<script src="/assets/js/app.js"></script>
	<script src="/assets/js/app.common.js"></script>
	<script src="/assets/js/app.<cfoutput>#getSection()#</cfoutput>.js"></script>
	<script src="/assets/js/app.common.templates.js"></script>
	<script src="/assets/js/app.<cfoutput>#getSection()#</cfoutput>.templates.js"></script>
</body>
</html>
