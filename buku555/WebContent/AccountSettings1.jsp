<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<!--  Common CSS -->
<jsp:include page="template/css.jsp" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<title>Account Settings</title>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#chkEmailNoti").prop("checked", '${sessionScope.loginUser.receiveNotiMail}' == 'true');
	});
	
</script>
<!-- Start navigation -->
<jsp:include page="template/menu.jsp" flush="true" />
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
 <jsp:include page="template/js.jsp" />
</body>
</html>