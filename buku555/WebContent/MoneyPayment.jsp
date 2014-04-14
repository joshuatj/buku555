<%@page import="java.util.ArrayList"%>
<%@page import="database.CurrencyDBAO"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta charset="utf-8">
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
<title>Money Payment</title>
</head>
<body>
<%
		CurrencyDBAO dbo;
		ArrayList<String> currencies;
		try {
			dbo = new CurrencyDBAO();
			currencies = dbo.getDBKnownCurrencies();
		} catch (Exception e) {
	%>
	There was a problem performing this task, check database connectivity
	<%
		return;
		}
	%>
	
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
<!-- Start navigation -->
<div class="navbar bg-green navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">buku555</a>
        </div>
        <div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="">Home</a></li>
					<li><a href="SplitBill.jsp">Split Bill</a></li>
					<li><a href="LoanMoneyServlet?action=list">Record Payment</a></li>
					<li><a href="LoanItemServlet?action=list">Record Item</a></li>
					<li><a href="history.html">History</a></li>
					
					<li class="dropdown">
                	<a href="#" data-toggle="dropdown" class="dropdown-toggle">Convert Currency<b class="caret"></b></a>
               		<ul class="dropdown-menu">
                    <li><a href="getRate.jsp">Todays SGD Rate</a></li>
                    <li><a href="getHistoricRate.jsp">Historic Rates</a></li>
                    <li><a href="getHistoricOtherCurrency.jsp">Multiple Historic Currency</a></li>
                    
                    </ul>

				</ul>
			</div><!--/.nav-collapse -->
      </div>
    </div>
 <!-- end navigation  -->
 
 <div class="container">
 <div class="landing">
 <h1>buku 555 - lending made social</h1>
 <p class="lead">Record a payment</p>
<div class="record-payment">
<input type="hidden" id="fbId" />
<div id='splitBillrow' class="pin-tab-upper rounded-corners">
	<input type="text" id="name" style="width: 200px;" placeholder="Friend"/>
	<select id="selectWhoPaid"  class="dropdown-toggle">
		<option value="1">I paid</option>
		<option value="2">Paid me</option>
		<option value="3">I owe</option>
		<option value="4">Owes me</option>
	</select>
	

	
	<select name="type" class="dropdown-toggle">
	<%
		for (String s : currencies) {
		if(!s.equals("SGD")){
	%>
		<option value='<%=s%>'><%=s%></option>
	<%
		}
		else
		{
			%>
			<option value='<%=s%>' selected='selected'><%=s%></option>
			<%
		}
		}
	%>
	</select>
	
	
	<input type="text" id="amount" value="${loanItem.totalLoanAmount}" placeholder="How much?"/>
	<input placeholder="For what? (e.g. nasi lemak)">
	<button id="cancel" class="btn split-bill">Cancel</button>
</div>
<div class="pin-tab-lower">
	<table class="table table-no-border">
	<tbody>
	<tr>
		<td>Joshua Ng (me)</td>
		<td>owes</td>
		<td>Gary Kuen</td>
	</tr>			
	</tbody>
	</table>
	
	<table class="table table-no-border">
	<tbody>
		<!-- <tr>
			<td></td>
			<td>Joshua Ng (me) paid</td>
		</tr> -->
		<tr>
			<td>Attach receipts/photos</td>
			<td><button id="submit" class="btn pin-it">PIN IT!</button></td>			
		</tr>
	
	</tbody>
	</table>
</div>	
	


</div>
</div>
</div>
<script src="scripts/bootstrap.min.js"></script>
</body>
</html>