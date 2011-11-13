<!DOCTYPE html>
<html lang="$ContentLocale" manifest="assets/mobile.appcache">
  <head>
    <% base_tag %>
    <title><% if MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    
    $MetaTags(false)
    
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="stylesheet"  href="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.css" />  

    <script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?sensor=true">
    </script>
  
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
   <script type="text/javascript" src="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.js"></script>
   <% require themedCSS(phillymobile) %
  </head>
<body>
    <div data-role="page" data-theme="b">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->

      <div data-role="content" id="Layout"> 
        <div id="TweetBox">
	<h3>@PhillyPolice</h3>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim. 
		<strong>56 mins ago</strong>
	</p>
</div>

<ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b" id="MainMenu">
	<li data-icon="arrow-r" id="NearestStation"><a href="map/stations" data-ajax="false">Nearest Police Station</a></li>
	<li data-icon="arrow-r" id="FindMyDistrict"><a href="map/districts" data-ajax="false">Find My District</a></li>
	<li data-icon="arrow-r" id="SubmitTip"><a href="form/tip" data-ajax="false">Submit a Tip</a></li>
	<li data-icon="arrow-r" id="Surveillance"><a href="media/surveillance" data-ajax="false">View Surveillance Videos</a></li>
	<li data-icon="arrow-r" id="ContactDirectory"><a href="contact" data-ajax="false">Contact Directory</a></li>
</ul> 
      </div><!-- /content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011.</h4>
      </div><!-- /footer -->
 
  </div><!-- /page -->


</body>
</html>
