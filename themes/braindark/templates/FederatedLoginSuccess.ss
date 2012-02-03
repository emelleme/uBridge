<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% base_tag %>
<script type='text/javascript' src='https://ajax.googleapis.com/jsapi'></script>
<script type='text/javascript'> 
  google.load("identitytoolkit", "1.0", {packages: ["notify"]});
</script> 
<script type='text/javascript'>
  window.google.identitytoolkit.notifyFederatedSuccess({ "email": "$$Email", "registered": true });
  // use window.google.identitytoolkit.notifyFederatedError(); in case of error
</script>
</head>
<body>
Good
</body>
</html>
