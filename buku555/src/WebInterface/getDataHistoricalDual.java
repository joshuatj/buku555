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
 * Servlet implementation class getDataHistoricalDual
 */
@WebServlet("/getDataHistoricalDual")
public class getDataHistoricalDual extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getDataHistoricalDual() {
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
		ArrayList<CurrencyDetails> ConvertToSGD = new ArrayList<CurrencyDetails>();
		ArrayList<CurrencyDetails> ConvertFromSGD = new ArrayList<CurrencyDetails>();
        
		try {
			String datefrom = request.getParameter("datefrom");
			String dateto = request.getParameter("dateto");
			String amount = request.getParameter("amount");
			String currencyfrom = request.getParameter("currencyfrom");
			String currencyto = request.getParameter("currencyto");
			
			ConvertToSGD = dbo.checkCurreny(currencyfrom, datefrom);
			ConvertFromSGD = dbo.checkCurreny(currencyto, dateto);
						
			Double toSGD = (Double.parseDouble(amount)/Double.parseDouble(ConvertToSGD.get(0).getValue()));
			Double fromSGD = (toSGD)*Double.parseDouble(ConvertFromSGD.get(0).getValue());
			
			Double result = Math.round(fromSGD * 100.0) / 100.0;
			//out.println(toSGD.toString()+" - "+fromSGD.toString()+" - "+result.toString());
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
