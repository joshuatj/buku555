<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<!-- <script type="text/javascript" src="scripts/jquery-1.11.0.js"></script>
<script src="scripts/jquery-ui.js" type="text/javascript"></script> -->
<link
 rel="stylesheet"
 href="http://code.jquery.com/ui/1.9.0/themes/smoothness/jquery-ui.css" />
 <script src="//code.jquery.com/jquery-1.9.1.js"></script>
  <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  <script src="scripts/tdfriendselector.js"></script>
  <script src="scripts/cookie.js"></script>
<!--  <script src="http://connect.facebook.net/en_US/all.js"></script> -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demos.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tdfriendselector.css">
<title>Split Bill</title>
</head>
<body>
<div id="fb-root"></div>
<script type="text/javascript">
console.log(readCookie("loginUserId"));
window.fbAsyncInit = function () {
	FB.init({appId: '1473514739530656', status: true, cookie: false, xfbml: false, oauth: true});
	
	FB.Event.subscribe('auth.authResponseChange', function(response) {
		if (response.status == 'connected') {
			//alert("connected");
		} else if (response.status == 'not_authorized') {
			
		} else {
			//window.navigate("fbLogin.jsp");				
			location.href = "fbLogin.jsp";
		}
	});
	
	$(document ).ready(function() {
		//console.log(getFriends());
		//console.log(friend1s);
		//friend1s = getFriends();
		
		var selector1, selector2, logActivity, callbackFriendSelected, callbackFriendUnselected, callbackMaxSelection, callbackSubmit;

			// When a friend is selected, log their name and ID
			callbackFriendSelected = function(friendId) {
				var friend, name;
				friend = TDFriendSelector.getFriendById(friendId);
				//console.log(friend);
				name = friend.name;
				console.log('Selected ' + name + ' (ID: ' + friendId + ')');
				addNewRow(friendId, name);
			};

			// When a friend is deselected, log their name and ID
			callbackFriendUnselected = function(friendId) {
				var friend, name;
				friend = TDFriendSelector.getFriendById(friendId);
				name = friend.name;
				console.log('Unselected ' + name + ' (ID: ' + friendId + ')');
			};

			// When the maximum selection is reached, log a message
			callbackMaxSelection = function() {
				//logActivity('Selected the maximum number of friends');
			};

			// When the user clicks OK, log a message
			callbackSubmit = function(selectedFriendIds) {
				//logActivity('Clicked OK with the following friends selected: ' + selectedFriendIds.join(", "));
			};

			// Initialise the Friend Selector with options that will apply to all instances
			TDFriendSelector.init({debug: true});

			// Create some Friend Selector instances
			selector1 = TDFriendSelector.newInstance({
				callbackFriendSelected   : callbackFriendSelected,
				callbackFriendUnselected : callbackFriendUnselected,
				callbackMaxSelection     : callbackMaxSelection,
				callbackSubmit           : callbackSubmit,
				maxSelection             : 100,
			});
			selector2 = TDFriendSelector.newInstance({
				callbackFriendSelected   : callbackFriendSelected,
				callbackFriendUnselected : callbackFriendUnselected,
				callbackMaxSelection     : callbackMaxSelection,
				callbackSubmit           : callbackSubmit,
				maxSelection             : 1,
				friendsPerPage           : 5,
				autoDeselection          : true
			});
			
			$("#btnSelect1").click(function (e) {
				e.preventDefault();
				selector1.showFriendSelector();
			});

			$("#btnSelect2").click(function (e) {
				e.preventDefault();
				selector2.showFriendSelector();
			});
		
		//end of friend selector	
			
		
		var totalAmount = 0;
	    $( "#splitButton" ).click(function( event ) {
	        $('#splitBill').show();
	        totalAmount = $( "#totalAmount" ).val();
	        $('[name=amount1]').val(totalAmount);
	    });
	    
	    $("#pinitBtn").click(function( event ) {
	    	
	    	var fbIds = new Array();
	    	var amounts = new Array();
	    	//push login user id
	    	fbIds.push(readCookie("loginUserId"));
	    	for(var i=2; i<= counter; i++){
	    		//console.log($('[name=id'+ i +']').val());
	    		fbIds.push($('[name=id'+ i +']').val());
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
	    			fbIds: fbIds, 
	    			amounts : amounts 
	    			},
	    		success : function (data) {
	    			alert(data);
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
	    
	    var counter = $('#myTable tr').length - 1;
	    //counter = $('#myTable tr').length - 2;
	    
	    function addNewRow(id, name){
	        var newRow = $("<tr>");
	        var cols = "";
	        counter++;
	        
	        
	        
	        cols += '<td>' + name + '<input type="hidden" name="id' + counter + '" value="' + id +'" />' +'</td>';
	        //cols += '<td><input type="text" name="name' + counter + '" value="' + name +'" /></td>';
	        cols += '<td><input type="text" name="amount' + counter + '" /></td>';

	        

	        cols += '<td><input type="button" id="ibtnDel"  value="Remove"></td>';
	        newRow.append(cols);
	        
	        $("table.splitee-list").append(newRow);
	        //shareAmount = calculateShareAmount();
	        if (totalAmount % counter == 0)
	        	$('[name^=amount]').val(calculateShareAmount(totalAmount, counter));
	        else
	        	calculateShareAmount(totalAmount, counter);
	            
	            //if (counter == 5) $('#addrow').attr('disabled', true).prop('value', "You've reached the limit");
	    	}

	    $("table.splitee-list").on("change", 'input[name^="amount"]', function (event) {
	    	//alert();
	    	
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
	    
	    

	    $("table.splitee-list").on("click", "#ibtnDel", function (event) {
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
	    	console.log(amount);
	    	console.log(numberShare);
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
	    
	    
	   $( "#friends" ).autocomplete({
	    	minLength: 2,
	        source: friends,
	        select: function( event, ui ) {
	        	 $( "#friends" ).val("");
	        	addNewRow(ui.item.value,ui.item.label);
	            log( ui.item ?
	              "Selected: " + ui.item.label + " with id: " + ui.item.value :
	              "Nothing selected, input was " + this.value );
	             
	              return false;
	          }
	      });
	    
	    
	   function getFriends(){
			FB.getLoginStatus(function(response) {
				//alert("fuck1");
				if (response.status === 'connected') {
				FB.api('/me/friends?fields=id,name', function(response) {
					
						
						if (response.data) {
							//alert("fuck2");
							//setFriends(response.data);
							
							var friends = response.data;
							//console.log(friends);
							// Build the markup
							//buildMarkup();
							var i, len, html = '';
							for (i = 0, len = friends.length; i < 5; i += 1) {
								html += friends[i].name + "\n";
							}
							//alert(html);
							// Call the callback
							//if (typeof callback === 'function') { callback(); }
							return html;
						} else {
							//log('TDFriendSelector - buildFriendSelector - No friends returned');
							return false;
						}
					
			
				}); }
			});
			
		}
	    
	    
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

<div id='splitBillrow' class="pin-tab-upper rounded-corners">
	I paid <input id='totalAmount'> For <input id='reason'> <button id='splitButton' class="pin-it box-shadow-3">Split it</button></div>
	<div id='splitBill' style='display:none;'>
	
	<!-- <div class="ui-widget">
	  <label for="friends">Friends: </label>
	  <input id="friends">
	</div> -->
		
		
		<div class="jumbotron">
		<a href="#" id="btnSelect1" class="btn btn-primary btn-large">Select
			your friends</a>
		<hr>
		<!-- <div id="results" class="lead">
			<p>You will see result here</p>
		</div> -->
	</div>
	
		<!-- Markup for These Days Friend Selector -->
	<div id="TDFriendSelector">
		<div class="TDFriendSelector_dialog">
			<a href="#" id="TDFriendSelector_buttonClose">x</a>
			<div class="TDFriendSelector_form">
				<div class="TDFriendSelector_header">
					<p>Select your friends</p>
				</div>
				<div class="TDFriendSelector_content">
					<p>Select your friends to split the bill</p>
					<div
						class="TDFriendSelector_searchContainer TDFriendSelector_clearfix">
						<div class="TDFriendSelector_selectedCountContainer">
							<span class="TDFriendSelector_selectedCount">0</span> friends selected
						</div>
						<input type="text" placeholder="Search friends"
							id="TDFriendSelector_searchField" />
					</div>
					<div class="TDFriendSelector_friendsContainer"></div>
				</div>
				<div class="TDFriendSelector_footer TDFriendSelector_clearfix">
					<a href="#" id="TDFriendSelector_pagePrev"
						class="TDFriendSelector_disabled">Previous</a> <a href="#"
						id="TDFriendSelector_pageNext">Next</a>
					<div class="TDFriendSelector_pageNumberContainer">
						Page <span id="TDFriendSelector_pageNumber">1</span> / <span
							id="TDFriendSelector_pageNumberTotal">1</span>
					</div>
					<a href="#" id="TDFriendSelector_buttonOK">OK</a>
				</div>
			</div>
		</div>
	</div>
		
		<table id="myTable" class="splitee-list">
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
		
	
	
		
		<!-- <div class="ui-widget" style="margin-top:2em; font-family:Arial">
		  Result:
		  <div id="log" style="height: 200px; width: 300px; overflow: auto;" class="ui-widget-content"></div>
		</div> -->
		<!-- <input id='nameAdd'>  -->
		<!-- <button id='addBtn'>Add</button> -->
	</div>
	<br> <button id='pinitBtn'>Pin It!</button>   
</body>
</html>