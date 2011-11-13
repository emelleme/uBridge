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
</body>
</html>
