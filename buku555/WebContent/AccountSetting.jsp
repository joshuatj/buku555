<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@page import="java.sql.*"%>
      <%@ page import="javax.servlet.http.HttpServletRequest"%>
      <%@ page import="javax.servlet.http.HttpSession"%>
      <%@ page import="buku.entities.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="accountsettingservlet"  method="GET">

<div id="header">
<h2>Account Setting</h2>
</div>
<div>
<%=(String)request.getAttribute("OperationStatus")%>
</div>
<div id="profile">
<h4>Profile</h4>
<%
try{
String chk;

//HttpSession sess = request.getSession(true);
//String id = (String)sess.getAttribute("id");
//String id="1";

HttpSession sess = request.getSession();
User logInUser = (User) sess.getAttribute("loginUser");
String id=logInUser.getId().toString();

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buku555","root","toor");
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from user Where id="+id);

while(rs.next()){
	%>
Email <input type="text" name="email" value='<%=rs.getString("email")%>'/><br>
<h4>Notification</h4>  
<input type="hidden" name="id" value='<%=id%>'>  
<input type="checkbox" name="chk1" <%=rs.getBoolean("Receive_Notimail") ? "checked" : "" %>> Receive Email Notification <br>

</div>


<div>
<input type="submit" name="update" Value="Update"/>
</div>
</form>
<form action="accountsettingservlet" method="POST">
<div>
<h4>Reset Password</h4>
<input type="hidden" name="id" value='<%=id%>'>  
Enter Old Password<input type="Password" name="txtoldpsw"/><br>
Enter New Password<input type="Password" name="txtnewpsw"/><br>
</div>
<div>
<input type="submit" name="reset" Value="Reset" />
</div>
<%
}
rs.close();
st.close();
con.close();
}
catch(Exception e){
	System.out.print(e);
}
finally {}
%>
</form>
</body>
</html>