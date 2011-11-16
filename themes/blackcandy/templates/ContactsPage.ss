<!DOCTYPE html>
<html lang="$ContentLocale" manifest="assets/mobile.appcache">
  <head>
    <% base_tag %>
    <title><% if MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    
    $MetaTags(false)
    
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="stylesheet"  href="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.css" />  
  
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
   <script type="text/javascript" src="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.js"></script>
   <style type="text/css">
      
      #map_canvas { height: 800px; }
   </style>
   <% require themedCSS(phillymobile) %>
  </head>
<body>

  <div id="contact" data-role="page" data-theme="b" data-add-back-btn="false">
      <div data-role="header" id="Header">
        <h1>PhillyPolice Mobile</h1>
      </div><!-- /header -->
      
      <div id="PageTitle">
        <h2>Contact Directory</h2>
      </div>

      <div data-role="content">
			<ul data-role="listview" data-theme="c" data-dividertheme="b">
				$UniformPatrolContacts
				$InvestigativeContacts
				$AdministrativeContacts
			</li>
		</ul>        
    </div> <!-- /content -->
      
  </div><!-- /page -->


</body>
</html>
