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
</head>
<body>
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
</body>
</html>
