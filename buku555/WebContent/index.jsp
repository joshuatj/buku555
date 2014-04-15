
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta charset="utf-8" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap core CSS -->
<link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/bootstrap/custom.css" rel="stylesheet">

<link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script>
<script src="scripts/global.js" type="text/javascript"></script>
<title>Welcome to Baku555: Social Lending</title>
</head>
<body>

	<!-- Start navigation -->
	<div class="navbar bg-green navbar-inverse navbar-fixed-top"
		role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">buku555</a>
			</div>
			<div class="collapse navbar-collapse">
				<jsp:include page="menu.html" flush="true" />
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- end navigation  -->

	<div class="container">
		<div class="landing">

			<div class="record-payment">
				<h1>Welcome to Baku555: Social Lending</h1>
				<br />
				Please create or access your account by signing in with your Facebook account.
				<br /><br />
			</div>
			
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
	<script src="scripts/cookie.js"></script>
	<div id="fb-root"></div>
	<script>
		window.fbAsyncInit = function() {
			FB.init({
				appId : '1473514739530656',
				status : true, // check login status
				cookie : false, // enable cookies to allow the server to access the session
				xfbml : true
			// parse XFBML
			});

			FB.Event.subscribe('auth.authResponseChange', function(response) {
				// Here we specify what we do with the response anytime this event occurs. 
				if (response.status == 'connected') {
					SendUserData(response);   					
				} else if (response.status == 'not_authorized') {
					alert("not_auth");
					FB.login();
				} else {
					FB.login();					
				}
			});
		};

		// Load the SDK asynchronously
		(function(d) {
			var js, id = 'facebook-jssdk', ref = d
					.getElementsByTagName('script')[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement('script');
			js.id = id;
			js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			ref.parentNode.insertBefore(js, ref);
		}(document));

		function SendUserData(resp) {
			var uid = resp.authResponse.userID;
			var accessToken = resp.authResponse.accessToken;
			//alert(response.authResponse.info);			
			//alert(response.authResponse.userID);
			FB.api('/me', function(response) {
				createCookie("loginUserId", response.id, 30);
				//console.log(response); 
			    var contextPath='<%=request.getContextPath()%>';
			    $.ajax({
			    	url: contextPath+"/LoginServlet",
		    	  	type: "POST",
		    	  	data: { 
		    	  			id : uid,
		    	  			email: response.email,
		    	  			name : response.name
		    	  			}
			    });
			  	document.forms[0].method = "POST"
				
			  	document.forms[0].action = contextPath+"/LoginServlet?id="
						+ uid + "&email=" + response.email
						+ "&accessToken=" + accessToken;
				document.forms[0].submit();	
			});
			    															
		}

		function logout() {
			FB.logout();
			alert(FB.getLoginStatus());
		}
	</script>

	<!--
  Below we include the Login Button social plugin. This button uses the JavaScript SDK to
  present a graphical Login button that triggers the FB.login() function when clicked. -->

	<div class="fb-login-button" data-scope="publish_actions,publish_stream,user_friends,email" data-max-rows="1" data-size="xlarge"
		data-auto-logout-link="false"></div>
	<form action="Login" method="GET">
		<!--This is a comment. Comments are not displayed in the browser
User ID : <input type="text" name="id" size="20"><br> 
Password : <input type="password" name="password" size="20">
-->
		<br>
		<br>
	</form>
		</div>
	</div>
	<script src="scripts/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>