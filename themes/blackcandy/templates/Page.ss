<!DOCTYPE html>

<html lang="$ContentLocale" manifest="assets/mobile.appcache">
  <head>
		<% base_tag %>
		<title><% if MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
		<meta name="viewport" content="width=device-width, initial-scale=1"> 

    $MetaTags(false)
		
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.css" />
    <% require themedCSS(phillymobile) %>

    <% require javascript(http://code.jquery.com/jquery-1.6.4.min.js) %>
    <% require javascript(mobilesite/javascript/page.js) %>
    <% require javascript(http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js) %>
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
</body>
</html>
