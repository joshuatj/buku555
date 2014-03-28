<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script>
<title>Insert title here</title>	
</head>
<body>
<p>Bill Details</p>
<table border="1" cellpadding="0" cellspacing="0">
<tr>
	<td>Name</td>
	<td><input id="" value="${bill.user.fbUserId}"></td>
</tr>
<tr>
	<td>Total Amount</td>
	<td><input id="" value="${bill.totalAmount}"></td>
</tr>
<tr>
	<td>Date</td>
	<td><input id="" value="${bill.date}"></td>
</tr>
<tr>
	<td>Reason</td>
	<td><input id="" value="${bill.reason}"></td>
</tr>
</table>
<p>Share Details</p>
<table border="1" cellpadding="0" cellspacing="0">
	
   <c:forEach items="${billSharedItems}" var="item">
         <tr>
         <td><c:out value="${item.user.fbUserId}" /></td>
         <td><input id="bill_splitees_${item.id}" value="${item.amountToPay}"></td>
         </tr>
   </c:forEach>
</table>
Total Amount: ${totalAmount}
<p> <a href="BillServlet?action=edit&id=<%= request.getParameter("billId") %>">Submit</a>  </p>
</body>
</html>