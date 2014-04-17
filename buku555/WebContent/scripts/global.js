function getURLParam(sParam){
	var sPageURL = window.location.search.substring(1); 
	var sURLVariables = sPageURL.split('&'); 
	for (var i = 0; i < sURLVariables.length; i++) { 
		var sParameterName = sURLVariables[i].split('='); 
		if (sParameterName[0] == sParam)
			return sParameterName[1];
	}
};


//some validation function
function validateEmpty(value){
	if (value == '')
		return false;
}

function validateNumber(value){
	if (value == '' || !$.isNumeric(value) || value <= 0){
		return false;
	}
	return true;
}

function logout(contextPath){
    $.ajax({
    	url: contextPath + "/LogoutServlet",
	  	type: "POST",
		success: function( data ) {
			eraseCookie('loginUserId');
			location.href = "Login.jsp";
		}  
    });
}


