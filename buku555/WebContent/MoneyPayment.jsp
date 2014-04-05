<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script>
<script src="scripts/global.js" type="text/javascript"></script>
<title>Money Payment</title>
</head>
<body>
<div id="fb-root"></div>
<script type="text/javascript">
window.fbAsyncInit = function() {
	FB.init({
		appId: '1473514739530656', status: true, cookie: true, oauth : true, xfbml: true
	});	

	FB.getLoginStatus(function (response) {
		
		if (response.authResponse) {	// if the user is authorized...
			var accessToken = response.authResponse.accessToken
			var tokenUrl = "https://graph.facebook.com/me/friends?access_token=" + accessToken + "&callback=?"

			// Place <input id="name" /> and <input id="fbuid" /> into HTML
			//console.log(tokenUrl);
			$("#name").autocomplete({
				source: function(request, add) {
					$this = $(this)
					
					// Call out to the Graph API for the friends list
					$.ajax({
						url: tokenUrl,
						dataType: "jsonp",
						success: function(results){
							var maxResults = 10; //results.data.length
							// Filter the results and return a label/value object array  
							var formatted = [];
							for(var i = 0; i< results.data.length; i++) {
								if (results.data[i].name.toLowerCase().indexOf($('#name').val().toLowerCase()) >= 0)
								formatted.push({
									label: results.data[i].name,
									value: results.data[i].id
								})
							}
							add(formatted);
						}
					});
				},
				select: function(event, ui) {
					console.log(ui.item.label + "-" + ui.item.value);
					// Fill in the input fields
					$('#name').val(ui.item.label);
					$('#fbId').val(ui.item.value);
					
					return false;
				},
				minLength: 2
			});
		}
	});
	
	$(document).ready(function() {
		
        if ('${select}' == '1'){
        	$('#selectWhoPaid').val('1');
        	//$('#fromWho').val('${loanItem.userByLoanUserId.fbUserId}');
        	$('#fbId').val('${loanItem.userByOwnerUserId.fbUserId}');
        	$('#name').val('${loanItem.userByOwnerUserId.name}');
        } else if ('${select}' == '2'){
        	$('#selectWhoPaid').val('2');
        	$('#fbId').val('${loanItem.userByLoanUserId.fbUserId}');
        	//$('#toWho').val('${loanItem.userByOwnerUserId.fbUserId}');
        	$('#name').val('${loanItem.userByLoanUserId.name}');
        } else if ('${select}' == '3'){
        	$('#selectWhoPaid').val('3');
        } else if ('${select}' == '4'){
    		$('#selectWhoPaid').val('4');
    	}
    	
        
    	$( "#submit" ).click(function( event ) {
    		$.ajax({ 
    	   		type: "POST",
    	   		url: "LoanMoneyServlet",
    	   		data: {
    	   			amount : $("#amount").val(),
    	   			selectWhoPaid : $("#selectWhoPaid").val(),
    	   			name : $('#name').val(),
    	   			fbId: $('#fbId').val()
    	   			},
    	   		success : function (data) {
    	   			alert(data);
    	   		}
    	   		});
        });
    	
    });
};

(function(d){
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    ref.parentNode.insertBefore(js, ref);
   }(document));
</script>

<input type="hidden" id="fbId" />
<div><input type="text" id="name" style="width: 200px;"/></div>
<div>
	<select id="selectWhoPaid">
	<option value="1">I paid</option>
	<option value="2">Paid me</option>
	<option value="3">I owe</option>
	<option value="4">Owes me</option>
	</select>
</div>
<div>
	<input type="text" id="amount" value="${loanItem.totalLoanAmount}" />
</div> <br>
<div>
	<button id="submit">Submit</button>
</div>

</body>
</html>