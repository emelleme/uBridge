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
   <div id="stations" data-role="page" data-theme="b" data-add-back-btn="false">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->
      
      <div id="PageTitle">
        <h2>Nearest Police Station</h2>
      </div>

      <div class="SearchContainer"> 
          <fieldset class="ui-grid-a" id="SearchFieldSet">
              <div class="ui-block-a">
                <label for="StreetOrZipCode" class="ui-hidden-accessible">Street Address</label>
                <input type="text" name="StreetOrZipCode" id="StreetOrZipCode"  placeholder="Street Address" />
              </div>
              <div class="ui-block-b"><img src="themes/blackcandy/images/button_location.png" alt="Search button" /> </div>
          </fieldset>
      </div>

      <div class="map_canvas" style="height:300px;"></div>
  </div><!-- /page -->
  
  <div id="gmap" data-role="page" data-theme="b" data-add-back-btn="false">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->
      
      <div id="PageTitle">
        <h2>Find My District</h2>
      </div>

      <div class="SearchContainer"> 
          <fieldset class="ui-grid-a" id="SearchFieldSet">
              <div class="ui-block-a">
                <label for="StreetOrZipCode" class="ui-hidden-accessible">Street Address or Zip Code</label>
                <input type="text" name="StreetOrZipCode" id="StreetOrZipCode"  placeholder="Street Address or Zip Code" />
              </div>
              <div class="ui-block-b"><img src="themes/blackcandy/images/button_location.png" alt="Search button" /> </div>
          </fieldset>
      </div>

      <div class="map_canvas" style="height:300px;"></div>
  </div><!-- /page -->
</body>
</html>
