package WebServices;

import java.util.ArrayList;

import database.CurrencyDetails;

public class checkData {


	public String checkString(String test) 
	{
		@SuppressWarnings("unused")
		String result = "";
		
		try{
		if(Double.parseDouble(test) > 0.0)
		{
				result = test;
		}
			
		return test;
		}
		catch(Exception e)
		{return test;}
	}
	
	
public ArrayList<String> checkStringArray(ArrayList<String> test) 
{
	ArrayList<String> result = new ArrayList<String>();
	
	try{
	for(String s: test)
	{
		if(s.length() == 3)
		{
			result.add(s);
		}
	}
	return result;
	}
	catch(Exception e)
	{return result;}
}

public ArrayList<CurrencyDetails> checkCurrencyDetailsArray(ArrayList<CurrencyDetails> test) {
	ArrayList<CurrencyDetails> result = new ArrayList<CurrencyDetails>();
	
	try{
	for(CurrencyDetails s: test)
	{
		int score = 0;
		
		if(s.getCountry_currency_code().length() == 3)
		{
			score++;
		}
		
		if(s.getDate().length() == 10 && s.getDate().contains("-"))
		{
			score++;
		}
		
		if(Double.parseDouble(s.getValue()) > 0.0)
		{
			score++;
		}
		
		if(score == 3)
		{result.add(s);}
		
	}
	}
	catch(Exception e)
	{
		return result;
	}
	
    return result;
}
}