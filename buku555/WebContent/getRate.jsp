<%@page import="java.util.ArrayList"%>
<%@page import="database.CurrencyDBAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:if test="${sessionScope.loginUser == null}">
    <c:redirect url="/Login.jsp" />		
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta charset="utf-8" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!--  Common CSS -->
<jsp:include page="template/css.jsp" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<title>Get Today's Rate</title>

<script type="text/javascript">
	jQuery(document)
			.ready(
					function() {

						$(document).tooltip();

						$("#dialog").hide();
						$(document).tooltip();

						$("input[type=send], a, button")
						$("#send").button()

						$("#send")
								.click(
										function() {
											amount = $("#amount").val();
											currency = $("#currency").val();

											if (amount != '' && currency != '') {

												$("#amount").css(
														"background-color",
														"inherit");
												$("#currency").css(
														"background-color",
														"inherit");

												$
														.ajax({
															type : "GET",
															url : "/buku555/getDataRate",
															data : "amount="
																	+ amount
																	+ "&currency="
																	+ currency
																	+ "&direction=0",
															success : function(
																	data) {
																$("#outp")
																		.html(
																				"At the current rate $"
																						+ amount
																						+ "SGD results in "
																						+ data
																						+ " in "
																						+ currency);
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
																"Please select a currency and value above to find out the the exchange rate from SGD.");
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

												if (currency == '') {
													$("#currency").css(
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

<!-- Start navigation -->
<jsp:include page="template/menu.jsp" flush="true" />
<!-- end navigation  -->

	<div class="container">
		<div class="landing">

			<div class="record-payment">
				<h1>Get Todays Rate</h1>
				<br />
				<form action="getDataRate" id="conversion" method="GET">
					<table class="table table-striped table-bordered">
						<tr>
							<td>Amount:</td>
							<td><input type="text" id="amount" name="amount"
								value="1.00"
								title="This is the amount to convert in Singapore Dollars"></td>
						</tr>
						<tr>
							<td>To:</td>
							<td><select id='currency' name='currency'
								title="This is the currency we are converting to">
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
				<div id="outp">Please select a currency and value above to
					find out the the exchange rate from SGD.</div>

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