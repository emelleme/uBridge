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
    
      <% require javascript(/mobilesite/javascript/host.js) %>
 	</head>
<body>
    <div data-role="page" data-theme="e">
    <% control CurrentMember %>
      <div data-role="header" id="Header">
        <h1>Hello $FirstName!</h1>
      </div><!-- /header -->
	<% end_control %>
      <div data-role="content" id="Layout"> 
      	
      	<a href="newEvent" data-role="button" data-icon="plus" data-iconpos="right" data-theme="b">Create an Event</a>
      	<a href="host" data-role="button" data-icon="search" data-iconpos="right" data-theme="c" data-ajax="false">Browse Nearby Events</a>
      	<h1>My Events</h1>
      	
      	<ul data-role="listview" data-split-icon="gear" data-split-theme="d">
      	<li><a href="#"><h3>Verified Events will be listed Here</h3></a>
      	<a href="#" data-transition="slideup">Edit Event</a>
      	</li>
      	</ul>
		
		
        $Form
      </div><!-- /content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011.</h4>
      </div><!-- /footer -->
 
  </div><!-- /page -->
  
  <div id="newEvent" data-role="page" data-theme="e">
      <div data-role="header" id="Header">
        <h1>Creat a New Event</h1>
      </div><!-- /header -->
      <div data-role="content">	
		<div data-role="fieldcontain">
			<div><fieldset data-role="controlgroup" data-type="vertical" data-role="fieldcontain"> 
				<h3 for="event-type">What type of Event?</h3><br />
			 	<a href="newConference" data-role="button" data-icon="arrow-r" data-iconpos="right" data-theme="b">Conference</a>
				 	
			</fieldset></div>
		</div>
		
 	</div><!-- content -->
 </div>
 
 	<div id="newConference" data-role="page" data-theme="e">
      <div data-role="header" id="Header">
        <h1>New Conference Event</h1>
      </div><!-- /header -->
      <div data-role="content">	
		<div data-role="fieldcontain">
			<div>
			<form action="host/eventStart" method="GET" data-ajax="false">
			<fieldset data-role="controlgroup" data-type="vertical" data-role="fieldcontain"> 
				<h3>Basic Information</h3>
				<div data-role="fieldcontain">
	         <h4>Event Name</h4>
	         <input type="text" name="name" id="name" value=""  />
			</div>

			<div data-role="fieldcontain">
			<h4>Summary</h4>
			<textarea cols="40" rows="9" name="summary" id="textarea"></textarea>
			</div>
			<div data-role="fieldcontain" data-theme="c">
			<input type="checkbox" name="checkbox-0" id="checkbox-0" data-theme="e"/>
		<label for="checkbox-0" data-theme="c">I agree to the Terms.</label>
		</div>
		
		<div data-role="fieldcontain">
			<div><button type="submit" data-theme="a">Create this Event!</button></div>
		</div>
			
			</div>

			</fieldset>
			</form>
			</div>
		</div>
 	</div><!-- content -->
 
  </div><!-- /page -->
</body>
</html>
