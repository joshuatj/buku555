<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
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
<title>Bill Details</title>	
</head>
<body>
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
            
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
    <div class="container">
<div class="landing">
<h1>buku 555 - lending made social</h1>
<div class="recent-history-table">
<p>Bill Details</p>
<table class="table table-bordered">
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
</div>
<div class="recent-history-table">
<p>Share Details</p>
<table class="table table-bordered">
	
   <c:forEach items="${billSharedItems}" var="item">
         <tr>
         <td><c:out value="${item.user.name}" /></td>
         <td><input id="bill_splitees_${item.id}" value="${item.amountToPay}"></td>
         </tr>
   </c:forEach>
</table>
<p> <a href="BillServlet?action=edit&id=<%= request.getParameter("billId") %>">Submit</a>  </p>
</div>
</div>
</div>
<script src="scripts/bootstrap.min.js"></script>
</body>
</html>