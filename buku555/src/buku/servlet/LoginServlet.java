package buku.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import buku.dao.UserDAO;
import buku.entities.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		userDAO = new UserDAO();
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		System.out.println("#############FB User Id=" + id);
		//System.out.println("#############Email=" + email);

		
		User u = userDAO.findByFbId(id);
		if (u == null){
			System.out.println("#############New User");
			u = new User();
			u.setFbUserId(id);
			u.setEmail(email);
			u.setName(name);
			u.setIsRegistered(true);
			userDAO.persist(u);
		}
		
		//preserve login user information
		HttpSession sess = request.getSession(true);
		sess.setAttribute("loginUser", u);
		PrintWriter out =  response.getWriter();
		out.println("success");
		
		//response.sendRedirect("SplitBill.jsp");
		
	}

}
