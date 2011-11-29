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
	
	<script type="text/javascript" src="mobilesite/javascript/editevent.js"></script>
	<style type="text/css">
		  html { height: 100% }
		  body { height: 100%; margin: 0; padding: 0 }
		  #map_canvas { height: 800px; }
		</style>
    <% require themedCSS(ubridge) %>
 	</head>
<body>
    <div data-role="page" data-theme="e">
    <% control EventInfo %>
      <div data-role="header" id="Header">
        <h1>Edit $Title</h1>
      </div><!-- /header -->
      <div data-role="content">	
		<div data-role="fieldcontain">
			<div>
			<form action="eventEnd" method="GET">
			 	<div data-role="fieldcontain">
                    <label for="date1">Start Date</label>
                    <input type="text" name="date1" id="date1" class="mobiscroll" value="11/05/2011" />
                </div>

                <div data-role="fieldcontain">
                    <label for="date2">Start Time</label>
                    <input type="text" name="date2" id="date2" class="mobiscroll" readonly="readonly" value="11:23 AM" />
                </div>
                
                 <div data-role="fieldcontain">
                    <label for="date3">End Date</label>
                    <input type="text" name="date3" id="date3" class="mobiscroll" value="11/15/2011" />
                </div>

                <div data-role="fieldcontain">
                    <label for="date4">End Time</label>
                    <input type="text" name="date4" id="date4" class="mobiscroll" readonly="readonly" value="11:23 AM" />
                </div>
                
                <div data-role="fieldcontain">
			<h4>Summary</h4>
				<textarea cols="40" rows="9" name="summary" id="textarea">$Summary</textarea>
			</div>
			
			<div data-role="fieldcontain">
			<div><button type="submit" data-theme="b">Save</button></div>
		</div>
			</form>
			</div>
			
			<div>
			<ul data-role="listview" data-split-icon="plus" data-split-theme="d">
		  	<li><a href="newMessage"><h3>uMessages</h3><p>A uMessages are pre-defined messages that you create and schedule to be sent to all Attendees using uBridge.</p></a>
		  	<a href="newMessage" data-transition="slideup">Add a new uMessage</a>
		  	</li>
		  	</ul>
		  	
		  	<ul data-role="listview" data-split-icon="plus" data-split-theme="d">
		  	<li><a href="#"><h3>Sessions</h3><p>This Event Currently has no Sessions.</p></a>
		  	<a href="#" data-transition="slideup">Edit Event</a>
		  	</li>
		  	</ul>
		  	
		  	<ul data-role="listview" data-split-icon="plus" data-split-theme="d">
		  	<li><a href="#"><h3>Documents</h3><p>This Event Currently has no Documents.</p></a>
		  	<a href="#" data-transition="slideup">Edit Event</a>
		  	</li>
		  	</ul>
		  	</div>
		  	
		</div>
 	</div><!-- content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011.</h4>
      </div><!-- /footer -->
 	<% end_control %>
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
