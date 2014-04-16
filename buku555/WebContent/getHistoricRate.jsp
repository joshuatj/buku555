<%@page import="java.util.ArrayList"%>
<%@page import="database.CurrencyDBAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Historic Rate</title>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"
	type="text/javascript"></script>

<script type="text/javascript">
	$(document).ready(

			function() {

				$("#date").datepicker({dateFormat : "yy-mm-dd", maxDate: " +0D"});
				$("#date").datepicker( "option", "showAnim", "slide" );
				$("#date").datepicker("setDate", new Date());
				
				$("#dialog").hide();
				$(document).tooltip();
				
				$("input[type=send], a, button")
			    $("#send").button()
			    
				$("#send").click(
						function() {
							amount = $("#amount").val();
							date = $("#date").val();
							currency = $("#currency").val();
							
							if(amount != '' && date != '' && currency != '' )
							{
								
							$("#amount").css("background-color","inherit");
							$("#date").css("background-color", "inherit");
							$("#currency").css("background-color", "inherit");
								
							$.ajax({
								type : "GET",
								url : "/buku555/getDataRateHistorical",
								data : "amount=" + amount + "&date=" + date
										+ "&currency=" + currency,
								success : function(data) {
									$("#outp").html(data);
								}
	,
														beforeSend : function() {
															$("#outp")
																	.html(
																			"<img src='spin.gif' /> Requesting data...");
														}
													});
							}
							else
								{
								$("#outp").html("Please select a currency, date and value above to find out the the exchange rate from SGD."); 
								$("#dialog").dialog({
								      show: {
								        effect: "shake",
								        duration: 1000
								      },
								      hide: {
								        effect: "fold",
								        duration: 1000
								      }
								});
								
								if(amount == '')
								{
								$("#amount").css("background-color", "red");
								}
								
								if(date == '')
								{
								$("#date").css("background-color", "red");
								}
								
								if(currency == '')
								{
								$("#currency").css("background-color", "red");
								}
								
								return false;}
										});
					});
</script>



</head>
<body>
	<h1>Get Historic Rate</h1>
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

	<form action="getDataRateHistorical" id="conversion" method="GET">
		<table>
			<tr>
				<td>Amount:</td>
				<td><input type="text" id="amount" name="amount" value="1.00" title="This is the amount to convert in Singapore Dollars"></td>
			</tr>
			<tr>
				<td>Date :</td>
				<td><input type="text" id="date" name="date" value="" title="This is the day used for conversion"></td>
			</tr>
			<tr>
				<td>To:</td>
				<td><select id='currency' name='currency' title="This is the currency we are converting to">
						<%
							for (String s : currencies) {
						%>
						<option value='<%=s%>'><%=s%></option>
						<%
							}
						%>
				</select></td>
			</tr>
		</table>
	</form>
	<br>
	<button id="send">Submit</button>
	<br>
	<br>
	<div id="outp">Please select a currency, date and value above to
		find out the the exchange rate from SGD.</div>

	<div id="dialog" title="Form Information">
		<p>The form has not been completed, items are missing. Please
			correct the fields shown in red.</p>
	</div>
</body>
</html>