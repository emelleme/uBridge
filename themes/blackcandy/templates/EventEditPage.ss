<!DOCTYPE html>

<html lang="$ContentLocale">
  <head>
		<% base_tag %>
		<title>μBridge</title>
		<meta name="viewport" content="width=device-width, initial-scale=1"> 
		

    $MetaTags(false)
		
    <link rel="shortcut icon" href="/favicon.ico" />
    <% require themedCSS(jquery.mobile-1.0a4.1) %>
    
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/googleapis/0.0.4/googleapis.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/jsapi"></script>
	<script type="text/javascript" src="/mobilesite/mobiscroll/mobiscroll-1.5.2.js"></script>
	<link rel="stylesheet" type="text/css" href="/mobilesite/mobiscroll/mobiscroll-1.5.2.css">
	<link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">
	
	 <script src="//maps.googleapis.com/maps/api/js?sensor=false&libraries=places"
      type="text/javascript"></script>
	<script type="text/javascript" src="/mobilesite/javascript/editevent.js"></script>
	<style type="text/css">
		  html { height: 100% }
		  body { height: 100%; margin: 0; padding: 0 }
		  #map_canvas { height: 800px; }
		  
		  #map_canvas {
        height: 400px;
        width: 600px;
        margin-top: 0.6em;
      }
		</style>
    <% require themedCSS(ubridge) %>
 	</head>
<body>
<form action="event/saveData" method="GET" data-ajax="false">
    <div data-role="page" data-theme="e">
    
 	
 	  <div data-role="header" id="Header">
        <h1>Event Location</h1>
      </div><!-- /header -->
	<div data-role="content">	
		<div data-role="fieldcontain">
		  <input data-theme="none" name="venue" id="searchTextField" type="text" size="50" placeholder="Enter the venue name or address and city" />
		  
		</div>
		
		<div id="map_canvas"></div>
		<div data-role="fieldcontain">
			
			<a href="saveData" data-role="button" data-icon="arrow-r" data-iconpos="right" data-theme="b">Event Date and Time</a>
		</div>
	</div>
  </div><!-- /page -->
  
  
<div id="saveData/$ID" data-role="page" data-theme="e">
    <% control EventInfo %>
      <div data-role="header" id="Header">
        <h1>Edit Event: <i>$Title</i></h1>
      </div><!-- /header -->
      <div data-role="content">	
		<div data-role="fieldcontain">
			<div>
			
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
				<button type="submit" data-theme="a">Save</button>
			</div>
			</div>
			
			
		  	
		</div>
 	</div><!-- content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011.</h4>
      </div><!-- /footer -->
 	<% end_control %>
	
</div>
 </form> 
  <div id="eventDetails" data-role="page" data-theme="e">
      <div data-role="header" id="Header">
        <h1>Event Details</h1>
      </div><!-- /header -->
      <div data-role="content">	
		<div>
			<ul data-role="listview" data-split-icon="plus" data-split-theme="d">
		  	<li><a href="newMessage"><h3>Venue Name</h3><p>1234 Hope St. Philly, PA</p></a>
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
		
 	</div><!-- content -->
 </div>
 	
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
