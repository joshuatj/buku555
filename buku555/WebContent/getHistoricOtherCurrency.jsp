<%@page import="java.util.ArrayList"%>
<%@page import="database.CurrencyDBAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta charset="utf-8" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!--  Common CSS -->
<jsp:include page="template/css.jsp" />

<!-- <link type="text/css" href="css/jquery-ui.css" rel="stylesheet" /> -->
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<title>Get Historic Multi Rate</title>

<script type="text/javascript">
	jQuery(document)
			.ready(
					function() {

						$("#datefrom").datepicker({
							dateFormat : "yy-mm-dd",
							maxDate : " +0D",
							onSelect: function(selected) {
						          $("#dateto").datepicker("option","minDate", selected)
						        }
						});
						$("#datefrom").datepicker("setDate", new Date());
						$("#datefrom")
								.datepicker("option", "showAnim", "slide");
						$("#dateto").datepicker({
							dateFormat : "yy-mm-dd",
							maxDate : " +0D",
							onSelect: function(selected) {
							          $("#datefrom").datepicker("option","maxDate", selected)
							        }
						});
						
					        
						
						$("#dateto").datepicker("setDate", new Date());
						$("#dateto").datepicker("option", "showAnim", "slide");

						$("#dialog").hide();

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
																				amount
																						+ " "
																						+ currencyfrom
																						+ " on the "
																						+ datefrom
																						+ " resulted in "
																						+ data
																						+ " "
																						+ currencyto
																						+ " on "
																						+ dateto
																						+ "<br />It is assumed funds are held in SGD in the period between the start and end date");
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

	<!-- Start navigation -->
		<jsp:include page="template/menu.jsp" flush="true" />
	<!-- end navigation  -->

	<div class="container">
		<div class="landing">

			<div class="record-payment">
				<h1>Get Historic Multiple Payment Rate</h1>
				<br />
				<%
					CurrencyDBAO dbo;
					ArrayList<String> currencies;
					try {
						dbo = new CurrencyDBAO();
						currencies = dbo.getDBKnownCurrencies();
					} catch (Exception e) {
				%>
				There was a problem performing this task, check database
				connectivity
				<%
					return;
					}
				%>

				<form action="getDataHistoricalDual" id="conversion" method="GET">
					<table class="table table-striped table-bordered">
						<tr>
							<td>Amount:</td>
							<td><input type="text" id="amount" name="amount"
								value="1.00"
								title="The amount of the transaction in the inital currency"></td>
						</tr>
						<tr>
							<td>From:</td>
							<td><select id='currencyfrom' name='currencyfrom'
								title="The currency used for the inital transaction">
									<%
										for (String s : currencies) {
											if (!s.equals("SGD")) {
									%>
									<option value='<%=s%>'><%=s%></option>
									<%
										} else {
									%>
									<option value='<%=s%>' selected='selected'><%=s%></option>
									<%
										}
										}
									%>
							</select></td>
						</tr>
						<tr>
							<td>Date From:</td>
							<td><input type="text" id="datefrom" name="datefrom"
								title="The date to perform the conversion from inital currency to SGD"
								value="2014-01-01"></td>
						</tr>
						<tr>
							<td>Date To:</td>
							<td><input type="text" name="dateto" id="dateto"
								title="The date to perform the conversion from SGD to final currency"
								value="2014-01-01"></td>
						</tr>
						<tr>
							<td>To:</td>
							<td><select id='currencyto' id="currencyto"
								name='currencyto'
								title="The currency to settle the transaction in">
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
				<br> <br>
				<div id="outp">
					Please select the options above to calculate the value to repay a
					past debt allowing for shift in exchange rates<br /> (SGD is used
					as the base rate)
				</div>

				<div id="dialog" title="Form Information">
					<p>The form has not been completed, items are missing. Please
						correct the fields shown in red.</p>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="template/js.jsp" />
</body>
</html>





