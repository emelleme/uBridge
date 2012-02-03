<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% base_tag %>
<title>uBridge - Login</title>

<% require themedCSS(main) %> 
<link href="http://fonts.googleapis.com/css?family=Cuprum" rel="stylesheet" type="text/css" />

<script src="mobilesite/javascript/jquery-1.4.4.js" type="text/javascript"></script>

<script type="text/javascript" src="mobilesite/javascript/spinner/jquery.mousewheel.js"></script>
<script type="text/javascript" src="mobilesite/javascript/spinner/ui.spinner.js"></script>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> 

<script type="text/javascript" src="mobilesite/javascript/fileManager/elfinder.min.js"></script>

<script type="text/javascript" src="mobilesite/javascript/wysiwyg/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="mobilesite/javascript/wysiwyg/wysiwyg.image.js"></script>
<script type="text/javascript" src="mobilesite/javascript/wysiwyg/wysiwyg.link.js"></script>
<script type="text/javascript" src="mobilesite/javascript/wysiwyg/wysiwyg.table.js"></script>


<script type="text/javascript" src="mobilesite/javascript/forms/forms.js"></script>
<script type="text/javascript" src="mobilesite/javascript/forms/autogrowtextarea.js"></script>
<script type="text/javascript" src="mobilesite/javascript/forms/autotab.js"></script>
<script type="text/javascript" src="mobilesite/javascript/forms/jquery.validationEngine-en.js"></script>
<script type="text/javascript" src="mobilesite/javascript/forms/jquery.validationEngine.js"></script>
<script type="text/javascript" src="mobilesite/javascript/forms/jquery.dualListBox.js"></script>
<script type="text/javascript" src="mobilesite/javascript/forms/jquery.filestyle.js"></script>


<script type="text/javascript" src="mobilesite/javascript/ui/progress.js"></script>
<script type="text/javascript" src="mobilesite/javascript/ui/jquery.jgrowl.js"></script>
<script type="text/javascript" src="mobilesite/javascript/ui/jquery.tipsy.js"></script>
<script type="text/javascript" src="mobilesite/javascript/ui/jquery.alerts.js"></script>

<script type="text/javascript" src="mobilesite/javascript/jBreadCrumb.1.1.js"></script>
<script type="text/javascript" src="mobilesite/javascript/cal.min.js"></script>
<script type="text/javascript" src="mobilesite/javascript/jquery.smartWizard.min.js"></script>
<script type="text/javascript" src="mobilesite/javascript/jquery.collapsible.min.js"></script>
<script type="text/javascript" src="mobilesite/javascript/jquery.ToTop.js"></script>
<script type="text/javascript" src="mobilesite/javascript/jquery.listnav.js"></script>
<script type="text/javascript" src="mobilesite/javascript/jquery.sourcerer.js"></script>
<script type="text/javascript" src="mobilesite/javascript/jquery.timeentry.min.js"></script>

<script type="text/javascript" src="mobilesite/javascript/custom.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/googleapis/0.0.4/googleapis.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/jsapi"></script>
<script type="text/javascript">
  google.load("identitytoolkit", "1", {packages: ["ac"], language:"en"});
</script>
<script type="text/javascript">
  $(function() {
    window.google.identitytoolkit.setConfig({
        developerKey: "AIzaSyBLq4-L6c1EhVh-QmMyRFzqwph8vx-TasY",
        companyName: "uBridge",
        callbackUrl: "http://ubridge.mobi/host/callback",
        realm: "",
        userStatusUrl: "/host/userStatus",
        loginUrl: "/host/login",
        signupUrl: "/host/signup",
        homeUrl: "/host",
        logoutUrl: "/host/logout",
        idps: ["Gmail", "Yahoo", "AOL", "Hotmail"],
        tryFederatedFirst: true,
        useCachedUserStatus: true
    });
    $("#navbar").accountChooser();
  });
</script>
</head>

<body>

<!-- Top navigation bar -->
<div id="topNav">
    <div class="fixed">
        <div class="wrapper">
            <div class="backTo"><a href="#" title=""><img src="themes/braindark/images/icons/topnav/mainWebsite.png" alt="" /><span>Main website</span></a></div>
            <div class="userNav">
                <ul>
                    <li><a href="#" title=""><img src="themes/braindark/images/icons/topnav/contactAdmin.png" alt="" /><span>Contact admin</span></a></li>
                    <li><a href="#" title=""><img src="themes/braindark/images/icons/topnav/help.png" alt="" /><span>Help</span></a></li>
                </ul>
            </div>
            <div class="fix"></div>
        </div>
    </div>
</div>

<!-- Login form area -->
<div class="loginWrapper">
	<div class="loginLogo"><h1>&#956;Bridge.mobi</h1></div>
    <div class="loginPanel">
        <div class="head"><h5 class="iUser">Click to Login.</h5><div id="navbar"></div></div>
        
    </div>
</div>

<!-- Footer -->
<% include Footer %>

</body>
</html>
