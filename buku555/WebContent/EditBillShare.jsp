<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.fileupload.css">
<title>Bill Details</title>	
</head>
<body>
<script type="text/javascript">
$(document).ready(function() {
	$('input[name=date]').datepicker({
        //dateFormat: "dd-mm-yy",
        maxDate: "0",
        showOtherMonths: true,
        selectOtherMonths: true
     }
	);
	
	//upload files function
    $('#fileupload').fileupload({
        url: 'UploadServlet?type=bill&id=' + $('#id').val(),
        dataType: 'json',
        maxFileSize : 5000000,
        //formData: {id: 'id'},
        done: function (e, data) {
        	//console.log(data.result);
            $.each(data.result, function (index, file) {
            	var img = $('<img />', {
            	    src: file.thumbnail_url
            	});
            	
            	$('#files').html(img);
            });
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
    //end upload file
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
				<jsp:include page="menu.html" flush="true" />
			</div><!--/.nav-collapse -->
      </div>
    </div>
    <div class="container">
<div class="landing">
<h1>buku 555 - lending made social</h1>
<div class="recent-history-table">
<div class="panel panel-default">
	 <div class="panel-heading">
	    <h3 class="panel-title">Bill Form</h3>
	  </div>
    <form method="POST" action='BillServlet' name="frmBillItem" class="form-horizontal" role="form" >
        <input type="hidden" readonly="readonly" name="id" id="id"
            value="<c:out value="${bill.id}" />" /> <br /> 
        <div class="form-group">
        	<label for="totalAmount" class="col-sm-5 control-label">Total Amount</label>
        	<div class="col-sm-4">
        	<input type="text" class="form-control" disabled="disabled" value="<c:out value="${bill.totalAmount}" />" />
        	</div>
        </div>
        <input type="hidden" readonly="readonly" id="totalAmount" name="totalAmount"
            value="<c:out value="${bill.totalAmount}" />" /> <br /> 
        <div class="form-group">
        	<label for="date" class="col-sm-5 control-label">Date</label>
        	<div class="col-sm-4">
        	<input type="text" class="form-control" id="date" name="date" value="<fmt:formatDate pattern="MM/dd/yyyy" value="${bill.date}" />"/>
        	</div>
        </div>
        
        <div class="form-group">
        	<label for="reason" class="col-sm-5 control-label">Reason</label>
        	<div class="col-sm-4">
        	<input type="text" id="reason" name="reason" class="form-control" value="${bill.reason}"/>
        	</div>
        </div>
      <div class="form-group">
      <span class="btn btn-success fileinput-button col-sm-offset-2">
	        <span>Attach receipts, photos...</span>
	        <!-- The file input field used as target for the file upload widget -->
	        <input id="fileupload" type="file" name="files[]" multiple>
	    		</span>
		    <br><br>
		    <!-- The container for the uploaded files -->
		    <div id="files" class="files"></div>
     </div>
        <div class="form-group">
	    <div class="col-sm-offset-3 col-sm-6">
	    	<input type="submit" value="Submit" class="btn btn-success"/>
	    </div>
	  </div>
        
    </form>
 </div>





<%-- <p>Bill Details</p>
<table class="table table-bordered">
<tr>
	<td>Total Amount</td>
	<td><input id="" value="${bill.totalAmount}"></td>
</tr>
<tr>
	<td>Date</td>
	<td><input id="" value="${bill.date}"></td>
</tr>
<tr>
	<td>Reason</td>
	<td><input id="" value="${bill.reason}"></td>
</tr>
</table> --%>
</div>
<div class="recent-history-table">
<div class="panel panel-default">
	 <div class="panel-heading">
	    <h3 class="panel-title">Share Details</h3>
	  </div>
<table class="table table-bordered">
	
   <c:forEach items="${billSharedItems}" var="item">
         <tr>
         <td>
         	<c:choose>
			   <c:when test="${item.user.id == sessionScope.loginUser.id}">
				  	<c:out value="Me (${item.user.name})" />
			   </c:when>
			   <c:otherwise><c:out value="${item.user.name}" /></c:otherwise>
			</c:choose>
         	
         </td>
         <td><c:out value="${item.amountToPay}" /></td>
         </tr>
   </c:forEach>
</table>
</div>
</div>
</div>
</div>
<script src="scripts/bootstrap.min.js"></script>
 <script src="scripts/jsUpload/vendor/jquery.ui.widget.js"></script>
<script src="scripts/jsUpload/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="scripts/jsUpload/jquery.fileupload.js"></script>
</body>
</html>