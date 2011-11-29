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
	<script type="text/javascript" src="mobilesite/mobiscroll/mobiscroll.js"></script>
	<link rel="stylesheet" type="text/css" href="mobilesite/mobiscroll/mobiscroll.css">
	
	<script type="text/javascript" src="mobilesite/javascript/searchevent.js"></script>
	<style type="text/css">
		  html { height: 100% }
		  body { height: 100%; margin: 0; padding: 0 }
		  #map_canvas { height: 800px; }
		</style>
    <% require themedCSS(ubridge) %>
 	</head>
<body>
    <div data-role="page" data-theme="e">
    <% control CurrentMember %>
      <div data-role="header" id="Header">
        <h1>Hello $FirstName!</h1>
      </div><!-- /header -->
	<% end_control %>
      <div data-role="content">	
		<h1>Nearby Events</h1>
      	
      	<ul data-role="listview" data-split-icon="gear" data-split-theme="d">
      	<li><a href="#"><h3>Verified Events will be listed Here</h3></a>
      	<a href="#" data-transition="slideup">Edit Event</a>
      	</li>
      	</ul>
 	</div><!-- content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011. | <a href="Security/login?BackURL=%2F/">Logout</a><h4>
  </div><!-- /page -->
  
  <div id="newEvent" data-role="page" data-theme="b">
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
 
 	<div id="newConference" data-role="page" data-theme="b">
      <div data-role="header" id="Header">
        <h1>New Conference Event</h1>
      </div><!-- /header -->
      <div data-role="content">	
		<div data-role="fieldcontain">
			<div>
			<form action="eventStart" method="GET">
			<fieldset data-role="controlgroup" data-type="vertical" data-role="fieldcontain"> 
				<h3>Basic Information</h3>
				<div data-role="fieldcontain">
	         <h4>Event Name</h4>
	         <input type="text" name="name" id="name" value=""  />
			</div>

			<div data-role="fieldcontain">
			<h4>Summary</h4>
			<textarea cols="40" rows="9" name="summary" id="textarea"></textarea>
			<div><button type="submit" data-theme="a">Event Dates</button></div>
			
			</div>

			</fieldset>
			</form>
			</div>
		</div>
 	</div><!-- content -->
 
  </div><!-- /page -->
  
  <div id="eventStart" data-role="page" data-theme="b">
      <div data-role="header" id="Header">
        <h1>New Conference Event</h1>
      </div><!-- /header -->
      <div data-role="content">	
		<div data-role="fieldcontain">
			<div>
			<form action="#eventStart" method="GET">
			<fieldset data-role="controlgroup" data-type="vertical" data-role="fieldcontain"> 
				<h3>When does the event start?</h3>

			</fieldset>
			</form>
			</div>
		</div>
 	</div><!-- content -->
 
  </div><!-- /page -->
</body>
</html>
