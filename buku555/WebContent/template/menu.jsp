<!-- menu -->
<div class="navbar bg-green navbar-inverse navbar-fixed-top"
	role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="SplitBill.jsp">buku555</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav">

				<li class="dropdown"><a href="#" data-toggle="dropdown"
					class="dropdown-toggle">Money<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="SplitBill.jsp">Split Bill</a></li>
						<li><a href="SplitBill.jsp">Record Money Loan</a></li>
						<li><a href="LoanMoneyServlet?action=list">Show Money Record</a></li>
						<li><a href="BillServlet?action=list">Show Bill Record</a></li>
					</ul>
				<li class="dropdown"><a href="#" data-toggle="dropdown"
					class="dropdown-toggle">Item<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="LoanItem.jsp">Record Item</a></li>
						<li><a href="LoanItemServlet?action=list">Show Item
								Record</a></li>
					</ul>
				<li class="dropdown"><a href="#" data-toggle="dropdown"
					class="dropdown-toggle">Convert Currency<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="getRate.jsp">Todays SGD Rate</a></li>
						<li><a href="getHistoricRate.jsp">Historic Rates</a></li>
						<li><a href="getHistoricOtherCurrency.jsp">Multiple
								Historic Currency</a></li>
					</ul>
				<li><a href="HistoryServlet">History</a></li>
				<li><img class="fbimage" src='http://graph.facebook.com/${sessionScope.loginUser.fbUserId}/picture'/></li> 
				<li class="dropdown"><a href="#" data-toggle="dropdown"
					class="dropdown-toggle">${sessionScope.loginUser.name}<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="AccountSettings1.jsp">Settings</a></li>
						<li><a id='btnLogout' onclick="logout('<%=request.getContextPath()%>');">Logout</a></li>					
						
					</ul>
				
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
</div>