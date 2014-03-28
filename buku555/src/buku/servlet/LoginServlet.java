package buku.servlet;

import java.io.IOException;

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
		// String country = request.getParameter("country");
		// String accessToken = request.getParameter("accessToken");
		System.out.println("#############FB User Id=" + id);
		System.out.println("#############Email=" + email);
		// String password = request.getParameter("password");
		// ensure that out.close() do not come before response object

		
		User u = userDAO.findByFbId(id);
		if (u == null){
			System.out.println("#############NEw USer");
			u = new User();
			u.setFbUserId(id);
			u.setEmail(email);
			u.setIsRegistered(true);
			userDAO.persist(u);
		}

		System.out.println("#############USer=" + u.getFbUserId());
		
		//preserve login user information
		HttpSession sess = request.getSession(true);
		sess.setAttribute("loginUser", u);
		
		response.sendRedirect("SplitBill.jsp");
		
	}

}
