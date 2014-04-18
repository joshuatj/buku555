<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:if test="${sessionScope.loginUser == null}">
    <c:redirect url="/Login.jsp" />		
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!--  Common CSS -->
<jsp:include page="template/css.jsp" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<title>Bill Management</title>
</head>
<body>
<!-- Start navigation -->
<jsp:include page="template/menu.jsp" flush="true" />
<!-- end navigation  -->

<div class="container">
<div class="landing">
<h1>buku 555 - lending made social</h1>
<p class="lead">Bill History</p>
<div class="recent-history-table">
<table class="table table-striped table-bordered">
	<thead>
     <tr>
         <!-- <th>Name</th> -->
         <th>Total Amount</th>
         <th>Date</th>
         <th>Reason</th>
         <th>Photo</th>
         <th colspan=2>Action</th>
     </tr>
 	</thead>
 	<tbody>
          <c:forEach items="${billItems}" var="item">
                <tr>
                    <%-- <td><c:out value="${item.user.name}" /></td> --%>
                    <td><c:out value="${item.totalAmount}" /></td>
                    <td><c:out value="${item.date}" /></td>
                    <td><c:out value="${item.reason}" /></td>
                    <td>
                    	<c:if test="${item.photo != null}">
                    		<a target="_blank" href="UploadServlet?type=bill&getfile=<c:out value="${item.photo}"/> ">
                    			<img src="UploadServlet?type=bill&getthumb=<c:out value="${item.photo}"/> ">
                    		</a>
                    	</c:if>
                    </td>
                    <td><a href="BillServlet?action=edit&id=<c:out value="${item.id}"/>">Edit</a></td>
                    <%-- <td><a href="BillServlet?action=viewShare&id=<c:out value="${item.id}"/>">View Share</a></td> --%>
                </tr>
            </c:forEach>
    </tbody>
</table>
</div>
</div>
</div>
<jsp:include page="template/js.jsp" />
</body>
</html>