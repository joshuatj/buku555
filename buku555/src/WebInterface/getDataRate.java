package WebInterface;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.UnavailableException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;










//import util.Currency;
import database.*;

/**
 * Servlet implementation class test2
 */
@WebServlet("/getDataRate")
public class getDataRate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CurrencyDBAO currencyDB = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getDataRate() {
        super();
        
    }
    
    public void init() throws ServletException {
        currencyDB = (CurrencyDBAO) getServletContext().getAttribute("curDB");

        if (currencyDB == null) {
            throw new UnavailableException("Couldn't get database.");
        }
    }

    public void destroy() {
    	currencyDB = null;
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
			
			e1.printStackTrace();
		}
		ArrayList<CurrencyDetails> cd = new ArrayList<CurrencyDetails>();
        
		try {
			Date current = new Date();
			SimpleDateFormat datefmt = new SimpleDateFormat ("yyyy-MM-dd");
			String amount = request.getParameter("amount");
			String currency = request.getParameter("currency");
			
			System.out.println("Current Date: " + datefmt.format(current)+"<br>");
				      
			cd = dbo.checkCurreny(currency, datefmt.format(current));
			Double result = (Double.parseDouble(cd.get(0).getValue())*Double.parseDouble(amount));
			result = Math.round(result * 100.0) / 100.0;
			out.println(result.toString());
			
			
		} 
		catch (Exception e) {
			out.println("There was a problem performing this task, check webservice connectivity");
		}       

		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
