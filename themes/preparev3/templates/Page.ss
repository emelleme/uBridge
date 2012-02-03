<!doctype html>
<html lang="en-us">
<head>
	<meta charset="utf-8">
	<% base_tag %>
	<title>uBridge</title>

	<% require themedCSS(style) %> 
	
	<meta name="description" content="">
	<meta name="author" content="revaxarts.com">
	
	<script>document.createElement('nav');document.createElement('section');</script>
	<script src="mobilesite/javascript/jquery.1.4.4.js"></script>
	<script src="mobilesite/javascript/cufon.js"></script>
	<script src="mobilesite/javascript/font.js"></script>
	<script src="mobilesite/javascript/config.js"></script>
	<script src="mobilesite/javascript/script.js"></script>
</head>
<body>

	<div id="wrap">
	
		<nav>
			<a href="home" id="logo">Logo</a>
			<ul id="nav">
				<li><a href="home">Home</a></li>
				<li><a href="about">Event Host Manager</a></li>
				<li><a href="contact">Mobile App</a></li>
			</ul>
			<div id="shadow"></div>
		</nav><!-- end nav -->
		
		<div id="content">
			<h1>final assembly before launch</h1>
			<div id="home" class="slide">
				<h2>going live around</h2>
				
				
				<!-- countdown start -->
				<section id="countdown">
				<span id="days"></span><span id="hours"></span><span id="minutes"></span><span id="seconds"></span>
				</section>
				<!-- countdown end -->
				
				<!-- progress bar start -->
				<section id="progess">
				<div id="progessbarbox">
					<div id="progessbar">
						<div id="percent">
							0%
						</div>
					</div><!-- end div #progressbar -->
				</div><!-- end div #progessbarbox -->
				</section>
				<!-- progress bar end -->
				
				<!-- email subscription start -->
				<h4 id="emailstatus">Give us your email and stay tuned</h4>
				<form action="http://emelleme.createsend.com/t/r/s/eadtl/" method="post" id="emailform" novalidate>
					<div id="emailfield">
						<input type="email" name="cm-name" id="email" value="">
					</div><!-- end div #emailfield -->
					<div id="submitfield">
						<input type="submit" id="submitbutton" value="Submit" >
					</div><!-- end div #submitfield -->
				</form>
				<!-- email subscription end -->
				
			</div><!-- end div #home -->
			
			
			<div id="about" class="slide">
			
			
				<!-- about start -->
				<h2>Creating and Managing Events</h2>
				<p>
					 
				</p>
				<hr>
				<ul>
					<li>Create Events and Event Categories</li>
					<li>Setup &#956;Messages to be delivered to event guests at a pre-defined time.</li>
					<li>Share Documents with attendees</li>
					<li>View attendee check-ins and join group chat</li>
				</ul>
				<!-- about end -->
				<h3><a href="host">Sign In Now!</a></h3>
			</div><!-- end div #about -->
			
			
			<div id="contact" class="slide">
			
			
				<!-- contact start -->
				<h2>Subscribe below to download the app</h2>
				<form action="http://emelleme.createsend.com/t/r/s/eadtl/" method="post" id="contactform">
					<label for="contactemail" id="emaillabel">
					<input type="text"name="cm-name" id="contactemail" placeholder="Email" tabindex="2">
					</label>
					<label for="contactmsg" id="msglabel">
					<input type="text" name="cm-eadtl-eadtl" id="contactemail" placeholder="Phone" tabindex="3">
					</label>
					<input type="submit" id="contactsubmit" value="Submit"><span id="contactstatus"></span>
				</form>
				
				<h2>Or</h2>
				<!-- add facebook connect -->
				<a href="https://www.facebook.com/dialog/oauth?client_id=284986931522062&amp;scope=email,sms,offline_access,publish_stream,user_about_me,user_location&amp;redirect_uri=http://ubridge.mobi/login/go/&amp;response_type=code token"><img src="themes/blackcandy/img/fb-button.png"></a>
				
			</div><!-- end div #contact -->
			
			<div id="app" class="slide">
			
			
				<!-- app start -->
				<h2>Download the App</h2>
				<p>Download code here </p>
				
				
			</div><!-- end div #contact -->
			
			
		</div><!-- end div #content -->
	</div><!-- end div #wrap -->
	
</body>
</html>
