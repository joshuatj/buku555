package Mail;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import com.mysql.jdbc.Connection;

import Mail.SendMail;

public class Mailer implements Runnable {

    @Override
    public void run() {
    	
    	
    	//doooooo
        //
    	SendMail mymail=new SendMail();
    	try
		{
    		String id,toaddress, title, msgtxt,loanowner = null, debter=null;
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/buku3","root","toor");
				
				Statement st2=(Statement) con.createStatement();	
				ResultSet rs=((java.sql.Statement) st2).executeQuery("SELECT * FROM user Where email is not null and Receive_Notimail=1");
				while(rs.next()){
					id=rs.getString("id");
					toaddress=rs.getString("email");
					msgtxt="Dear user,"+"<br>"+ "This is the reminder for the bill and item you have to paid and receive." +"<br>";
					ResultSet rs2=((java.sql.Statement) st2).executeQuery("SELECT * FROM loan_money where loan_money.loan_user_id="+id);
					while(rs2.next()){
						String ownerid=rs2.getString("owner_user_id");
						ResultSet rsowner=((java.sql.Statement) st2).executeQuery("SELECT * FROM user where id="+ownerid);
						while(rsowner.next()){
							loanowner=rsowner.getString("fb_user_id");
						}
						msgtxt+="amount to pay "+ loanowner +"-"+ rs2.getString("total_loan_amount")+"<br>";
					}
					
					rs2.close();
					
					ResultSet rs3=((java.sql.Statement) st2).executeQuery("select * from loan_item where loan_item.loan_status='LOAN' and loan_user_id="+id);
					while(rs3.next()){
						String ownerid=rs3.getString("owner_user_id");
						ResultSet rsowner=((java.sql.Statement) st2).executeQuery("SELECT * FROM user where id="+ownerid);
						while(rsowner.next()){
							loanowner=rsowner.getString("fb_user_id");
						}
						msgtxt+="item to pay "+ loanowner +"-"+ rs3.getString("description")+"<br>";
					}
					rs3.close();
					
					ResultSet rs4=((java.sql.Statement) st2).executeQuery("SELECT * FROM loan_money where loan_money.owner_user_id="+id);
					while(rs4.next()){
						String debterid=rs4.getString("loan_user_id");
						ResultSet rsdebter=((java.sql.Statement) st2).executeQuery("SELECT * FROM user where id="+debterid);
						while(rsdebter.next()){
							debter=rsdebter.getString("fb_user_id");
						}
						msgtxt+="amount to receive from "+ debter +"-"+ rs2.getString("total_loan_amount")+"<br>";
					}
					
					rs2.close();
					
					ResultSet rs5=((java.sql.Statement) st2).executeQuery("select * from loan_item where loan_item.loan_status='LOAN' and owner_user_id="+id);
					while(rs5.next()){
						String debterid=rs5.getString("loan_user_id");
						ResultSet rsdebter=((java.sql.Statement) st2).executeQuery("SELECT * FROM user where id="+debterid);
						while(rsdebter.next()){
							debter=rsdebter.getString("fb_user_id");
						}
						msgtxt+="item to receive from "+ debter +"-"+ rs3.getString("description")+"<br>";
					}
					rs3.close();
					
					title="Reminder for loan";
					mymail.sendingmail( toaddress, title, msgtxt);	
					
					con.close();  
				}							
								
			  
		}catch(Exception e){}
    	finally {}	
   }
}
    

    