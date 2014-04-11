<%@page import="java.util.ArrayList"%>
<%@page import="database.CurrencyDBAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Historic Other Currency</title>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"
	type="text/javascript"></script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$("#datefrom").datepicker({
							dateFormat : "yy-mm-dd",
							maxDate : " +0D"
						});
						$("#datefrom").datepicker("setDate", new Date());
						$("#datefrom")
								.datepicker("option", "showAnim", "slide");
						$("#dateto").datepicker({
							dateFormat : "yy-mm-dd",
							maxDate : " +0D"
						});
						$("#dateto").datepicker("setDate", new Date());
						$("#dateto").datepicker("option", "showAnim", "slide");

						$("#dialog").hide();
						$(document).tooltip();

						$("input[type=send], a, button")
						$("#send").button()

						$("#send")
								.click(
										function() {
											amount = $("#amount").val();
											currencyfrom = $("#currencyfrom")
													.val();
											datefrom = $("#datefrom").val();
											dateto = $("#dateto").val();
											currencyto = $("#currencyto").val();

											if (amount != ''
													&& currencyfrom != ''
													&& datefrom != ''
													&& dateto != ''
													&& currencyto != '') {

												$("#amount").css(
														"background-color",
														"inherit");
												$("#currencyfrom").css(
														"background-color",
														"inherit");
												$("#datefrom").css(
														"background-color",
														"inherit");
												$("#dateto").css(
														"background-color",
														"inherit");
												$("#currencyto").css(
														"background-color",
														"inherit");

												$
														.ajax({
															type : "GET",
															url : "/buku555/getDataHistoricalDual",
															data : "amount="
																	+ amount
																	+ "&currencyfrom="
																	+ currencyfrom
																	+ "&datefrom="
																	+ datefrom
																	+ "&dateto="
																	+ dateto
																	+ "&currencyto="
																	+ currencyto,
															success : function(
																	data) {
																$("#outp")
																		.html(
																				data);
															},
															beforeSend : function() {
																$("#outp")
																		.html(
																				"<img src='spin.gif' /> Requesting data...");
															}
														});
											} else {
												$("#outp")
														.html(
																"Please select the options above to calculate the value to repay a past debt allowing for shift in exchange rates (SGD is used as the base rate)");
												$("#dialog").dialog({
													show : {
														effect : "shake",
														duration : 1000
													},
													hide : {
														effect : "fold",
														duration : 1000
													}
												});

												if (amount == '') {
													$("#amount").css(
															"background-color",
															"red");
												}

												if (currencyfrom == '') {
													$("#currencyfrom").css(
															"background-color",
															"red");
												}

												if (datefrom == '') {
													$("#datefrom").css(
															"background-color",
															"red");
												}

												if (dateto == '') {
													$("#dateto").css(
															"background-color",
															"red");
												}

												if (currencyto == '') {
													$("#currencyto").css(
															"background-color",
															"red");
												}

												return false;
											}

										});
					});
</script>

</head>
<body>
	<h1>Get Historic Payment Rate</h1>
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

	<form action="getDataHistoricalDual" id="conversion" method="GET">
		<table>
			<tr>
				<td>Amount:</td>
				<td><input type="text" id="amount" name="amount" value="1.00" title="The amount of the transaction in the inital currency"></td>
			</tr>
			<tr>
				<td>From:</td>
				<td><select id='currencyfrom' name='currencyfrom' title="The currency used for the inital transaction">
						<%
							for (String s : currencies) {
						%>
						<option value='<%=s%>'><%=s%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td>Date From:</td>
				<td><input type="text" id="datefrom" name="datefrom" title="The date to perform the conversion from inital currency to SGD"
					value="2014-01-01"></td>
			</tr>
			<tr>
				<td>Date To:</td>
				<td><input type="text" name="dateto" id="dateto" title="The date to perform the conversion from SGD to final currency"
					value="2014-01-01"></td>
			</tr>
			<tr>
				<td>To:</td>
				<td><select id='currencyto' id="currencyto" name='currencyto' title="The currency to settle the transaction in">
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
	<div id="outp">Please select the options above to calculate the
		value to repay a past debt allowing for shift in exchange rates (SGD
		is used as the base rate)</div>

	<div id="dialog" title="Form Information">
		<p>The form has not been completed, items are missing. Please
			correct the fields shown in red.</p>
	</div>
</body>
</html>