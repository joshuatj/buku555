<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!-- <link
 rel="stylesheet"
 href="http://code.jquery.com/ui/1.9.0/themes/smoothness/jquery-ui.css" /> -->
<link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.0.js" type="text/javascript"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script>
 <script src="scripts/cookie.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap/custom.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.fileupload.css">
<title>Split Bill</title>
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
	

	
	$(document ).ready(function() {
		
		//fb autocomplte friends
		FB.getLoginStatus(function (response) {
			
			if (response.authResponse) {	// if the user is authorized...
				var accessToken = response.authResponse.accessToken
				var tokenUrl = "https://graph.facebook.com/me/friends?access_token=" + accessToken + "&callback=?"

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
						addNewRow(ui.item.value, ui.item.label);
						$('#name').val("");
						return false;
					},
					minLength: 2
				});
			}
		});
		//end of fb autocomplte friends
			
		
		var totalAmount = 0;
	    $( "#splitButton" ).click(function( event ) {
	        $('#splitBill').show();
	        totalAmount = $( "#totalAmount" ).val();
	        $('[name=amount1]').val(totalAmount);
	    });
	    
	    $("#test").click(function( event ) {
	    	resetAll();
	    });
	    
	    $("#pinitBtn").click(function( event ) {
	    	
	    	var fbIds = new Array();
	    	var amounts = new Array();
	    	var names = new Array();
	    	//push login user id
	    	fbIds.push(readCookie("loginUserId"));
	    	names.push("me");
	    	for(var i=2; i<= counter; i++){
	    		//console.log($('[name=id'+ i +']').val());
	    		fbIds.push($('[name=id'+ i +']').val());
	    		names.push($('[name=name'+ i +']').val());
	    	}
	    	for(var i=1; i<= counter; i++){
	    		//console.log($('[name=amount'+ i +']').val());
	    		amounts.push($('[name=amount'+ i +']').val());
	    	}

	    	
	    	$.ajax({ 
	    		type: "POST",
	    		url: "SplitBillServlet",
	    		data: {
	    			totalAmount : totalAmount,
	    			reason : $("#reason").val(),
	    			date: $("#date").val(),
	    			fbIds: fbIds,
	    			names: names,
	    			amounts : amounts
	    			},
	    		success : function (data) {
	    			console.log(data);
	    			//alert(data === 'success');
	    			resetAll();
	    			
	    		}
	    		});
	    });
	    
	    $( "#addBtn" ).click(function( event ) {
	    	countAdd ++;
	    	//alert("xxxx");
	    	$("#splitees").append("<li>" + $("#nameAdd").val() + "</li>");
	    	$("#nameAdd").val('');
	    });
	    
	    function log( message ) {
	        $( "<div>" ).text( message ).prependTo( "#log" );
	        $( "#log" ).scrollTop( 0 );
	      }
	    
	    function resetAll(){
	    	$("#reason").val('');
			$("#totalAmount" ).val('');
			$("#date" ).val('');
			$('#files').html('');
			$('#splitBill').hide();
			$("#myTable tr:gt(1)").remove();
			counter = $('#myTable tr').length - 1;
	    }
	    
	    var counter = $('#myTable tr').length - 1;
	    //counter = $('#myTable tr').length - 2;
	    
	    function addNewRow(id, name){
	        var newRow = $("<tr>");
	        var cols = "";
	        counter++;
	        
	        
	        
	        cols += '<td>' + name + 
	        '<input type="hidden" name="id' + counter + '" value="' + id +'" />' +
	        '<input type="hidden" name="name' + counter + '" value="' + name +'" />' + 
	        '</td>';
	        //cols += '<td><input type="text" name="name' + counter + '" value="' + name +'" /></td>';
	        cols += '<td><input type="text" name="amount' + counter + '" /></td>';

	        

	        cols += '<td><input type="button" id="ibtnDel"  value="Remove"></td>';
	        newRow.append(cols);
	        
	        $("#myTable").append(newRow);
	        //shareAmount = calculateShareAmount();
	        if (totalAmount % counter == 0)
	        	$('[name^=amount]').val(calculateShareAmount(totalAmount, counter));
	        else
	        	calculateShareAmount(totalAmount, counter);
	            
	            //if (counter == 5) $('#addrow').attr('disabled', true).prop('value', "You've reached the limit");
	    	}

	    $("#myTable").on("change", 'input[name^="amount"]', function (event) {
	    	
	    	var currentAmount = $(event.target).val();
	    	var amountLeft = totalAmount - currentAmount;
	    	
	    	if (totalAmount %  (counter - 1) == 0)
	    		$('[name^=amount]').val(calculateShareAmount(amountLeft, counter - 1));
	    	else
	    		calculateShareAmount(amountLeft, counter - 1);
	    	$(event.target).val(currentAmount);
	    	
	        //calculateRow($(this).closest("tr"));
	        //calculateGrandTotal();
	    });
	    
	    

	    $("#myTable").on("click", "#ibtnDel", function (event) {
	        $(this).closest("tr").remove();
	        //calculateGrandTotal();
	        counter --;
	        if (totalAmount % counter == 0)
	        	$('[name^=amount]').val(calculateShareAmount(totalAmount, counter));
	        else
	        	calculateShareAmount(totalAmount, counter);
	       
	    });
	    
	    /* function calculateRow(row) {
	        var price = +row.find('input[name^="price"]').val();

	    } */

	    function calculateShareAmount(amount, numberShare){
	    	//console.log(amount);
	    	//console.log(numberShare);
	    	if (amount % numberShare == 0){
	    		return amount / numberShare;
	    	} else {
	    		var tmp =  amount / numberShare;
	    		tmp = tmp.toFixed(2);
	    		firstAmount = totalAmount - tmp * (numberShare -1);
	    		$('[name^=amount]').val(tmp);
	    		$('[name=amount1]').val(firstAmount);
	    		//return amount / numberShare;
	    	}
	    }
	    
	    /* function calculateGrandTotal() {
	        var grandTotal = 0;
	        $("table.splitee-list").find('input[name^="amount"]').each(function () {
	            grandTotal += +$(this).val();
	        });
	        $("#grandtotal").text(grandTotal.toFixed(2));
	    } */
	    
	    
	    //upload files function
	    $('#fileupload').fileupload({
	        url: 'UploadServlet?type=bill',
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
        });
	}); //end docmument ready
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
            <li><a href="home.jsp">Home</a></li>
			<li class="active"><a href="SplitBill.jsp">Split Bill</a></li>
			<li><a href="LoanMoneyServlet?action=list">Record Payment</a></li>
			<li><a href="LoanItemServlet?action=list">Record Item</a></li>
            <li><a href="HistoryServlet">History</a></li>
            
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
    
    
    <div class="container">

      <div class="landing">
        <h1>buku 555 - lending made social</h1>
        <p class="lead">Split a bill with friends</p>

	<div class="action-form">

	<div id='splitBillrow' class="pin-tab-upper rounded-corners">
	<span class="font-14">I paid </span>
	<input id='totalAmount'> 
	<span class="font-14">For</span> 
	<input class="w230" id='reason'> 
	<button id='splitButton' class="btn split-bill">Split it</button>
	</div>
	
	<div id='splitBill' style='display:none;'>
	
	<!-- <div class="ui-widget">
	  <label for="friends">Friends: </label>
	  <input id="friends">
	</div> -->
		
		<div class="pin-tab-lower">
		<div class="mb-20">
		<input type="text" id="name" style="width: 200px;" placeholder="Friend's name"/>
		</div>
		
		<table id="myTable" class="table table-no-border">
		    <thead>
		        <tr>
		            <td>Name</td>
		            <td>Amount</td>
		        </tr>
		    </thead>
		    <tbody>
		        <tr>
		            <td>
		                Me
		            </td>
		            <td>
		                <input type="text" name="amount1" />
		            </td>
		            <td><a class="deleteRow"></a>
		            </td>
		        </tr>
		    </tbody>
		</table>
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
				<td><button id='pinitBtn' >Pin It!</button></td>
			</tr>
		</tbody>
		</table>
	
	</div> <!-- pin-tab-lower -->
	
	</div> <!-- splitBill -->

	</div>
      

	  </div> <!-- landing  -->

    </div><!-- /.container -->
	 <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="scripts/bootstrap.min.js"></script>
    <script src="scripts/jsUpload/vendor/jquery.ui.widget.js"></script>
    <script src="scripts/jsUpload/jquery.iframe-transport.js"></script>
	<!-- The basic File Upload plugin -->
	<script src="scripts/jsUpload/jquery.fileupload.js"></script>
	   
</body>
</html>