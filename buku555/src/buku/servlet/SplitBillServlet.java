package buku.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import buku.dao.BillDAO;
import buku.dao.BillSpliteesDAO;
import buku.dao.LoanMoneyDAO;
import buku.dao.UserDAO;
import buku.entities.Bill;
import buku.entities.BillSplitees;
import buku.entities.LoanMoney;
import buku.entities.User;

/**
 * Servlet implementation class SplitBillServlet
 */
@WebServlet("/SplitBillServlet")
public class SplitBillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BillDAO billDAO;
	private BillSpliteesDAO spliteeDAO;
	private UserDAO userDAO;
	private LoanMoneyDAO loanMoneyDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SplitBillServlet() {
        super();
        billDAO = new BillDAO();
        spliteeDAO = new BillSpliteesDAO();
        userDAO = new UserDAO();
        loanMoneyDAO = new LoanMoneyDAO();
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
		//System.out.println(request.getParameter("totalAmount"));
		//System.out.println(request.getParameter("reason"));
		HttpSession sess = request.getSession();
		//User logInUser = userDAO.findByFbId("11111");
		User logInUser = (User) sess.getAttribute("loginUser");
		//Create a new Bill
		
		Bill bill = new Bill();
		bill.setUser(logInUser);
		bill.setTotalAmount(Double.parseDouble(request.getParameter("totalAmount")));
		bill.setReason(request.getParameter("reason"));
		bill.setDate(new Date());
		//bill.setPhoto("photo");
		int billId = billDAO.persist(bill);
		
		//Create new splitee
		String[] fbIds = request.getParameterValues("fbIds[]");
		String[] amounts = request.getParameterValues("amounts[]");
		String[] names = request.getParameterValues("names[]");
		for (int i = 0; i < amounts.length; i++) {
			BillSplitees splitee = new BillSplitees();
			Double amountToPay = Double.parseDouble(amounts[i]);
			splitee.setAmountToPay(amountToPay);
			User u = userDAO.findByFbId(fbIds[i]);
			if (u != null){
				splitee.setUser(u);
			} else {
				u = new User();
				u.setFbUserId(fbIds[i]);
				u.setName(names[i]);
				//u.setEmail(email);
				u = userDAO.persist(u);
				splitee.setUser(u);
			}
			splitee.setBillId(billId);
			spliteeDAO.persist(splitee);
			
			//avoid record yourself
			if (u.getId() == logInUser.getId())
				continue;
			
			//record loan money
			LoanMoney loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(logInUser.getId(), u.getId());
			// someone owe you
			if (loanMoney != null){
				loanMoney.setTotalLoanAmount(loanMoney.getTotalLoanAmount() + amountToPay);
				
			} else {
				loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(u.getId(), logInUser.getId());
				// u owe someone
				if (loanMoney != null){
					loanMoney.setTotalLoanAmount(loanMoney.getTotalLoanAmount() - amountToPay);
				} else {
					loanMoney = new LoanMoney();
					loanMoney.setUserByOwnerUserId(logInUser);
					loanMoney.setUserByLoanUserId(u);
					loanMoney.setTotalLoanAmount(amountToPay);
				}
			}
			loanMoneyDAO.persist(loanMoney);
		}
		
		PrintWriter out = response.getWriter();
		out.println("success");
		
	}

}
