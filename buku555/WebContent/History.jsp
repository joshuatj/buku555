<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<title>History</title>
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
            <li><a href="HistoryServlet">History</a></li>
            
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

<div class="container">
<div class="landing">
<h1>buku 555 - lending made social</h1>
<p class="lead">History</p>
<div class="recent-history-table">
<table class="table table-striped table-bordered">
	<thead>
     <tr>
         <!-- <th>Name</th> -->
         <th>Action</th>
         <th>Amount</th>
         <th>Reason</th>
         <th>Photo</th>
         <th>On</th>
     </tr>
 	</thead>
 	<tbody>
          <c:forEach items="${historyItems}" var="item">
                <tr>
                    <td>
                    	<%-- <c:if test="${item.userByFromUserId == sessionScope.loginUser.id}">
                    		<c:out value="I paid ${item.userByToUserId.name}"/>
                    	</c:if> --%>
                    	<c:choose>
						   <c:when test="${item.userByFromUserId.id == sessionScope.loginUser.id}">
							   <c:if test="${item.transactionType == 1}">
							   		<c:out value="I paid ${item.userByToUserId.name}"/>
							   </c:if>
							   <c:if test="${item.transactionType == 2}">
							   		<c:out value="I owe ${item.userByToUserId.name}"/>
							   </c:if>		
						   </c:when>
						   <c:when test="${item.userByToUserId.id == sessionScope.loginUser.id}">
							   <c:if test="${item.transactionType == 1}">
							   		<c:out value="${item.userByFromUserId.name} paid me"/>
							   </c:if>
							   <c:if test="${item.transactionType == 2}">
							   		<c:out value="${item.userByFromUserId.name} owe me"/>
							   </c:if>	
						   		
						   </c:when>
						   <c:otherwise></c:otherwise>
						</c:choose>
                    </td>
                    <td><c:out value="${item.paidAmount}" /></td>
                    <td><c:out value="${item.reason}" /></td>
                    <td>
                    	<c:if test="${item.photo != null}">
                    		<a target="_blank" href="UploadServlet?type=transaction&getfile=<c:out value="${item.photo}"/> ">
                    			<img src="UploadServlet?type=transaction&getthumb=<c:out value="${item.photo}"/> ">
                    		</a>
                    	</c:if>
                    </td>
                    <td><c:out value="${item.transactionDate}" /></td>
                    <%-- <td><c:out value="${item.currencyId}" /></td> --%>
                    
                </tr>
            </c:forEach>
    </tbody>
</table>
</div>
</div>
</div>
<script src="scripts/bootstrap.min.js"></script>
</body>
</html>