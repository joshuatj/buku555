package myListener;


import database.CurrencyDBAO;

import javax.servlet.*;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class myListener
 *
 */
@WebListener
public class myListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public myListener() {
        
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    private ServletContext context = null;
    public void contextInitialized(ServletContextEvent event) {
    	context = event.getServletContext();

        try {
            CurrencyDBAO curDB = new CurrencyDBAO();
            context.setAttribute("curDB", curDB);
        } catch (Exception ex) {
            System.out.println("Couldn't create database bean: " +
                ex.getMessage());
        }
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent event) {
    	context = event.getServletContext();

        CurrencyDBAO curDB = (CurrencyDBAO) context.getAttribute("curDB");

        if (curDB != null) {
            curDB.remove();
        }

        context.removeAttribute("curDB");

    }
	
}
