<!DOCTYPE html>

<html lang="$ContentLocale" manifest="assets/mobile.appcache">
  <head>
		<% base_tag %>
		<title><% if MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
		$MetaTags(false)
		<link rel="shortcut icon" href="/favicon.ico" />
		<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<% require themedCSS(bootstrap) %>
	<% require themedCSS(jquery-ui) %>
	<% require themedCSS(mobile) %>
		<!--[if IE 6]>
			<style type="text/css">
			 @import url(themes/blackcandy/css/ie6.css);
			</style> 
		<![endif]-->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.0/jquery.min.js"></script>
		<% require javascript(mysite/javascript/page.js) %>
	</head>
<body>
  <div class="container-fluid">
  
  	<div class="page-header">
  		<h1>PhillyPolice Mobile</h1>
  		<h2>Sub-Title</h2>
  	</div>
  	<% cached %>
    <ul class="unstyled">
        <li>Lorem ipsum dolor sit amet</li>
        <li>Consectetur adipiscing elit</li>
        <li>Integer molestie lorem at massa</li>
        <li>Facilisis in pretium nisl aliquet</li>
      </ul>
    <% end_cached %>
    
    
  </div>
</body>
</html>
