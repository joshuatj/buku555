package serlvets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import javax.servlet.http.*;
import java.util.Date;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session  = request.getSession(true);
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");

		if (id != "" && password != "" ){

			if (id.equals(password)){
	
			response.setContentType("text/html");
	
			PrintWriter out = response.getWriter();
	
			out.println ("<html>");
			out.println ("<head>");
			out.println ("<title>Response from LoginServlet</title>");
			out.println ("</head>");
			out.println ("<body>");
			out.println ("<h1>Hello World!</h1>");
			out.println ("</body>");
			out.println ("</html>");
			out.close();
			}
			else { System.out.println("login failure");
	
			}

		}


		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		//HTTPSession
		HttpSession session  = request.getSession(true);

		//HTTPResponse response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		//Referer-Identify the referer
		String referer = request.getHeader("referer");

		// print session info
		Date created = new Date(session.getCreationTime());
		Date accessed = new Date(session.getLastAccessedTime()); 
		out.println("Session ID " + session.getId()); 
		out.println("Created: " + created);
		out.println("Last Accessed: " + accessed);

		String id = request.getParameter("id");
		String password = request.getParameter("password");

		if (id !="" && password!=""){
			try {
				//AccountDBAO db = new AccountDBAO();
				//call DAO to verify login and password with DB in later practical
				boolean status = true ;
			if (status) {
				//store the user id value into session
				session.setAttribute("id", id);
		
				//retrieve user id from session and display 
				out.println("<html>"); 
				out.println("<head>");
				out.println("<title>Response from LoginServlet</title>");
				out.println("</head>");
				out.println("<body>");
				out.println("User id: <h1>" +
				(String)session.getAttribute("id") + "</h1>");
				out.println("</body>");
				out.println("</html>");
				out.close();
			}
			else response.sendRedirect(referer);
			
		}
		catch (Exception e) {

			e.printStackTrace();
		}
		
	}
	}
}
