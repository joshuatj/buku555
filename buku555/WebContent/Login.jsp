<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<c:if test="${sessionScope.loginUser != null}">
     <c:redirect url="/SplitBill.jsp" />		
</c:if>
<head>
<!-- Bootstrap core CSS -->
<link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/bootstrap/custom.css" rel="stylesheet">
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<title>Welcome to Buku555: Social Lending</title>
</head>
<body>
	
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

			FB.Event.subscribe('auth.statusChange', function(response) {
				// Here we specify what we do with the response anytime this event occurs. 
				if (response.status == 'connected') {
					//var fbUserId = readCookie('loginUserId');
					//if (fbUserId == null)
					//	SendUserData(response);   					
				} else if (response.status == 'not_authorized') {
					//FB.login();
				} else {
					//FB.login();					
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
		
		
		function facebookLogin(){
			FB.getLoginStatus(function(response) {
				console.log(response);
				  if (response.status === 'connected') {
					  //var fbUserId = readCookie('loginUserId');
					  //if (fbUserId == null)
					  	SendUserData(response);
				    /* var uid = response.authResponse.userID;
				    var accessToken = response.authResponse.accessToken; */
				  } else if (response.status === 'not_authorized') {
				    // the user is logged in to Facebook, 
				    // but has not authenticated your app
				  } else {
				    // the user isn't logged in to Facebook.
				  }
			 });
		}
		function SendUserData(resp) {
			var uid = resp.authResponse.userID;
			var accessToken = resp.authResponse.accessToken;
			//alert(response.authResponse.info);			
			//alert(response.authResponse.userID);
			FB.api('/me', function(response) {
				//console.log(response); 
			    var contextPath='<%=request.getContextPath()%>';
			    $.ajax({
			    	url: contextPath+"/LoginServlet",
		    	  	type: "POST",
		    	  	data: { 
		    	  			id : uid,
		    	  			email: response.email,
		    	  			name : response.name
		    	  			},
    	  			success: function( data ) {
    	  				//console.log(response.id);
    	  				createCookie("loginUserId", response.id, 30);
    	  				window.location = 'SplitBill.jsp';
    	  			}
			    
			    });
			});
			    															
		}

		function logout() {
			FB.logout();
			//alert(FB.getLoginStatus());
		}
	</script>
	
	
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
				
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- end navigation  -->
	
	<div class="container">
		<div class="landing">

			<div class="record-payment">
				<h1>Welcome to buku555 - lending made social</h1>
				<br />
				Please create or access your account by signing in with your Facebook account.
				<br /><br />
			</div>
		

	<!--
  Below we include the Login Button social plugin. This button uses the JavaScript SDK to
  present a graphical Login button that triggers the FB.login() function when clicked. -->

	<div class="fb-login-button" onlogin="facebookLogin()"  data-scope="publish_actions,publish_stream,user_friends,email,read_stream" data-max-rows="1" data-size="xlarge"
		data-auto-logout-link="false"></div>
	<!-- <form action="Login" method="GET"> -->
		<!--This is a comment. Comments are not displayed in the browser
User ID : <input type="text" name="id" size="20"><br> 
Password : <input type="password" name="password" size="20">
-->
		<br>
		<br>
	<!-- </form> -->
	</div>
	</div>
	 <jsp:include page="template/js.jsp" />
</body>
</html>