package buku.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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

import database.CurrencyDBAO;
import database.CurrencyDetails;

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
		String currency = request.getParameter("currency");
		String fbId = request.getParameter("fbId");
		int selectWhoPaid = Integer.parseInt(request.getParameter("selectWhoPaid"));
		String name = request.getParameter("name");
		
		//try to convert from other currency to SGD
		if (!currency.equalsIgnoreCase("SGD")){
			try{
				amount = convertToSGD(amount, currency);
				System.out.println("###########" + amount);
			}catch (Exception ex){
				ex.printStackTrace();
			}
		}
		
		
		
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
		
		//record the transaction history
		Transaction t = new Transaction();
		t.setPaidAmount(amount);
		try{
			t.setTransactionDate(new Date(request.getParameter("date")));
		}catch (Exception ex){
			ex.printStackTrace();
		}
			
		t.setReason(request.getParameter("reason"));
		if (selectWhoPaid == 1 || selectWhoPaid == 2){
			t.setTransactionType(1); //paid transaction
			t.setUserByFromUserId(fromWhoUser);
			t.setUserByToUserId(toWhoUser);
		} else if (selectWhoPaid == 3 || selectWhoPaid == 4){
			t.setTransactionType(2); //owe transaction
			t.setUserByFromUserId(toWhoUser);
			t.setUserByToUserId(fromWhoUser);
		}
		int transId = transactionDAO.persist(t);
		
		String path = request.getServletContext().getRealPath("/")+"imgs/transaction/";
		String fileName = "transaction_" + transId + ".png";
		File file = new File(path + fileName);
		if (file.exists()){
			t.setPhoto(fileName);
			transactionDAO.update(t);
		}
		
		
		// record loan money if there's no loan money between these 2 users
		LoanMoney loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(fromWhoUser.getId(), toWhoUser.getId());
		if (loanMoney != null){
			loanMoney.setTotalLoanAmount(roundDouble(loanMoney.getTotalLoanAmount() + amount));
		} else {
			loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserIdAndLoanUserId(toWhoUser.getId(), fromWhoUser.getId());
			if (loanMoney != null){
				loanMoney.setTotalLoanAmount(roundDouble(loanMoney.getTotalLoanAmount() - amount));
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
	
	private Double convertToSGD(double amount, String currency){
		CurrencyDBAO dbo = null;
		try {
			dbo = new CurrencyDBAO();
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}
		
		ArrayList<CurrencyDetails> cd = new ArrayList<CurrencyDetails>();
        
		try {
			Date current = new Date();
			SimpleDateFormat datefmt = new SimpleDateFormat ("yyyy-MM-dd");
				      
			cd = dbo.checkCurreny(currency, datefmt.format(current));
			Double result = 0.0;
			DecimalFormat money = new DecimalFormat("0.00");
			result = (amount/Double.parseDouble(cd.get(0).getValue()));		
			result = Math.floor(result * 100.0) / 100.0;
			return result;
			
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return amount;
	}
	
	private double roundDouble(double amount){
		return Math.floor(amount * 100.0) / 100.0;
	}

}
