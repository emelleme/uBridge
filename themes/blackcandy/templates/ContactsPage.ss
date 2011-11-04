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
        </div>

    </div> <!-- /content -->
      
  </div><!-- /page -->


</body>
</html>
