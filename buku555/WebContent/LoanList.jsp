<%@page import="buku.dao.LoanItemDAO, buku.entities.LoanItem, java.util.List, java.util.Iterator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript"></script>
<table border="1" cellpadding="0" cellspacing="0">
	<thead>
     <tr>
         <th>Description</th>
         <th>Date</th>
         <th>Loan User</th>
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
                    <td><c:out value="${item.userByLoanUserId.fbUserId}" /></td>
                    <td><c:out value="${item.itemType.itemTypeName}" /></td>
                    <td><c:out value="${item.loanStatus}" /></td>
                    <td><a href="LoanItemServlet?action=edit&id=<c:out value="${item.id}"/>">Update</a></td>
                    <td><a href="LoanItemServlet?action=delete&id=<c:out value="${item.id}"/>">Delete</a></td>
                    <%-- <td><a href="TestServlet?action=split&billId=<c:out value="${item.id}"/>">Split</a></td> --%>
                </tr>
            </c:forEach>
    </tbody>
</table>
<p><a href="LoanItemServlet?action=insert">Add Loan Item</a></p>
<p><a href="/HibernateTest/SplitBill.jsp">Add new Bill</a></p>
</body>
</html>