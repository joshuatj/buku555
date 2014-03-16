package Ops;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.CurrencyDBAO;

/**
 * Servlet implementation class updateCurrenciesListInDB
 */
@WebServlet("/updateCurrenciesListInDB")
public class updateCurrenciesListInDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateCurrenciesListInDB() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		CurrencyDBAO dbo = null;
		try {
			dbo = new CurrencyDBAO();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		ArrayList<String> cd = new ArrayList<String>();
		ArrayList<String> cd2 = new ArrayList<String>();
        
		try {
			Date current = new Date();
			SimpleDateFormat datefmt = new SimpleDateFormat ("yyyy-MM-dd");
			System.out.println("Current Date: " + datefmt.format(current)+"<br>");
			
			out.println("<br>Before:<br>");
			cd = dbo.getDBKnownCurrencies();
			try {
				for(String s: cd)
		    out.println(s+"<br>");
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			
			dbo.updateDBKnownCurrencies(datefmt.format(current));
			cd2 = dbo.getDBKnownCurrencies();
			
			out.println("<br>After:<br>");
			try {
				for(String s: cd2)
		    out.println(s+"<br>");
			} catch (Exception e) {
				// TODO: handle exception
			}
		    
	        out.close();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage()+"<br>"+e.getStackTrace());
		}       

		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
