package buku.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import buku.dao.ItemTypeDAO;
import buku.dao.LoanItemDAO;
import buku.dao.UserDAO;
import buku.entities.ItemType;
import buku.entities.LoanItem;
import buku.entities.User;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet implementation class LoanItemServlet
 */
@WebServlet("/LoanItemServlet")
public class LoanItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String INSERT_OR_EDIT = "/LoanItem.jsp";
	private static String LIST_LOAN_ITEM = "/LoanList.jsp";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoanItemServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String forward="";
        String action = request.getParameter("action");
        LoanItemDAO dao = new LoanItemDAO();
		User logInUser = (User) request.getSession().getAttribute("loginUser");

        if (action.equalsIgnoreCase("delete")){
            int id = Integer.parseInt(request.getParameter("id"));
            LoanItem item = dao.findById(id);
            dao.delete(item);
            forward = LIST_LOAN_ITEM;
            request.setAttribute("loanItems", dao.findByOwnerId(logInUser.getId()));
            request.setAttribute("borrowItems", dao.findByLoanUserId(logInUser.getId()));    
        } else if (action.equalsIgnoreCase("edit")){
            forward = INSERT_OR_EDIT;
            int id = Integer.parseInt(request.getParameter("id"));
            LoanItem item = dao.findById(id);
            request.setAttribute("loanItem", item);
        } else if (action == null || action.equalsIgnoreCase("list")){
            forward = LIST_LOAN_ITEM;
            request.setAttribute("loanItems", dao.findByOwnerId(logInUser.getId()));
            request.setAttribute("borrowItems", dao.findByLoanUserId(logInUser.getId())); 
        } else if (action.equalsIgnoreCase("insert")){
            forward = INSERT_OR_EDIT;
            
        }

        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User logInUser = (User) request.getSession().getAttribute("loginUser");
		LoanItemDAO dao = new LoanItemDAO();
		LoanItem item = new LoanItem();
        
        
        String id = request.getParameter("id");
        if(id == null || id.isEmpty())
        {
        	item = new LoanItem();
//            dao.persist(item);
        }
        else
        {
        	item = dao.findById(Integer.parseInt(id));
            //dao.update(item);
        }
        item.setDescription(request.getParameter("description"));
        try {
            Date date = new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("date"));
            item.setDate(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
//        int loanUserId = Integer.parseInt(request.getParameter("loanUser"));
        String loanUserId = request.getParameter("loanUserId");
        UserDAO userDAO = new UserDAO();
        User loanUser = userDAO.findByFbId(loanUserId);
        if (loanUser == null){
        	loanUser = new User();
        	loanUser.setFbUserId(loanUserId);
        	loanUser.setName(request.getParameter("name"));
        	userDAO.persist(loanUser);
        	//item.setUserByLoanUserId(loanUser);
        }
        
        int loanType = Integer.parseInt(request.getParameter("loanType"));
        if (loanType == 1){
        	item.setUserByOwnerUserId(logInUser);
        	item.setUserByLoanUserId(loanUser);
        } else if (loanType == 2){
        	item.setUserByOwnerUserId(loanUser);
        	item.setUserByLoanUserId(logInUser);
        }
        
        int itemTypeId = Integer.parseInt(request.getParameter("itemType"));
        ItemTypeDAO itemTypeDAO = new ItemTypeDAO();
        ItemType itemType = itemTypeDAO.findById(itemTypeId);
        
        item.setItemType(itemType);
        String loanStatus = request.getParameter("loanStatus") != null ? request.getParameter("loanStatus") : "LOAN";
        item.setLoanStatus(loanStatus);
        int loanItemId;
        if(id == null || id.isEmpty())
        {
        	loanItemId = dao.persist(item);
        }
        else
        {
            dao.update(item);
            loanItemId = Integer.parseInt(id);
        }
        
        String path = request.getServletContext().getRealPath("/")+"imgs/item/";
		String fileName = "item_" + loanItemId + ".png";
		File file = new File(path + fileName);
		if (file.exists()){
			item.setPhoto(fileName);
			dao.update(item);
		}
        
        
        RequestDispatcher view = request.getRequestDispatcher(LIST_LOAN_ITEM);
        request.setAttribute("loanItems", dao.findByOwnerId(logInUser.getId()));
        request.setAttribute("borrowItems", dao.findByLoanUserId(logInUser.getId())); 
        view.forward(request, response);
	}

}
