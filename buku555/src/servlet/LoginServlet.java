package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.userDBAO;

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
		// System.out.println("cewoewjsjsjsjsj");
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		// String country = request.getParameter("country");
		// String accessToken = request.getParameter("accessToken");
		// System.out.println(id);
		// String password = request.getParameter("password");
		boolean result = false;
		// ensure that out.close() do not come before response object

		try {
			userDBAO account = new userDBAO();
			// result = account.checkUser(id);
			account.checkUser(id, email, "user");
			result = true;
		} catch (Exception e) {
			e.printStackTrace();

		}

		if (result) {
			// request.getRequestDispatcher("/bookstore").forward(request,response);
			// response.sendRedirect("fbLogin.jsp");
			HttpSession sess = request.getSession(true);
			sess.setAttribute("id", id);
			// RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			// rd.forward(request, response);
			response.sendRedirect("home.jsp");
			return;
		} else {
			// response.sendRedirect("fbLogin.jsp");
			return;
		}
	}

}
