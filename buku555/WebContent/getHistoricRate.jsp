<%@page import="java.util.ArrayList"%>
<%@page import="sun.reflect.ReflectionFactory.GetReflectionFactoryAction"%>
<%@page import="database.CurrencyDBAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>getHistoricRate Test</title>
</head>
<body>

<% 
CurrencyDBAO dbo;  
ArrayList<String> currencies; 
try{
	dbo = new CurrencyDBAO();  
	currencies = dbo.getDBKnownCurrencies();
}
catch(Exception e)
{
	%>
	There was a problem performing this task, check database connectivity
	<% 
	return;
}
%>

<form action="getDataRateHistorical" id="conversion" method="GET">
  Amount:<input type="text" name="amount" value ="1.00"><br/>
  Date  :<input type="text" name="date" value="2014-01-01"><br/>
  To: <select id='currency' name='currency'>
   <% for(String s: currencies) {%>
   <option value='<%=s%>'><%=s%></option>
   <%} %>
   </select>
  <br/><input type="submit">
</form>
<br><br>
 <div id = "outp">
 
 </div>
</body>
</html>