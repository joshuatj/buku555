package buku.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import buku.dao.LoanMoneyDAO;
import buku.dao.TransactionDAO;
import buku.dao.UserDAO;
import buku.entities.LoanMoney;
import buku.entities.Transaction;
import buku.entities.User;

/**
 * Servlet implementation class MoneyServlet
 */
@WebServlet("/LoanMoneyServlet")
public class LoanMoneyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String PAYMENT = "/MoneyPayment.jsp";
	private static String LIST_LOAN_ITEM = "/LoanMoney.jsp";
	
	private LoanMoneyDAO loanMoneyDAO;
	private TransactionDAO transactionDAO;
	private UserDAO userDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoanMoneyServlet() {
        super();
        loanMoneyDAO = new LoanMoneyDAO();
        transactionDAO = new TransactionDAO();
        userDAO = new UserDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String forward="";
        String action = request.getParameter("action");
        HttpSession sess = request.getSession();
		User logInUser = (User) sess.getAttribute("loginUser");
        

       if (action.equalsIgnoreCase("settle")){
            forward = PAYMENT;
            int id = Integer.parseInt(request.getParameter("id"));
            LoanMoney item = loanMoneyDAO.findById(id);
            
            request.setAttribute("select", request.getParameter("select"));
            request.setAttribute("loanItem", item);
        } else if (action.equalsIgnoreCase("list")){
            forward = LIST_LOAN_ITEM;
            List<LoanMoney> list1 = loanMoneyDAO.findLoanMoneyByOwnerUserId(logInUser.getId());
            List<LoanMoney> list2 = loanMoneyDAO.findLoanMoneyByLoanUserId(logInUser.getId());
            
            List<LoanMoney> loanMoney = new ArrayList<LoanMoney>();
            List<LoanMoney> oweMoney = new ArrayList<LoanMoney>();
            
            if (!list1.isEmpty()){
            	for (LoanMoney l : list1) {
					if (l.getTotalLoanAmount() > 0)
						loanMoney.add(l);
					else if (l.getTotalLoanAmount() < 0)
						oweMoney.add(l);
				}
            }
            
            if (!list2.isEmpty()){
            	for (LoanMoney l : list2) {
					if (l.getTotalLoanAmount() > 0)
						oweMoney.add(l);
					else if (l.getTotalLoanAmount() < 0)
						loanMoney.add(l);
				}
            }
            
            request.setAttribute("loanMoney", loanMoney);
            request.setAttribute("oweMoney", oweMoney);
        }

        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		double amount = Double.parseDouble(request.getParameter("amount"));
		String fbId = request.getParameter("fbId");
		int selectWhoPaid = Integer.parseInt(request.getParameter("selectWhoPaid"));
		String name = request.getParameter("name");
		
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		User fbUser = userDAO.findByFbId(fbId);
		if (fbUser == null){
			fbUser = new User();
			fbUser.setFbUserId(fbId);
			fbUser.setName(name);
			fbUser = userDAO.persist(fbUser);
		}
		User fromWhoUser = null;
		User toWhoUser = null;
		if (selectWhoPaid == 1 || selectWhoPaid == 4){
			fromWhoUser = loginUser;
			toWhoUser = fbUser;
		} else if (selectWhoPaid == 2 || selectWhoPaid == 3){
			fromWhoUser = fbUser;
			toWhoUser = loginUser;
		}
		
		// if paid, record the transaction
		if (selectWhoPaid == 1 || selectWhoPaid == 2){
			Transaction t = new Transaction();
			t.setPaidAmount(amount);
			t.setUserByFromUserId(fromWhoUser);
			t.setUserByToUserId(toWhoUser);
			t.setTransactionDate(new Date());
			
			transactionDAO.persist(t);
		}
		
		
		// record loan money if there's no loan money between these 2 users
		LoanMoney loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(fromWhoUser.getId(), toWhoUser.getId());
		if (loanMoney != null){
			loanMoney.setTotalLoanAmount(loanMoney.getTotalLoanAmount() + amount);
		} else {
			loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(toWhoUser.getId(), fromWhoUser.getId());
			if (loanMoney != null){
				loanMoney.setTotalLoanAmount(loanMoney.getTotalLoanAmount() - amount);
			} else {
				loanMoney = new LoanMoney();
				loanMoney.setUserByOwnerUserId(fromWhoUser);
				loanMoney.setUserByLoanUserId(toWhoUser);
				loanMoney.setTotalLoanAmount(amount);
			}
			
		}
		loanMoneyDAO.update(loanMoney);
		
		PrintWriter out = response.getWriter();
		out.println("success");
	}

}
