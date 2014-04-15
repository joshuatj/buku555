<%@page import="buku.dao.LoanItemDAO, buku.entities.LoanItem, java.util.List, java.util.Iterator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>Loan Item List</title>
<!-- Bootstrap core CSS -->
 <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/bootstrap/custom.css" rel="stylesheet">
</head>
<body>
<script type="text/javascript"></script>

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
				<jsp:include page="menu.html" flush="true" />
			</div><!--/.nav-collapse -->
      </div>
    </div>
    
    <div class="container">
    <div class="landing">
    <h1>buku 555 - lending made social</h1>
    <div class="recent-history-table">
<p>Things I Lend</p>
<table class="table table-striped table-bordered">
	<thead>
     <tr>
         <th>Description</th>
         <th>Date</th>
         <th>To User</th>
         <th>Item Type</th>
         <th>Loan Status</th>
         <th colspan=2>Action</th>
     </tr>
 	</thead>
 	<tbody>
          <c:forEach items="${loanItems}" var="item">
                <tr>
                    <td><c:out value="${item.description}" /></td>
                    <td><fmt:formatDate pattern="yyyy-MMM-dd" value="${item.date}" /></td>
                    <%-- <td><c:out value="${item.userByLoanUserId.fbUserId}" /></td> --%>
                    <td><c:out value="${item.userByLoanUserId.name}" /></td>
                    <td><c:out value="${item.itemType.itemTypeName}" /></td>
                    <td><c:out value="${item.loanStatus}" /></td>
                    <td><a href="LoanItemServlet?action=edit&loanType=1&id=<c:out value="${item.id}"/>">Update</a></td>
                    <td><a href="LoanItemServlet?action=delete&id=<c:out value="${item.id}"/>">Delete</a></td>
                    <%-- <td><a href="TestServlet?action=split&billId=<c:out value="${item.id}"/>">Split</a></td> --%>
                </tr>
            </c:forEach>
    </tbody>
</table>
</div>
<div class="recent-history-table">
<p>Things I Borrow</p>
<table class="table table-striped table-bordered">
	<thead>
     <tr>
         <th>Description</th>
         <th>Date</th>
         <th>From User</th>
         <th>Item Type</th>
         <th>Loan Status</th>
         <th colspan=2>Action</th>
     </tr>
 	</thead>
 	<tbody>
          <c:forEach items="${borrowItems}" var="item">
                <tr>
                    <td><c:out value="${item.description}" /></td>
                    <td><fmt:formatDate pattern="yyyy-MMM-dd" value="${item.date}" /></td>
                    <%-- <td><c:out value="${item.userByLoanUserId.fbUserId}" /></td> --%>
                    <td><c:out value="${item.userByOwnerUserId.name}" /></td>
                    <td><c:out value="${item.itemType.itemTypeName}" /></td>
                    <td><c:out value="${item.loanStatus}" /></td>
                    <td><a href="LoanItemServlet?action=edit&loanType=2&id=<c:out value="${item.id}"/>">Update</a></td>
                    <td><a href="LoanItemServlet?action=delete&id=<c:out value="${item.id}"/>">Delete</a></td>
                    <%-- <td><a href="TestServlet?action=split&billId=<c:out value="${item.id}"/>">Split</a></td> --%>
                </tr>
            </c:forEach>
    </tbody>
</table>
</div>

</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="scripts/bootstrap.min.js"></script>
</body>
</html>