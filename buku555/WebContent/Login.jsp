<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<c:if test="${sessionScope.loginUser != null}">
    <%-- <jsp:forward page="/home.jsp"/>		 --%>
     <c:redirect url="/home.jsp" />		
</c:if>
<head></head>
<body>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
	<script src="scripts/cookie.js"></script>
	<script src="scripts/global.js"></script>
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
    	  				window.location = 'home.jsp';
    	  			}
			    
			    });
			});
			    															
		}

		function logout() {
			FB.logout();
			//alert(FB.getLoginStatus());
		}
	</script>

	<!--
  Below we include the Login Button social plugin. This button uses the JavaScript SDK to
  present a graphical Login button that triggers the FB.login() function when clicked. -->

	<div class="fb-login-button" onlogin="facebookLogin()"  data-scope="publish_actions,publish_stream,user_friends,email" data-max-rows="1" data-size="xlarge"
		data-auto-logout-link="false"></div>
	<!-- <form action="Login" method="GET"> -->
		<!--This is a comment. Comments are not displayed in the browser
User ID : <input type="text" name="id" size="20"><br> 
Password : <input type="password" name="password" size="20">
-->
		<br>
		<br>
	<!-- </form> -->
</body>
</html>