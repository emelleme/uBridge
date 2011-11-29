$(document).bind("mobileinit", function(){
  //apply overrides here
  //$.mobile.defaultTransition = 'fade';
  
  
});

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
        language: "en",
        idps: ["Gmail", "Yahoo", "AOL", "Hotmail"],
        tryFederatedFirst: true,
        useCachedUserStatus: false
    });
    $("#hostlogin").accountChooser();
  });
