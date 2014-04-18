<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:useBean id="currencyDAO" scope="session" class="database.CurrencyDBAO"/>
<html>
<head>
<c:if test="${sessionScope.loginUser == null}">
    <c:redirect url="/Login.jsp" />		
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!--  Common CSS -->
<jsp:include page="template/css.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.fileupload.css">
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<title>Record Payment</title>
</head>
<body>
<div id="fb-root"></div>
<script type="text/javascript">
window.fbAsyncInit = function() {
	FB.init({
		appId: '1473514739530656', status: true, cookie: true, oauth : true, xfbml: true
	});	

	FB.getLoginStatus(function (response) {
		
		if (response.authResponse) {	// if the user is authorized...
			var accessToken = response.authResponse.accessToken
			var tokenUrl = "https://graph.facebook.com/me/friends?access_token=" + accessToken + "&callback=?";

			// Place <input id="name" /> and <input id="fbuid" /> into HTML
			//console.log(tokenUrl);
			$("#name").autocomplete({
				source: function(request, add) {
					$this = $(this)
					
					// Call out to the Graph API for the friends list
					$.ajax({
						url: tokenUrl,
						dataType: "jsonp",
						success: function(results){
							var maxResults = 10; //results.data.length
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
					$('#fbId').val(ui.item.value);
					
					return false;
				},
				minLength: 2
			});
		}
	});
	
	$(document).ready(function() {
		
        if ('${select}' == '1'){
        	$('#selectWhoPaid').val('1');
        	//$('#fromWho').val('${loanItem.userByLoanUserId.fbUserId}');
        	$('#fbId').val('${loanItem.userByOwnerUserId.fbUserId}');
        	$('#name').val('${loanItem.userByOwnerUserId.name}');
        } else if ('${select}' == '2'){
        	$('#selectWhoPaid').val('2');
        	$('#fbId').val('${loanItem.userByLoanUserId.fbUserId}');
        	//$('#toWho').val('${loanItem.userByOwnerUserId.fbUserId}');
        	$('#name').val('${loanItem.userByLoanUserId.name}');
        } else if ('${select}' == '3'){
        	$('#selectWhoPaid').val('3');
        } else if ('${select}' == '4'){
    		$('#selectWhoPaid').val('4');
    	}
    	
        
    	$( "#submit" ).click(function( event ) {
    		if(!validateNumber($("#amount").val())){
    			alert("Please input a positive number");
    			return;
    		}
    		
    		if($('#name').val() ==''){
    			alert("Please choose a friend");
    			return;
    		}
    		
    		$.ajax({ 
    	   		type: "POST",
    	   		url: "LoanMoneyServlet",
    	   		data: {
    	   			amount : $("#amount").val(),
    	   			currency : $("#type").val(),
    	   			selectWhoPaid : $("#selectWhoPaid").val(),
    	   			reason : $("#reason").val(),
	    			date: $("#date").val(),
    	   			name : $('#name').val(),
    	   			fbId: $('#fbId').val()
    	   			},
    	   		success : function (data) {
    	   			if ($("#notiFriend").is(":checked")){
    	   				SendNotiToFriend($("#reason").val(), $("#amount").val(), $('#fbId').val(), $("#type").val());
    	   			}
    	   				
    	   			resetAll();
    	   		}
    	   		});
        });
    	
    	function resetAll(){
    		$("#amount").val('');
    		$("#date").val('');
    		$("#selectWhoPaid").val('1');
    		$("#reason").val('');
    		$('#name').val('');
    		$('#type').val('SGD');
    		$('#files').html('');
    	}
    	
    	 //send notifications to friends
        function SendNotiToFriend(reason, amount, fbId, currency) {
    		var selectWhoPaid = $('#selectWhoPaid').val();
    		var message = '';
    		if (selectWhoPaid == '1'){
    			message = 'I paid you ';
    		} else if (selectWhoPaid == '2'){
    			message = 'You paid me ';
    		} else if (selectWhoPaid == '3'){
    			message = 'I owe you ';
    		} else if (selectWhoPaid == '4'){
    			message = 'You owe me ';
    		}
    		
    		message = message + amount + ' ' + currency;
       		if (reason != null && reason != '')
       			message = message + ' for ' + reason;
       		if (selectWhoPaid == '2')
       			message = message + ". Thank you!";
       		
   	 		FB.getLoginStatus(function (response) {
   	 			if (response.authResponse) {
   	 				FB.api('me/feed', 'post', { 
   	 					message: message, 
   	 					place: '101883206519751', 
   	 					tags: fbId,
   	 					privacy : {
   	 						value : 'CUSTOM',
   	 						allow : fbId
   	 					},
   	 					description : "Money Notification"},
   	 					function (response) {
   	 					      if (response && !response.error) {
   	 					    	  console.log(response);
   	 					      }
   	 					    
   	 					});
   	 				
   	 			}
   	 		}); 
	
   	  }
    	
    	//upload files function
	    $('#fileupload').fileupload({
	        url: 'UploadServlet?type=transaction',
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
	    
	    $(function() {
            $('input[name=date]').datepicker({
                    //dateFormat: "dd-mm-yy",
                    maxDate: "0",
                    showOtherMonths: true,
                    selectOtherMonths: true
                    		}
            );
            $('input[name=date]').datepicker("setDate", new Date());
        });
	    
	    
	    //listen to currency change
	    /* $( "#type" ).change(function() {
            var amount = $("#amount").val();
            var currency = $("#type").val();
                         
          	$.ajax({
                   type : "GET",
                   url : "/buku555/getDataRate",
                   data : "amount=" + amount  + "&currency=" + currency + "&direction=1",                        
                   success : function(data) {
                	   console.log(data);         
                      $("#hiddenAmount").val(data);
                   }
		     });
		}); */
	    
    	
    });
};

(function(d){
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    ref.parentNode.insertBefore(js, ref);
   }(document));
</script>
<!-- Start navigation -->
<jsp:include page="template/menu.jsp" flush="true" />
<!-- end navigation  -->
 
 <div class="container">
 <div class="landing">
 <h1>buku 555 - lending made social</h1>
 <p class="lead">Record a payment</p>
<div class="record-payment">
<input type="hidden" id="fbId" />
<div id='splitBillrow' class="pin-tab-upper rounded-corners">
	<input type="text" id="name" style="width: 200px;" placeholder="Friend"/>
	<select id="selectWhoPaid"  class="dropdown-toggle">
		<option value="1">I paid</option>
		<option value="2">Paid me</option>
		<option value="3">I owe</option>
		<option value="4">Owes me</option>
	</select>
	<select id="type" name="type" class="dropdown-toggle">
		<c:forEach items="${currencyDAO.getDBKnownCurrencies()}" var="item">
		<c:choose>
			<c:when test="${item == 'SGD'}">
				<option value="${item}" selected='selected'><c:out value="${item}"/></option>  
			</c:when>
			<c:otherwise>
				<option value="${item}"><c:out value="${item}"/></option>  
			</c:otherwise>
		</c:choose>
       </c:forEach>  
		<!-- <option value="MYR">MYR</option>
		<option value="S$" selected="selected">S$</option>
		<option value="USD">USD</option>
		<option value="GBP">GBP</option> -->
	</select>
	<input type="text" id="amount" value="${loanItem.totalLoanAmount}" placeholder="How much?"/>
	<input id="reason" value="Settle Up" placeholder="For what? (e.g. party)">
	<button id="cancel" class="btn split-bill" onclick="document.location='LoanMoneyServlet?action=list'">Cancel</button>
</div>
<div class="pin-tab-lower">
	<table class="table table-no-border">
	<tbody>
		<tr>
			<td>
				On Date 
			</td>
			<td>
				<input id="date" type="text" name="date" />
			</td>
			
		</tr>
		<tr>
			<td><input type="checkbox" id="notiFriend" checked/>&nbsp; Notify friends via Facebook</td>
			<td></td>
		</tr>
		<tr>
			<td>
				<span class="btn btn-success fileinput-button">
			        <span>Attach receipts, photos...</span>
			        <!-- The file input field used as target for the file upload widget -->
			        <input id="fileupload" type="file" name="files[]" multiple>
			    </span>
				    <br><br>
				    <!-- The container for the uploaded files -->
				    <div id="files" class="files"></div>
			
			</td>
			<td><button id="submit" class="btn pin-it">PIN IT!</button></td>			
		</tr>
	
	</tbody>
	</table>
</div>	
	


</div>
</div>
</div>
<jsp:include page="template/js.jsp" />
<script src="scripts/jsUpload/vendor/jquery.ui.widget.js"></script>
<script src="scripts/jsUpload/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="scripts/jsUpload/jquery.fileupload.js"></script>
</body>
</html>