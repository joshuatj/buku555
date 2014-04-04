<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title></title>
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


//function
function GetFriendDetailsByID(id) {				
	FB.api('/'+id, function(response) {    	
		alert(response.name); 
		//alert(response.friends);
	});		    																
}	
</script>
<p>I owe Friends</p>
<table border="1">
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

<p>Friends owe me</p>
<table border="1">
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

</body>
</html>