package buku.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import buku.dao.TransactionDAO;
import buku.dao.UserDAO;
import buku.entities.Bill;
import buku.entities.BillSplitees;
import buku.entities.LoanMoney;
import buku.entities.Transaction;
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
	private TransactionDAO transactionDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SplitBillServlet() {
        super();
        billDAO = new BillDAO();
        spliteeDAO = new BillSpliteesDAO();
        userDAO = new UserDAO();
        loanMoneyDAO = new LoanMoneyDAO();
        transactionDAO = new TransactionDAO();
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
		User logInUser = (User) sess.getAttribute("loginUser");
		//Create a new Bill
		
		Bill bill = new Bill();
		bill.setUser(logInUser);
		bill.setTotalAmount(Double.parseDouble(request.getParameter("totalAmount")));
		bill.setReason(request.getParameter("reason"));
		String date = request.getParameter("date").trim();
		
		if (date != null || !date.isEmpty()){
			try {
				bill.setDate(new Date(date));
            } catch (Exception e) {
                e.printStackTrace();
            }
		}
			
		//bill.setPhoto("photo");
		int billId = billDAO.persist(bill);
		String path = request.getServletContext().getRealPath("/")+"imgs/bill/";
		String fileName = "bill_" + billId + ".png";
		File file = new File(path + fileName);
		if (file.exists()){
			bill.setPhoto(fileName);
			billDAO.update(bill);
		}
			
		
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
			
			//record transaction
			if (u.getId().intValue() != logInUser.getId().intValue()){
				Transaction t = new Transaction();
				t.setPaidAmount(amountToPay);
				try{
					t.setTransactionDate(new Date(date));
				}catch (Exception ex){
					ex.printStackTrace();
				}
				t.setReason(request.getParameter("reason"));
				t.setTransactionType(2); //owe transaction
				t.setUserByFromUserId(u);
				t.setUserByToUserId(logInUser);
				transactionDAO.persist(t);
			}
			
			
			//avoid record yourself, record with your friends
			if (u.getId().intValue() != logInUser.getId().intValue()){
				//record loan money
				LoanMoney loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(logInUser.getId(), u.getId());
				// someone owe you
				if (loanMoney != null){
					loanMoney.setTotalLoanAmount(roundDouble(loanMoney.getTotalLoanAmount() + amountToPay));
					
				} else {
					loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(u.getId(), logInUser.getId());
					// u owe someone
					if (loanMoney != null){
						double totalAmount = loanMoney.getTotalLoanAmount();
						if (totalAmount >= amountToPay){
							loanMoney.setTotalLoanAmount(roundDouble(loanMoney.getTotalLoanAmount() - amountToPay));
						} else{
							// delete old debt and create new one
							loanMoneyDAO.delete(loanMoney);
							loanMoney = new LoanMoney();
							loanMoney.setUserByOwnerUserId(logInUser);
							loanMoney.setUserByLoanUserId(u);
							loanMoney.setTotalLoanAmount(roundDouble(amountToPay - totalAmount));
							loanMoneyDAO.persist(loanMoney);
						}
						//loanMoney.setTotalLoanAmount(roundDouble(loanMoney.getTotalLoanAmount() - amountToPay));
					} else {
						loanMoney = new LoanMoney();
						loanMoney.setUserByOwnerUserId(logInUser);
						loanMoney.setUserByLoanUserId(u);
						loanMoney.setTotalLoanAmount(amountToPay);
					}
				}
				loanMoneyDAO.update(loanMoney);
			}
			
			
		}
		
		PrintWriter out = response.getWriter();
		out.println("success");
		
	}
	
	private double roundDouble(double amount){
		return Math.floor(amount * 100.0) / 100.0;
	}

}
