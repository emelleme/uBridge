<!DOCTYPE html>

<html lang="$ContentLocale" manifest="assets/mobile.appcache">
  <head>
		<% base_tag %>
		<title><% if MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
		<meta name="viewport" content="width=device-width, initial-scale=1"> 
		

    $MetaTags(false)
		
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.css" />
    <script type="text/javascript"
    src="http://maps.googleapis.com/maps/api/js?sensor=true">
	</script>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js"></script>
	<style type="text/css">
		  html { height: 100% }
		  body { height: 100%; margin: 0; padding: 0 }
		  #map_canvas { height: 800px; }
		</style>
    <% require themedCSS(phillymobile) %>

    <% require javascript(http://code.jquery.com/jquery-1.6.4.min.js) %>
    
    <% require javascript(http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js) %>
    <% require javascript(mobilesite/javascript/jquery.ui.map.js) %>
    <% require javascript(mobilesite/javascript/jquery.ui.map.min.js) %>
    <% require javascript(mobilesite/javascript/jquery.ui.map.services.js) %>
    <% require javascript(mobilesite/javascript/jquery.ui.map.extensions.js) %>
    <% require javascript(mobilesite/javascript/maps.js) %>
 	</head>
<body>
    <div id="gmap" data-role="page" data-theme="b">
      
      <div data-role="content">	
		<div data-role="fieldcontain">
			
			<input type="search" name="password" id="search" value="" />
			<div><fieldset data-role="controlgroup" data-type="horizontal" data-role="fieldcontain"> 
				 	<input type="radio" name="radio-choice-1" id="radio-choice-1" value="choice-1" checked="checked" />
				 	<label for="radio-choice-1">Show District</label>

				 	<input type="radio" name="radio-choice-1" id="radio-choice-2" value="choice-2"  />
				 	<label for="radio-choice-2">Nearest Station</label>
			</fieldset></div>
		</div>
		
		<div class="ui-bar-c ui-corner-all ui-shadow" style="padding:1em;">
			<div id="map_canvas" style="height:300px;"></div>
		</div>
		
 	</div><!-- content -->
 
  </div><!-- /page -->
</body>
</html>
