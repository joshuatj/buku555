package Ops;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.CurrencyDBAO;

/**
 * Servlet implementation class loadBulkRates
 */
@WebServlet("/loadBulkRates")
public class loadBulkRates extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loadBulkRates() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CurrencyDBAO dbo = null;
		try {
			dbo = new CurrencyDBAO();
		} catch (Exception e1) {
			// 
			e1.printStackTrace();
		}
		Date currtme = new Date();
		Date current = new Date(currtme.getTime() - 1 * 24 * 3600 * 1000 );
		
		SimpleDateFormat datefmt = new SimpleDateFormat ("yyyy-MM-dd");

		System.out.println("Current Date: " + datefmt.format(current)+"<br>");
		
		try {
			System.out.println("Fetching USD");
			dbo.addBulkCurreny("USD", "2014-01-01", datefmt.format(current));
			System.out.println("Fetching GBP");
			dbo.addBulkCurreny("GBP", "2014-01-01", datefmt.format(current));
			System.out.println("Fetching MYR");
			dbo.addBulkCurreny("MYR", "2014-01-01", datefmt.format(current));
			System.out.println("Fetching EUR");
			dbo.addBulkCurreny("EUR", "2014-01-01", datefmt.format(current));
			System.out.println("Done");
		} catch (Exception e) {
			// 
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
