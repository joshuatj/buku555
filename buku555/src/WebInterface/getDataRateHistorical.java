package WebInterface;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.CurrencyDBAO;
import database.CurrencyDetails;

/**
 * Servlet implementation class getDataRateHistorical
 */
@WebServlet("/getDataRateHistorical")
public class getDataRateHistorical extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getDataRateHistorical() {
        super();
        
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
			String current = request.getParameter("date");
			String amount = request.getParameter("amount");
			String currency = request.getParameter("currency");
				      
			cd = dbo.checkCurreny(currency, current);
			Double result = (Double.parseDouble(cd.get(0).getValue())*Double.parseDouble(amount));
			result = Math.round(result * 100.0) / 100.0;
			out.println(result.toString());
			
		} catch (Exception e) {
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
