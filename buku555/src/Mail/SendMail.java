/**
 * 
 */
package Mail;

import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

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
	    			   return new PasswordAuthentication("flappy.lms@gmail.com","lms456123");  
	    			   }  
	    			});  
	    	Message msg=new MimeMessage(ses);
	    	msg.setFrom(new InternetAddress("flappy.lms@gmail.com"));	    	
	    	msg.addRecipient(Message.RecipientType.TO,new InternetAddress(mailaddtosend));
	    	msg.setSubject(mailtitle);	    	

	    	final MimeBodyPart textPart = new MimeBodyPart();
	        textPart.setContent(mailtxt, "text/plain"); 
	        // HTML version
	        final MimeBodyPart htmlPart = new MimeBodyPart();
	        htmlPart.setContent(mailtxt, "text/html");
	        // Create the Multipart.  Add BodyParts to it.
	        final Multipart mp = new MimeMultipart("alternative");
	        mp.addBodyPart(textPart);
	        mp.addBodyPart(htmlPart);
	        // Set Multipart as the message's content
	        msg.setContent(mp);
	    	
	    	Transport.send(msg);	 
	    	System.out.println("Message sent");
	    }

	    catch(Exception e)
	    {
	    	System.out.println(e);
	    }
		
	}
	
}


