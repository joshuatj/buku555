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
<table border="1" cellpadding="0" cellspacing="0">
	<thead>
     <tr>
         <th>Name</th>
         <th>Total Amount</th>
         <th>Date</th>
         <th>Reason</th>
         <th colspan=2>Action</th>
     </tr>
 	</thead>
 	<tbody>
          <c:forEach items="${billItems}" var="item">
                <tr>
                    <td><c:out value="${item.user.fbUserId}" /></td>
                    <td><c:out value="${item.totalAmount}" /></td>
                    <td><c:out value="${item.date}" /></td>
                    <td><c:out value="${item.reason}" /></td>
                    <td><a href="BillServlet?action=edit&id=<c:out value="${item.id}"/>">Edit</a></td>
                    <td><a href="BillServlet?action=viewShare&id=<c:out value="${item.id}"/>">View Share</a></td>
                </tr>
            </c:forEach>
    </tbody>
</table>
</body>
</html>