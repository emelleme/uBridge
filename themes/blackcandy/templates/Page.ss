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
    
    
    <% require javascript(mobilesite/javascript/jquery.ui.map.js) %>
    <% require javascript(mobilesite/javascript/jquery.ui.map.min.js) %>
    <% require javascript(mobilesite/javascript/jquery.ui.map.services.js) %>
    <% require javascript(mobilesite/javascript/jquery.ui.map.extensions.js) %>
    <% require javascript(mobilesite/javascript/maps.js) %>
 	</head>
<body>
    <div data-role="page" data-theme="b">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->

      <div data-role="content" id="Layout"> 
        $Layout    
      </div><!-- /content -->
      
      <div data-role="footer" id="Footer">
          <h4>&copy; 2011.</h4>
      </div><!-- /footer -->
 
  </div><!-- /page -->
  
  <div id="gmap" data-role="page" data-theme="b" data-add-back-btn="false">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->
      
      <div id="PageTitle">
      	<h2>Find My District</h2>
      </div>

      <div id="DistrictSearch">	
          <input type="text" name="StreetOrZipCode" id="StreetOrZipCode" value="Street Address or Zip Code" />
          <!-- <button type="submit" id="SearchSubmit">go</button> -->
     	</div>

      <div id="map_canvas" style="height:300px;"></div>
  </div><!-- /page -->




  <div id="tip" data-role="page" data-theme="b" data-add-back-btn="false">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->
      
      <div id="PageTitle">
        <h2>Submit a Tip</h2>
      </div>

      <div class="BlankPage"> 
          <p>Use this electronic form to submit information regarding suspicious, nuisance and criminal activity to the Philadelphia Police Department. You can submit a tip anonymously.</p>
          <p>If you are reporting a crime in progress, or require emergency service, please dial 9-1-1 now.</p>
          <p>To submit a tip via phone, diail 215.686.TIPS(8477).</p>
          <div id="TipForm">
            <label for="subject">Subject <strong>*</strong></label>
            <input type="text" name="subject" id="subject" value="" />

            <label for="location">Location</label>
            <input type="text" name="location" id="location" value="" />

            <label for="message">Tip or Message:</label>
            <textarea name="message" id="message"></textarea>

            <input type="checkbox" name="contactme" id="contactme" data-theme="c" />
            <label for="contactme" class="lowerCase">check this box if you wish to be contacted</label>

            <button type="submit" id="TipSubmit" data-theme="a">submit</button>

          </div>
      </div>
     
  </div><!-- /page -->

  <div id="surveillance" data-role="page" data-add-back-btn="false">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->
        
      <div id="PageTitle">
        <h2>View Surveillance Videos</h2>
      </div>

      <div class="BlankPage"> 
        <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b" id="SurveillanceVideoList">
          <li data-icon="arrow-r">
            <img src="themes/blackcandy/images/video_thumb_sample.jpg" alt="Surveillance video" />
            <a href="sd">Pizza Store Robberies <em>September 20, 2011</em></a>
          </li>

          <li data-icon="arrow-r">
            <img src="themes/blackcandy/images/video_thumb_sample.jpg" alt="Surveillance video" />
            <a href="sd">Robbery at Metro PCS 3712 N Broad <em>September 9, 2011</em></a>
          </li>

        </ul>
      </div>

  </div> <!-- page -->


</body>
</html>
