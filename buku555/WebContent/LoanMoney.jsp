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
<title>Show Money Record</title>
<!--  Common CSS -->
<jsp:include page="template/css.jsp" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
</head>
<body>
<div id="fb-root"></div>
<script type="text/javascript">
window.fbAsyncInit = function () {
	FB.init({appId: '1473514739530656', status: true, cookie: false, xfbml: false, oauth: true});
	
	FB.Event.subscribe('auth.authResponseChange', function(response) {
		if (response.status == 'connected') {
			//alert("connected");
		} else if (response.status == 'not_authorized') {
			
		} else {
			//window.navigate("fbLogin.jsp");				
			location.href = "Login.jsp";
		}
	});
};


(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id))
		return;
	js = d.createElement(s);
	js.id = id;
	js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=1473514739530656";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
	
</script>
<!-- Start navigation -->
<jsp:include page="template/menu.jsp" flush="true" />
<!-- end navigation  -->
 
 <div class="container">
 <div class="landing">
 <h1>buku 555 - lending made social</h1>
 <div class="recent-history-table">
<p>I owe Friends</p>
<table class="table table-striped table-bordered">
 	<thead>
     <tr>
         <th>Friends</th>
         <th>Amount</th>
         <th colspan=2>Action</th>
     </tr>
 	</thead>
 	<tbody>
		<c:forEach items="${oweMoney}" var="item">
            <tr>
                <td><c:out value="${item.userByOwnerUserId.name}" /></td>
                <td><c:out value="${item.totalLoanAmount}" /></td>
                <td><a href="LoanMoneyServlet?action=settle&id=<c:out value="${item.id}"/>&select=1">Settle</a></td>
               <%--  <td><a href="BillServlet?action=viewShare&id=<c:out value="${item.id}"/>">View Share</a></td> --%>
            </tr>
        </c:forEach>
 	</tbody>
</table>
</div>
<div class="recent-history-table">
<p>Friends owe me</p>
<table class="table table-striped table-bordered">
 	<thead>
     <tr>
         <th>Friends</th>
         <th>Amount</th>
         <th colspan=2>Action</th>
     </tr>
 	</thead>
 	<tbody>
		<c:forEach items="${loanMoney}" var="item">
            <tr>
                <td><c:out value="${item.userByLoanUserId.name}" /></td>
                <td><c:out value="${item.totalLoanAmount}" /></td>
                <td><a href="LoanMoneyServlet?action=settle&id=<c:out value="${item.id}&select=2"/>">Settle</a></td>
               <%--  <td><a href="BillServlet?action=viewShare&id=<c:out value="${item.id}"/>">View Share</a></td> --%>
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