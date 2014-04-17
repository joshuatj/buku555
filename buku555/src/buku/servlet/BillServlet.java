package buku.servlet;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import buku.dao.BillDAO;
import buku.dao.BillSpliteesDAO;
import buku.entities.Bill;
import buku.entities.BillSplitees;
import buku.entities.LoanItem;
import buku.entities.User;

/**
 * Servlet implementation class BillServlet
 */
@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String INSERT_OR_EDIT = "/EditBillShare.jsp";
	private static String LIST_BILL_SHARED = "/BillShare.jsp";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BillServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String forward="";
        String action = request.getParameter("action");
        BillSpliteesDAO dao = new BillSpliteesDAO();
        BillDAO billDA0 = new BillDAO();
        User logInUser = (User) request.getSession().getAttribute("loginUser");
        if (action.equalsIgnoreCase("list")){
            forward = LIST_BILL_SHARED;
            request.setAttribute("billItems", billDA0.findByOwnerId(logInUser.getId()));    
        }else if (action.equalsIgnoreCase("viewShare")){
            int id = Integer.parseInt(request.getParameter("id"));
            //forward = LIST_BILL_SHARED;
            //request.setAttribute("billItems", dao.findAll());    
        } else if (action.equalsIgnoreCase("edit")){
            forward = INSERT_OR_EDIT;
            int id = Integer.parseInt(request.getParameter("id"));
            List<BillSplitees> items = dao.findByBillId(id);
            Bill bill = billDA0.findById(id);
            request.setAttribute("billSharedItems", items);
            request.setAttribute("bill", bill);
//            request.setAttribute("totalAmount", !items.isEmpty() ? items.get(0).getLoanItem().getTotalAmount() : "0");
        }
        
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		BillDAO billDAO = new BillDAO();
		Bill bill = billDAO.findById(id);
		String reason = request.getParameter("reason");
		Date date = new Date(request.getParameter("date"));
		bill.setReason(reason);
		bill.setDate(date);
		
		if (bill.getPhoto() == null){
			String path = request.getServletContext().getRealPath("/")+"imgs/bill/";
			String fileName = "bill_" + id + ".png";
			File file = new File(path + fileName);
			if (file.exists()){
				bill.setPhoto(fileName);
			}
		}
		billDAO.update(bill);
		
		User logInUser = (User) request.getSession().getAttribute("loginUser");
        request.setAttribute("billItems", billDAO.findByOwnerId(logInUser.getId())); 
        RequestDispatcher view = request.getRequestDispatcher(LIST_BILL_SHARED);
        view.forward(request, response);
		
	}

}
