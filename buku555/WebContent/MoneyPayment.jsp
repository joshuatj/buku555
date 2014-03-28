<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script>
<script>
$(document ).ready(function() {
	
	if ('${select}' == '1')
		$('#selectWhoPaid').val('1');
	else 
		$('#selectWhoPaid').val('2');
	
	$( "#submit" ).click(function( event ) {
		var whoPaid = $("#selectWhoPaid").val();
		var fromWho, toWho;
		if (whoPaid = "1"){
			fromWho = $("#fromWho").val();
			toWho = $("#toWho").val();
		} else {
			fromWho = $("#toWho").val();
			toWho = $("#fromWho").val();
		}
		
			
		$.ajax({ 
	   		type: "POST",
	   		url: "LoanMoneyServlet",
	   		data: {
	   			amount : $("#amount").val(),
	   			fromWho: fromWho, 
	   			toWho : toWho
	   			},
	   		success : function (data) {
	   			alert(data);
	   		}
	   		});
    });
	
});

</script>
<title>Money Payment</title>
</head>
<body>
<input type="hidden" id="fromWho" value="${loanItem.userByLoanUserId.id}" />
<input type="hidden" id="toWho" value="${loanItem.userByOwnerUserId.id}"/>
<div><input type="text" id="whoPaid" value="${loanItem.userByLoanUserId.fbUserId}"/></div>
<div>
	<select id="selectWhoPaid">
	<option value="1">I paid</option>
	<option value="2">Paid me</option>
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