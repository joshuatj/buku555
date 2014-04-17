<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<!-- Bootstrap core CSS -->
<link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/bootstrap/custom.css" rel="stylesheet">
<link type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript" src="scripts/global.js"></script>
<title>Account Settings</title>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#chkEmailNoti").prop("checked", '${sessionScope.loginUser.receiveNotiMail}' == 'true');
	});
	
</script>
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
			<li class="active"><a href="LoanMoneyServlet?action=list">Record Payment</a></li>
			<li><a href="LoanItemServlet?action=list">Record Item</a></li>
            <li><a href="HistoryServlet">History</a></li>
            
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
 <!-- end navigation  -->
  <div class="container">
 <div class="landing">
 <h1>buku 555 - lending made social</h1>
 <div class="recent-history-table" >
<div class="panel panel-default">
	 <div class="panel-heading">
	    <h3 class="panel-title">Account Settings</h3>
	  </div>
    <form method="POST" action='UserServlet' class="form-horizontal" role="form" >
        <input type="hidden" readonly="readonly" name="id" id="id"
            value="<c:out value="${sessionScope.loginUser.id}" />" /> <br /> 
        <div class="form-group">
        	<label for="email" class="col-sm-5 control-label">Email</label>
        	<div class="col-sm-4">
        	<input type="text" class="form-control" id="email" name="email" value="<c:out value="${sessionScope.loginUser.email}" />" />
        	</div>
        </div>
        
        <div class="form-group">
	        <div class="col-sm-offset-3 col-sm-8">
		       	<label class="checkbox-inline">
				    <input type="checkbox" id="chkEmailNoti" name="emailNoti"> Receive Email Notification
			  	</label>
		  	</div>
        </div>
        <div class="form-group">
	    <div class="col-sm-offset-3 col-sm-6">
	    	<input type="submit" value="Update" class="btn btn-success"/>
	    </div>
	  </div>
        
    </form>
 </div>
 </div>
 </div>
 </div>
 <script src="scripts/bootstrap.min.js"></script>
</body>
</html>