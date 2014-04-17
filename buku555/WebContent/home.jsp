<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<c:if test="${sessionScope.loginUser == null}">
    <c:redirect url="/Login.jsp" />		
</c:if>
<title>Home</title>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
<!-- <script type="text/javascript" src="js/fb-stuff.js"></script> -->
<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script> -->
<!-- Style source: tdfriendselector.scss -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/cookie.js" type="text/javascript"></script>
<script type="text/javascript">
	/* $(function() {
		if ($.browser.msie && $.browser.version.substr(0, 1) < 7) {
			$('li').has('ul').mouseover(function() {
				$(this).children('ul').show();
			}).mouseout(function() {
				$(this).children('ul').hide();
			});
		}
	}); */
</script>

</head>
<body>
	
	<div id="fb-root"></div>
	<script type="text/javascript">
	window.fbAsyncInit = function () {

		FB.init({appId: '1473514739530656', status: true, cookie: false, xfbml: false, oauth: true});
		
		FB.Event.subscribe('auth.authResponseChange', function(response) {
			if (response.status == 'connected') {
				//alert("connected");
				//init();
			} else if (response.status == 'not_authorized') {
				//FB.login();
				//alert("not auth");
			} else {
				//window.navigate("fbLogin.jsp");				
				//location.href = "Login.jsp";
			}
		});
		
		$(document).ready(function () {
			
			FB.getLoginStatus(function(response) {
				if (response.authResponse) {
					$("#login-status").html("Logged in");
				} else {
					$("#login-status").html("Not logged in");
				}
			});

			$("#btnLogin").click(function (e) {
				e.preventDefault();
				FB.login(function (response) {
					if (response.authResponse) {
						console.log("Logged in");
						$("#login-status").html("Logged in");
					} else {
						console.log("Not logged in");
						$("#login-status").html("Not logged in");
					}
				}, {});
			});
			
			function logout(){
				var contextPath='<%=request.getContextPath()%>';
			    $.ajax({
			    	url: contextPath+"/LogoutServlet",
		    	  	type: "POST",
    	  			success: function( data ) {
    	  				eraseCookie('loginUserId');
    					location.href = "Login.jsp";
    	  			}
			    
			    });
			}

			$("#btnLogout").click(function (e) {
				logout();
				//e.preventDefault();
				//FB.logout();
				$("#login-status").html("Not logged in");
			});

		});
	};
	
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
			return;
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=1473514739530656";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
	
	(function () {
		var e = document.createElement('script');
		e.async = true;
		e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
		document.getElementById('fb-root').appendChild(e);
	}());
	</script>	
	<ul id="menu">
		<li><a href="#">Home</a></li>
		<li><a href="#">History</a>
			<ul>
				<li><a href="#">Test</a></li>
			</ul></li>
		<li><p style="font-family: arial; color: red; font-size: 20px;">Social
				Lending App</p></li>
		<li><a href="#">Currency</a>
			<ul>
				<li><a href="getRate.jsp">Get Rate</a></li>
				<li><a href="getHistoricRate.jsp">Get Historic Rate</a></li>
				<li><a href="getHistoricOtherCurrency.jsp">Get Multiple Conversion</a></li>
			</ul></li>
		<li><div class="fb-login-button" data-max-rows="10"
				data-size="small" data-show-faces="true"
				data-auto-logout-link="false"></div></li>
		<li><a id="btnLogout">Logout</a></li>
	</ul>
	<hr>
	<form>
		Get Login Status: <input type="button" value="get login status" onclick="GetUserLoginStatus()">			
	</form>
	<form>
		Get Current User Details: <input type="button" value="get user details" onclick="GetCurrentUserDetails()">			
	</form>
	<script type="text/javascript">
	function GetFriendDetailsByID(id) {				
		//alert(response.authResponse.info);			
		//alert(response.authResponse.userID);		
		FB.api('/'+id, function(response) {    	
			alert(response.name); 				
			//alert(response.gender);
		});		    																
	}	
	function GetUserLoginStatus() {
		FB.getLoginStatus(function(response) {
			  if (response.status === 'connected') {
			    alert("connected");
			  } else if (response.status === 'not_authorized') {
			    // the user is logged in to Facebook, 
			    // but has not authenticated your app
				  alert("not authorized");
			  } else {
			    // the user isn't logged in to Facebook.
			    alert("not login");
			  }
			 });
	}	
	function GetCurrentUserDetails() {
		FB.api('/me', function(response) {    	
			//alert(response.name); 
			console.log(response.email);
			//alert(response.location.name);
			//alert(response.hometown.name);
		});
	}
	</script>
	
</body>
</html>


