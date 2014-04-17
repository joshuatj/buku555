package WebServices;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.*;
import java.util.ArrayList;
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.CurrencyDetails;
import WebServices.checkData;


/**
 * Servlet implementation class reader
 */
@WebServlet("/fetchData")
public class fetchData extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public checkData chkd = new checkData();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public fetchData() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	
		
		int mode = Integer.parseInt(request.getParameter("mode"));
	
		if(mode==1)
		{
			try {
				getRateHTML(request.getParameter("to"), request.getParameter("from"), response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(mode==2)
		{
			try {
				getHistroicRateHTML(request.getParameter("to"), request.getParameter("from"),request.getParameter("date"), response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(mode==3)
		{
			try {
				getSupportedCurrenciesHTML(request.getParameter("date"), response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	private void getRateHTML(String from, String to, HttpServletResponse response) throws Exception
	{
		ArrayList<String> data = new ArrayList<String>();
		URL target = new URL("http://currencies.apps.grandtrunk.net/getlatest/"+from+"/"+to);
		data = getRequestToWebService(target);
		
        PrintWriter out = response.getWriter();
		out.println(data.get(0));
	    out.close();	
	}
	
	public String getRate(String from, String to) throws Exception
	{
		ArrayList<String> data = new ArrayList<String>();
		URL target;
		try {
			target = new URL("http://currencies.apps.grandtrunk.net/getlatest/"+from+"/"+to);
			data = getRequestToWebService(target);
		} catch (MalformedURLException e) {
			throw new Exception();
		}

		
        return chkd.checkString(data.get(0));
	}
	
	private void getHistroicRateHTML(String from, String to, String date, HttpServletResponse response) throws Exception
	{
		ArrayList<String> data = new ArrayList<String>();
		URL target = new URL("http://currencies.apps.grandtrunk.net/getrate/"+date+"/"+from+"/"+to);
		data = getRequestToWebService(target);
		
        PrintWriter out = response.getWriter();
		out.println(data.get(0));
	    out.close();	
	}
	
	public String getHistoricRate(String from, String to, String date) throws Exception
	{
		ArrayList<String> data = new ArrayList<String>();
		URL target = new URL("http://currencies.apps.grandtrunk.net/getrate/"+date+"/"+from+"/"+to);
		data = getRequestToWebService(target);
		
        return chkd.checkString(data.get(0));
	}
	
	public ArrayList<CurrencyDetails> getHistoricRangeRate(String from, String to, String dateFrom, String dateTo) throws Exception
	{
		ArrayList<CurrencyDetails> data = new ArrayList<CurrencyDetails>();
		ArrayList<String> tmp = new ArrayList<String>();
		
		URL target = new URL("http://currencies.apps.grandtrunk.net/getrange/"+dateFrom+"/"+dateTo+"/"+from+"/"+to);
		tmp = getRequestToWebService(target);
		
		for(String s: tmp)
		{
			String[] strArray = s.split("\\s+");
			CurrencyDetails cdtmp = new CurrencyDetails(to,strArray[0],strArray[1]);
			data.add(cdtmp);
		}
		
        return chkd.checkCurrencyDetailsArray(data);
	}
	
	private void getSupportedCurrenciesHTML(String date, HttpServletResponse response) throws Exception
	{
		ArrayList<String> data = new ArrayList<String>();
		URL target = new URL("http://currencies.apps.grandtrunk.net/currencies/"+date);
		data = getRequestToWebService(target);
		
        PrintWriter out = response.getWriter();
		
        for(String s: data)
        out.println(s+"<br>");
	    out.close();		
	}
	
	public ArrayList<String> getSupportedCurrencies(String date) throws Exception
	{
		ArrayList<String> data = new ArrayList<String>();
		URL target = new URL("http://currencies.apps.grandtrunk.net/currencies/"+date);
		data = getRequestToWebService(target);
		
		return chkd.checkStringArray(data);
	}
	
	private ArrayList<String> getRequestToWebService(URL urlCall)
	{
		String result = null;
		ArrayList<String> data = new ArrayList<String>();

        URLConnection conn = null;
		try {
			conn = urlCall.openConnection();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
        BufferedReader br = null;
		try {
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} catch (IOException e1) {
			e1.printStackTrace();
		}
       
        try {
			while ((result = br.readLine()) != null)
			{
			  if(!result.equals(null))
			  {
				data.add(result);
			  }
			} }
			catch (IOException e) {
			e.printStackTrace();
		}
        
        try {
			br.close();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
        
        return data;
	}
	
	
}
