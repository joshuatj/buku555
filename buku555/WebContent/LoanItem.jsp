<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="itemTypeDAO" scope="session" class="buku.dao.ItemTypeDAO"/>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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

<link type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript" src="scripts/global.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.fileupload.css">
<title>Add new loan item</title>
</head>
<body>
<div id="fb-root"></div>
    <script>
    
    window.fbAsyncInit = function() {

		FB.init({
			appId      	: '1473514739530656', // App ID
			status     	: true, // check login status
			cookie     	: true, // enable cookies to allow the server to access the session
			oauth		: true,
			xfbml		: true
		});	

		FB.getLoginStatus(function (response) {
			
			if (response.authResponse) {	// if the user is authorized...
				var accessToken = response.authResponse.accessToken
				var tokenUrl = "https://graph.facebook.com/me/friends?access_token=" + accessToken + "&callback=?"

				// Place <input id="name" /> and <input id="fbuid" /> into HTML

				$("#name").autocomplete({
					source: function(request, add) {
						$this = $(this)
						// Call out to the Graph API for the friends list
						$.ajax({
							url: tokenUrl,
							dataType: "jsonp",
							success: function(results){
								// Filter the results and return a label/value object array  
								var formatted = [];
								for(var i = 0; i< results.data.length; i++) {
									if (results.data[i].name.toLowerCase().indexOf($('#name').val().toLowerCase()) >= 0)
									formatted.push({
										label: results.data[i].name,
										value: results.data[i].id
									})
								}
								add(formatted);
							}
						});
					},
					select: function(event, ui) {
						console.log(ui.item.label + "-" + ui.item.value);
						// Fill in the input fields
						$('#name').val(ui.item.label);
						$('#loanUserId').val(ui.item.value);
						// Prevent the value from being inserted in "#name"
						return false;
					},
					minLength: 2
				});
			}
		});
		
      
      $(document).ready(function() {
	    	$(function() {
	    		$(function() {
	                $('input[name=date]').datepicker({
	                        //dateFormat: "dd-mm-yy",
	                        maxDate: "0",
	                        showOtherMonths: true,
	                        selectOtherMonths: true
	                        		}
	                );
	            });
	        });
	        if ("${loanItem.itemType.id}" != "")
	        	$("#itemType").val("${loanItem.itemType.id}");
	        
	        if ("${loanItem.loanStatus}" != ""){
	        	$("#loanStatus").val("${loanItem.loanStatus}");
	        }
	        	
	        
	        
	        
	        var action = getURLParam("action");
	        var loanType = getURLParam("loanType");
	        if (action == "insert"){
	        	$( '#loanStatus' ).prop( "disabled", true );
	        } else if (action == "edit"){
	        	if (loanType == "1"){
	        		$('#name').val("${loanItem.userByLoanUserId.name}");
	    	        $('#loanUserId').val("${loanItem.userByLoanUserId.fbUserId}");
	        		$('input:radio[name=loanType]')[0].checked = true;
	      		}else if (loanType = "2"){
	      			$('#name').val("${loanItem.userByOwnerUserId.name}");
	    	        $('#loanUserId').val("${loanItem.userByOwnerUserId.fbUserId}");
	      			$('input:radio[name=loanType]')[1].checked = true;
	      		}
	        }
	        
	        //upload files function
		    $('#fileupload').fileupload({
		        url: 'UploadServlet?type=item&id=' + $('#id').val(),
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
    };

    
    
    function createFriendElement(friend) {
      var $img = $('<img>').attr('src', friend.picture),
          $name = $('<h3>').text(friend.name),
          $friend = $('<div>').addClass('friend').append($img, $name);
      return $friend;
    }

    // Load the SDK asynchronously
    (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
    }(document));
    
        
    </script>

<!-- Start navigation -->
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
 <p class="lead">Record a loan item</p>
<div class="recent-history-table" >
<div class="panel panel-default">
	 <div class="panel-heading">
	    <h3 class="panel-title">Loan Form</h3>
	  </div>
    <form method="POST" action='LoanItemServlet' name="frmAddLoanItem" class="form-horizontal" role="form" >
        <input type="hidden" readonly="readonly" name="id" id="id"
            value="<c:out value="${loanItem.id}" />" /> <br /> 
        <div class="form-group">
        	<label for="description" class="col-sm-5 control-label">Description</label>
        	<div class="col-sm-4">
        	<input type="text" class="form-control" id="description" name="description" value="<c:out value="${loanItem.description}" />" />
        	</div>
        </div>
        <div class="form-group">
        	<label for="date" class="col-sm-5 control-label">Date</label>
        	<div class="col-sm-4">
        	<input type="text" class="form-control" id="date" name="date" value="<fmt:formatDate pattern="MM/dd/yyyy" value="${loanItem.date}" />" />
        	</div>
        </div>
        <div class="form-group">
	        <div class="col-sm-offset-2 col-sm-9">
		       	<label class="radio-inline">
				    <input type="radio" id="rdLend" name="loanType" value="1" checked> Lend
			  	</label>
			  <label class="radio-inline">
			    <input type="radio" id="rdLoan" name="loanType" value="2"> Borrow
			  </label>
		  	</div>
        </div>
        <div class="form-group">
        	<label for="name" class="col-sm-5 control-label">Select Friend</label>
        	<div class="col-sm-4">
        	<input type="text" id="name" name="name" class="form-control"/>
        	</div>
        </div>
      <input type="hidden" id="loanUserId" name="loanUserId">
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
        	<label for="itemType" class="col-sm-5 control-label">Item Type</label>
        	<div class="col-sm-4">
        	<select class="form-control" name="itemType" size="1" id="itemType">  
			      <c:forEach items="${itemTypeDAO.findAll()}" var="item">  
			            <option value="${item.id}"><c:out value="${item.itemTypeName}"/></option>  
			      </c:forEach>  
			</select> 
        	</div>
        </div>
        <div class="form-group">
        	<label for="loanStatus" class="col-sm-5 control-label">Loan Status</label>
        	<div class="col-sm-4">
        	<Select class="form-control" name="loanStatus" size="1" id="loanStatus" style="width:150px"> 
      						<option value="LOAN">LOAN</option>
      						<option value="RETURNED">RETURNED</option>  
      						<option value="DAMAGED">DAMAGED</option>  
      						<option value="LOST">LOST</option>    
      				 </select>
        	</div>
        </div>
        <div class="form-group">
	    <div class="col-sm-offset-3 col-sm-6">
	    	<input type="submit" value="Submit" class="btn btn-success"/>
	    </div>
	  </div>
        
    </form>
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