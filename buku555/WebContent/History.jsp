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
<title>History</title>
</head>
<body>
<!-- Start navigation -->
<jsp:include page="template/menu.jsp" flush="true" />
<!-- end navigation  -->

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
<jsp:include page="template/js.jsp" />
</body>
</html>