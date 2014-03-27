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
        // Do your mailing job here.
    	
    	try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/buku3","root","toor");
			Statement st=(Statement) con.createStatement();
			ResultSet rs=((java.sql.Statement) st).executeQuery("select * from bill");
			
			while(rs.next()){			
				String loan_id=rs.getString("id");
				//String Owner_id=rs.getString("owner_user_id");
				Statement st2=(Statement) con.createStatement();				
				ResultSet rs2=((java.sql.Statement) st2).executeQuery("SELECT * FROM buku3.bill_splitees,buku3.user where buku3.bill_splitees.user_id=buku3.user.id and bill_id="+loan_id);
				while(rs2.next()){					
					SendMail mymail=new SendMail();
					String toaddress=rs2.getString("email");
					String title="Reminder to pay bill";
					String msgtxt="Dear user,"+"<br>"+ "This is the reminder for the bill you have to paid." +"<br>"+"amount to pay:" + rs2.getString("amount_to_pay");
					mymail.sendingmail(toaddress, title, msgtxt);									
				}
				rs2.close();
			}
			
			ResultSet rs3=((java.sql.Statement) st).executeQuery("select * from loan_item,user where loan_item.loan_user_id=user.id and loan_item.loan_status='1'");
			while(rs3.next()){
				//String Owner_id=rs3.getString("owner_user_id");
				SendMail mymail=new SendMail();
				String toaddress=rs3.getString("email");
				String title="Reminder of Loan Item";				
				String msgtxt="Dear user,"+"<br>"+ "This is the reminder for the bill you have to paid. " +"<br>"+"Loan Item:" + rs3.getString("description");
				mymail.sendingmail(toaddress, title, msgtxt);
				
			}
			
			rs.close();
			rs3.close();
			con.close();    
		}catch(Exception e){}
    	finally {}	
    	}
    }
    