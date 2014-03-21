/**
 * 
 */
package Mail;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * @author Inspiron 5421(1116)
 *
 */
public class SendMail {
	   
	public SendMail() {
		// TODO Auto-generated constructor stub
	}
	public void sendingmail(String mailaddtosend,String mailtitle, String mailtxt){
		try{

			Properties props=new Properties();
	    	props.put("mail.smtp.host","smtp.gmail.com");
	    	props.put("mail.smtp.socketFactory.port", "465");
	    	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
	    	props.put("mail.smtp.auth", "true");
	    	props.put("mail.smtp.port", "465");
	    	props.put("mail.debug", "false");
	    	props.put("mail.smtp.ssl.enable", "true");


	    	Session ses = Session.getDefaultInstance(props,  
	    			 new javax.mail.Authenticator() {  
	    			  protected PasswordAuthentication getPasswordAuthentication() {  
	    			   return new PasswordAuthentication("thiri.may08@gmail.com","icanflythirimay");  
	    			   }  
	    			});  
	    	Message msg=new MimeMessage(ses);
	    	msg.setFrom(new InternetAddress("thiri.may08@gmail.com"));	    	
	    	msg.addRecipient(Message.RecipientType.TO,new InternetAddress(mailaddtosend));
	    	msg.setSubject(mailtitle);
	    	msg.setText(mailtxt);
	    	Transport.send(msg);
	    	System.out.println("Message sent");
	    }

	    catch(Exception e)
	    {
	    	System.out.println(e);
	    }
		
	}
	
}


