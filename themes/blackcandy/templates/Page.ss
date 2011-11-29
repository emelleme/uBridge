<!DOCTYPE html>
<html lang="$ContentLocale">
  <head>
		<% base_tag %>
		<title>μBridge</title>
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
        <h1>μBridge.mobi</h1>
      </div><!-- /header -->

      <div data-role="content" id="home"> 
		<a href="host" data-role="button" data-icon="event-host" data-iconpos="top" data-theme="c" data-ajax="false">Event/Venue Host</a>
		
		<a href="login" data-role="button" data-icon="event-guest" data-iconpos="top" data-theme="c">Event/Venue Guest</a>
        $Form
      </div><!-- /content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011.</h4>
      </div><!-- /footer -->
 
  </div><!-- /page -->
  
  <div id="login" data-role="page" data-theme="e">
      <div data-role="header" id="Header">
        <h1>μBridge.mobi</h1>
      </div><!-- /header -->

      <div data-role="content" id="home"> 
		<p>Sign-in below</p>
		
		<a href="https://www.facebook.com/dialog/oauth?client_id=284986931522062&amp;scope=email,sms,offline_access,publish_stream,user_about_me,user_location&amp;redirect_uri=http://ubridge.mobi/login/go/&amp;response_type=code token"><img src="themes/blackcandy/img/fb-button.png"></a>
        $Form
      </div><!-- /content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011.</h4>
      </div><!-- /footer -->
 
  </div><!-- /page -->
</body>
</html>
