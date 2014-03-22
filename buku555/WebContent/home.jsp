<!DOCTYPE html>
<html>
<head>
<title>Home</title>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
<!-- <script type="text/javascript" src="js/fb-stuff.js"></script> -->
<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tdfriendselector.css" />
<!-- Style source: tdfriendselector.scss -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<script type="text/javascript">
	$(function() {
		if ($.browser.msie && $.browser.version.substr(0, 1) < 7) {
			$('li').has('ul').mouseover(function() {
				$(this).children('ul').show();
			}).mouseout(function() {
				$(this).children('ul').hide();
			});
		}
	});
</script>
</head>
<body>
	<div id="fb-root"></div>
	<script type="text/javascript">
	window.fbAsyncInit = function () {

		FB.init({appId: '1473514739530656', status: true, cookie: false, xfbml: false, oauth: true});
		
		FB.Event.subscribe('auth.authResponseChange', function(response) {
			if (response.status == 'connected') {
				alert("connected");
				//init();
			} else if (response.status == 'not_authorized') {
				//FB.login();
				//alert("not auth");
			} else {
				//window.navigate("fbLogin.jsp");				
				location.href = "fbLogin.jsp";
			}
		});
		
		$(document).ready(function () {
			var selector1, selector2, logActivity, callbackFriendSelected, callbackFriendUnselected, callbackMaxSelection, callbackSubmit;

			// When a friend is selected, log their name and ID
			callbackFriendSelected = function(friendId) {
				var friend, name;
				friend = TDFriendSelector.getFriendById(friendId);
				name = friend.name;
				logActivity('Selected ' + name + ' (ID: ' + friendId + ')');
			};

			// When a friend is deselected, log their name and ID
			callbackFriendUnselected = function(friendId) {
				var friend, name;
				friend = TDFriendSelector.getFriendById(friendId);
				name = friend.name;
				logActivity('Unselected ' + name + ' (ID: ' + friendId + ')');
			};

			// When the maximum selection is reached, log a message
			callbackMaxSelection = function() {
				logActivity('Selected the maximum number of friends');
			};

			// When the user clicks OK, log a message
			callbackSubmit = function(selectedFriendIds) {
				logActivity('Clicked OK with the following friends selected: ' + selectedFriendIds.join(", "));
			};

			// Initialise the Friend Selector with options that will apply to all instances
			TDFriendSelector.init({debug: true});

			// Create some Friend Selector instances
			selector1 = TDFriendSelector.newInstance({
				callbackFriendSelected   : callbackFriendSelected,
				callbackFriendUnselected : callbackFriendUnselected,
				callbackMaxSelection     : callbackMaxSelection,
				callbackSubmit           : callbackSubmit
			});
			selector2 = TDFriendSelector.newInstance({
				callbackFriendSelected   : callbackFriendSelected,
				callbackFriendUnselected : callbackFriendUnselected,
				callbackMaxSelection     : callbackMaxSelection,
				callbackSubmit           : callbackSubmit,
				maxSelection             : 1,
				friendsPerPage           : 5,
				autoDeselection          : true
			});

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

			$("#btnLogout").click(function (e) {
				e.preventDefault();
				FB.logout();
				$("#login-status").html("Not logged in");
			});

			$("#btnSelect1").click(function (e) {
				e.preventDefault();
				selector1.showFriendSelector();
			});

			$("#btnSelect2").click(function (e) {
				e.preventDefault();
				selector2.showFriendSelector();
			});

			logActivity = function (message) {
				$("#results").append('<div>' + message + '</div>');
			};
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
				<li><a href="#">Test</a></li>
			</ul></li>
		<li><div class="fb-login-button" data-max-rows="10"
				data-size="small" data-show-faces="true"
				data-auto-logout-link="true"></div></li>
	</ul>
	<hr>

	<div class="jumbotron">
		<a href="#" id="btnSelect1" class="btn btn-primary btn-large">Select
			your friends</a>
		<hr>
		<div id="results" class="lead">
			<p>You will see result here</p>
		</div>
	</div>

	<!-- Markup for These Days Friend Selector -->
	<div id="TDFriendSelector">
		<div class="TDFriendSelector_dialog">
			<a href="#" id="TDFriendSelector_buttonClose">x</a>
			<div class="TDFriendSelector_form">
				<div class="TDFriendSelector_header">
					<p>Select your friends</p>
				</div>
				<div class="TDFriendSelector_content">
					<p>Then you can invite them to join you in the app.</p>
					<div
						class="TDFriendSelector_searchContainer TDFriendSelector_clearfix">
						<div class="TDFriendSelector_selectedCountContainer">
							<span class="TDFriendSelector_selectedCount">0</span> / <span
								class="TDFriendSelector_selectedCountMax">0</span> friends
							selected
						</div>
						<input type="text" placeholder="Search friends"
							id="TDFriendSelector_searchField" />
					</div>
					<div class="TDFriendSelector_friendsContainer"></div>
				</div>
				<div class="TDFriendSelector_footer TDFriendSelector_clearfix">
					<a href="#" id="TDFriendSelector_pagePrev"
						class="TDFriendSelector_disabled">Previous</a> <a href="#"
						id="TDFriendSelector_pageNext">Next</a>
					<div class="TDFriendSelector_pageNumberContainer">
						Page <span id="TDFriendSelector_pageNumber">1</span> / <span
							id="TDFriendSelector_pageNumberTotal">1</span>
					</div>
					<a href="#" id="TDFriendSelector_buttonOK">OK</a>
				</div>
			</div>
		</div>
	</div>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/tdfriendselector.js"></script>
	<!-- <script src="js/example.js"></script> -->
</body>
</html>


