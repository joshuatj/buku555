package servlet;

import java.beans.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class accountsettingservlet
 */
@WebServlet("/accountsettingservlet")
public class accountsettingservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public accountsettingservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession sess = request.getSession(true);
		String id = (String)sess.getAttribute("id");
		//String username = request.getParameter("name"); 
        String email = request.getParameter("email"); 
        String notistatus= request.getParameter("chk1");        
        Boolean chkstatus;     
        String opstatus="";
        
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buku555","root","toor");
			
			if(notistatus != null)
			{
				chkstatus=true;
			}
			else{
				chkstatus=false;
			}
			 				
				PreparedStatement ps = con.prepareStatement("update user set email=?, Receive_Notimail=? where id=?"); 
				//ps.setString(1,username); 
                ps.setString(1,email); 
                ps.setBoolean(2,chkstatus);
                ps.setString(3,id);
                
                int i = ps.executeUpdate(); 
                
                if(i!=0)    {
                    opstatus="Your data has been successfuly updated"; 
                } 
                else    { 
                	opstatus="Your data could not be successfuly updated"; 
                }
                
                ps.close();
                con.close();
                request.setAttribute("OperationStatus",opstatus);
                request.getRequestDispatcher("AccountSetting.jsp").forward(request,response); 
                					
		}catch(Exception e){}
		finally {}	
		 
         }
         
	    	 	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession sess = request.getSession(true);
		String id = (String)sess.getAttribute("id");
		 String newpsw = request.getParameter("txtnewpsw");
	     String oldpsw = request.getParameter("txtoldpsw");	     
	     String opstatus="";
	     try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buku555","root","toor");
				String selectStatement = "select * " + "from user where password=? and id=?";
				PreparedStatement prepStmt = con.prepareStatement(selectStatement);
	            prepStmt.setString(1, oldpsw);
	            prepStmt.setString(2,id);
	            
	            ResultSet rs = prepStmt.executeQuery();
	            
	            if (rs.next()) {
	            	
	            	PreparedStatement ps = con.prepareStatement("update user set password=? where id=?"); 
					ps.setString(1,newpsw); 	              
	                ps.setString(2,id);
	                int i=ps.executeUpdate(); 
	                if(i!=0)
	                {
	                	opstatus="Reset password successfully";
	                }
	                else{
	                	opstatus="Reset password unsuccessfully";
	                }
	                
	                ps.close();
	            }else{
	            	opstatus="Sorry the password you entered is not correct.";	            	
	            }
	            
	            con.close();
	            request.setAttribute("OperationStatus",opstatus);
                request.getRequestDispatcher("AccountSetting.jsp").forward(request,response); 
	     }catch(Exception e){}
			finally {}	
			 
	         
	}

}
