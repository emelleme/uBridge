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
   <style type="text/css">
      
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
            <fieldset class="ui-grid-a" id="SearchFieldSet">
              <div class="ui-block-a"><input type="text" name="location" id="location" value="" /></div>
              <div class="ui-block-b"><img src="themes/blackcandy/images/button_location.png" alt="Search button" /> </div>
            </fieldset>

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
        <ul data-role="listview" data-inset="true" data-theme="d" data-dividertheme="d" id="SurveillanceVideoList">
          <li data-icon="arrow-r">
            <a href="sd"><img src="themes/blackcandy/images/video_thumb_sample.jpg" alt="Surveillance video" />Pizza Store Robberies <em>September 20, 2011</em></a>
          </li>

          <li data-icon="arrow-r">
            <a href="sd"><img src="themes/blackcandy/images/video_thumb_sample.jpg" alt="Surveillance video" />Robbery at Metro PCS 3712 N Broad <em>September 9, 2011</em></a>
          </li>
        </ul>
      </div>

  </div> <!-- page -->


  <div id="contact" data-role="page" data-theme="b" data-add-back-btn="false">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->
      
      <div id="PageTitle">
        <h2>Contact Directory</h2>
      </div>

      <div class="SearchContainer"> 
        <input type="search" name="SearchContact" id="SearchContact"  placeholder="Search" />
      </div>

      <div data-role="content">

        <h4>Uniform Patrol</h4>          
        <div data-role="collapsible-set" data-theme="d" data-content-theme="b" id="ContactList">
          <div data-role="collapsible" data-theme="d" data-content-theme="b">
            <h3>1st District</h3>
            <div class="AddressBlock">
              <h4>Address</h4>
              <p>24th and Wolf Streets</p>
            </div>
            <div class="AddressBlock">
              <div class="ui-grid-a">
                <div class="ui-block-a"><h4>Phone</h4></div>
                <div class="ui-block-b"><h4>Email</h4></div>
              </div>
              <div class="ui-grid-a">
                <div class="ui-block-a">215.686.3010</div>
                <div class="ui-block-b">police.co_01@phila.gov</div>
              </div>
            </div>
          </div>
          
          <div data-role="collapsible">
            <h3>2nd District</h3>
            <div class="AddressBlock">
              <h4>Address</h4>
              <p>24th and Wolf Streets</p>
            </div>
            <div class="AddressBlock">
              <div class="ui-grid-a">
                <div class="ui-block-a"><h4>Phone</h4></div>
                <div class="ui-block-b"><h4>Email</h4></div>
              </div>
              <div class="ui-grid-a">
                <div class="ui-block-a">215.686.3010</div>
                <div class="ui-block-b">police.co_01@phila.gov</div>
              </div>
            </div>
          </div>

          <div data-role="collapsible">
            <h3>3rd District</h3>
            <div class="AddressBlock">
              <h4>Address</h4>
              <p>24th and Wolf Streets</p>
            </div>
            <div class="AddressBlock">
              <div class="ui-grid-a">
                <div class="ui-block-a"><h4>Phone</h4></div>
                <div class="ui-block-b"><h4>Email</h4></div>
              </div>
              <div class="ui-grid-a">
                <div class="ui-block-a">215.686.3010</div>
                <div class="ui-block-b">police.co_01@phila.gov</div>
              </div>
            </div>
          </div>
        </div> <!-- collapsible-set -->

        <h4>Investigative Units</h4>
        <h4>Administrative Services</h4>

    </div> <!-- /content -->
      
  </div><!-- /page -->


</body>
</html>
