package myListener;


import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;





import Mail.Mailer;
import Mail.SendMail;

/**
 * Application Lifecycle Listener implementation class MailReminderListener
 *
 */
@WebListener
public class MailReminderListener implements ServletContextListener{
	
	private ScheduledExecutorService scheduler;	

	@Override
    public void contextInitialized(ServletContextEvent event) {       
		scheduler = Executors.newSingleThreadScheduledExecutor();
		 scheduler.scheduleAtFixedRate(new Mailer(), 0, 1, TimeUnit.HOURS);	  	 
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        scheduler.shutdownNow();
    }
}
