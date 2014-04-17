package buku.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import buku.dao.UserDAO;
import buku.entities.User;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO userDAO = new UserDAO();
		User logInUser = (User) request.getSession().getAttribute("loginUser");
		String email = request.getParameter("email");
		String emailNoti = request.getParameter("emailNoti");
		logInUser.setEmail(email);
		logInUser.setReceiveNotiMail(emailNoti != null);
		userDAO.update(logInUser);
		request.getSession().setAttribute("loginUser", logInUser);
		
		response.sendRedirect("AccountSettings1.jsp");
//		RequestDispatcher view = request.getRequestDispatcher("/AccountSettings1.jsp");
//        view.forward(request, response);

	}

}
