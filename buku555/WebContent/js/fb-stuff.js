window.fbAsyncInit = function() {
	FB.init({
		appId : '1473514739530656',
		status : true, // check login status
		cookie : false, // enable cookies to allow the server to access the
						// session
		xfbml : true
	// parse XFBML
	});

	FB.Event.subscribe('auth.authResponseChange', function(response) {
		if (response.status == 'connected') {			
			//alert("connected");			
		} else if (response.status == 'not_authorized') {			
			//FB.login();
			//alert("not auth");
		} else {
			//alert("else");	
		}
	});
};
// Load the SDK asynchronously
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=1473514739530656";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));