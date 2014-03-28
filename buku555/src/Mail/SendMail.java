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

			final String username = "flappy.lms@gmail.com";
			final String password = "lms456123";
	 
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");


			Session session = Session.getInstance(props,
					  new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(username, password);
						}
					  });
			
			
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("flappy.lms@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(mailaddtosend));
			message.setSubject(mailtitle);
			message.setText(mailtxt);
 
			Transport.send(message);	    	
	    	
	    	System.out.println("Message sent");
	    }

	    catch(Exception e)
	    {
	    	System.out.println(e);
	    }
		
	}
	
}


