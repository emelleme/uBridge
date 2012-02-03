<!DOCTYPE html>

<html lang="$ContentLocale">
  <head>
		<% base_tag %>
		<title>μBridge.mobi Host Login</title>
		<meta name="viewport" content="width=device-width, initial-scale=1"> 
		

    $MetaTags(false)
		
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.css" />
    
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/googleapis/0.0.4/googleapis.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/jsapi"></script>
	<script type="text/javascript">
   google.load("identitytoolkit", "1.0", {packages: ["mobile_ac"]});
</script>
	<style type="text/css">
		  html { height: 100% }
		  body { height: 100%; margin: 0; padding: 0 }
		  #map_canvas { height: 800px; }
		</style>
    <% require themedCSS(ubridge) %>

    <% require javascript(mobilesite/javascript/page.js) %>
 	</head>
<body>
    <div data-role="page" data-theme="e">
      <div data-role="header" id="Header">
        <h1>Host Login</h1>
      </div><!-- /header -->

      <div id="hostlogin"> 
      </div><!-- /content -->
</body>
</html>
