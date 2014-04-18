package Mail;


import java.util.List;
import buku.dao.LoanItemDAO;
import buku.dao.LoanMoneyDAO;
import buku.dao.UserDAO;
import buku.entities.LoanItem;
import buku.entities.LoanMoney;
import buku.entities.User;
import Mail.SendMail;

public class Mailer implements Runnable {

    @Override
    public void run() {
    	
    	SendMail mymail=new SendMail();
    	UserDAO userDAO = new UserDAO();
    	LoanMoneyDAO loanMoneyDAO = new LoanMoneyDAO();
    	try
		{
    		String msgtxt="";
			List<User> notiUsers = userDAO.findNotiUser();
			//Send Money Reminder
			for (User u : notiUsers){
				msgtxt="Dear "+ u.getName() +",<br>";
				msgtxt+="This is the reminder for the money you owed your friends and your friends owed you." +"<br><br>";	
				// money to paid
				List<LoanMoney> oweMoney = loanMoneyDAO.findLoanMoneyByLoanUserId(u.getId());
				if (oweMoney != null && !oweMoney.isEmpty()){
					msgtxt+="<br>The money you owed your friends are :<br>";
					msgtxt+="<table cellpadding=5>";
					msgtxt+="<tr><td><b> Friend Name</b></td><td><b>Amount to paid</b></td></tr>";
					for(LoanMoney money : oweMoney){
						msgtxt+="<tr>";
						msgtxt+="<td>" + money.getUserByOwnerUserId().getName() + "</td>";
						msgtxt+="<td>" + money.getTotalLoanAmount() + "</td>";
						msgtxt+="</tr>";
					}
					msgtxt+="</table>";
				}else {
					msgtxt += "<br>You have not owed your friends any money in this period.";
				}
				
				List<LoanMoney> loanMoney = loanMoneyDAO.findLoanMoneyByOwnerUserId(u.getId());
				if (loanMoney != null && !loanMoney.isEmpty()){
					msgtxt+="<br>The money your friends owned you are :<br>";
					msgtxt+="<table cellpadding=5>";
					msgtxt+="<tr><td><b> Friend Name</b></td><td><b>Amount to receive</b></td></tr>";
					for(LoanMoney money : loanMoney){
						msgtxt+="<tr>";
						msgtxt+="<td>" + money.getUserByLoanUserId().getName() + "</td>";
						msgtxt+="<td>" + money.getTotalLoanAmount() + "</td>";
						msgtxt+="</tr>";
					}
					msgtxt+="</table>";
				}else {
					msgtxt += "<br>Your friends have not owed you any money in this period.";
				}
				
				msgtxt += "<br> If any information above is not correct. Please talk to your friend!!!";
				msgtxt += "<br><br> Best Regards, <br> Buku555 Team";
				mymail.sendingmail(u.getEmail(), "Money Reminder", msgtxt);
				//End Send Money Reminder
				
				
				
				//Send Loan Item Reminder
				LoanItemDAO loanItemDAO = new LoanItemDAO();
				msgtxt="Dear "+ u.getName() +",<br>";
				msgtxt+="This is the reminder for the item(s) you borrowed from your friends and your friends borrowed from you." +"<br><br>";
				//Item Borrowed
				List<LoanItem> borrowItems = loanItemDAO.findByLoanUserIdAndStatus(u.getId(), "LOAN");
				if (borrowItems != null && !borrowItems.isEmpty()){
					msgtxt+="<br>The items you borrowed from your friends :<br>";
					msgtxt+="<table cellpadding=5>";
					msgtxt+="<tr><td><b> Friend Name</b></td><td><b>Item Description</b></td></tr>";
					for (LoanItem item : borrowItems){
						msgtxt+="<tr>";
						msgtxt+="<td>" + item.getUserByOwnerUserId().getName() + "</td>";
						msgtxt+="<td>" + item.getDescription() + "</td>";
						msgtxt+="</tr>";
					}
					msgtxt+="</table>";
				} else {
					msgtxt += "<br>You have not borrowed your friends any items in this period.";
				}
				
				//Item Lend
				List<LoanItem> lendItems = loanItemDAO.findByOwnerIdAndStatus(u.getId(), "LOAN");
				if (lendItems != null && !lendItems.isEmpty()){
					msgtxt+="<br>The items your friends borrowed from you :<br>";
					msgtxt+="<table cellpadding=5>";
					msgtxt+="<tr><td><b> Friend Name</b></td><td><b>Item Description</b></td></tr>";
					for (LoanItem item : lendItems){
						msgtxt+="<tr>";
						msgtxt+="<td>" + item.getUserByLoanUserId().getName() + "</td>";
						msgtxt+="<td>" + item.getDescription() + "</td>";
						msgtxt+="</tr>";
					}
					msgtxt+="</table>";
				} else {
					msgtxt += "<br>You friends have not borrowed you any items in this period.";
				}
				
				msgtxt += "<br> If any information above is not correct. Please talk to your friend!!!";
				msgtxt += "<br><br> Best Regards, <br> Buku555 Team";
				mymail.sendingmail(u.getEmail(), "Loan Item Reminder", msgtxt);
				//End Send Money Reminder
				
			}
			
			
								
			  
		}catch(Exception e){
			e.printStackTrace();
		}
    	finally {}	
   }
}
    


    
