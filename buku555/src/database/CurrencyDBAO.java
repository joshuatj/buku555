/*
 * Copyright (c) 2006 Sun Microsystems, Inc.  All rights reserved.  U.S.
 * Government Rights - Commercial software.  Government users are subject
 * to the Sun Microsystems, Inc. standard license agreement and
 * applicable provisions of the FAR and its supplements.  Use is subject
 * to license terms.
 *
 * This distribution may include materials developed by third parties.
 * Sun, Sun Microsystems, the Sun logo, Java and J2EE are trademarks
 * or registered trademarks of Sun Microsystems, Inc. in the U.S. and
 * other countries.
 *
 * Copyright (c) 2006 Sun Microsystems, Inc. Tous droits reserves.
 *
 * Droits du gouvernement americain, utilisateurs gouvernementaux - logiciel
 * commercial. Les utilisateurs gouvernementaux sont soumis au contrat de
 * licence standard de Sun Microsystems, Inc., ainsi qu'aux dispositions
 * en vigueur de la FAR (Federal Acquisition Regulations) et des
 * supplements a celles-ci.  Distribue par des licences qui en
 * restreignent l'utilisation.
 *
 * Cette distribution peut comprendre des composants developpes par des
 * tierces parties. Sun, Sun Microsystems, le logo Sun, Java et J2EE
 * sont des marques de fabrique ou des marques deposees de Sun
 * Microsystems, Inc. aux Etats-Unis et dans d'autres pays.
 */


package database;

import java.sql.*;

import java.util.*;

import WebServices.fetchData;


public class CurrencyDBAO {
    private ArrayList currencies;
    Connection con;
    private boolean conFree = true;
    
    // Database configuration
    public static String url = "jdbc:mysql://localhost:3306/buku555";
    public static String dbdriver = "com.mysql.jdbc.Driver";
    public static String username = "root";
    public static String password = "toor";
    
    public CurrencyDBAO() throws Exception {
        try {

            Class.forName(dbdriver);
            con = DriverManager.getConnection(url, username, password);
            
        } catch (Exception ex) {
            System.out.println("Exception in CurrencyDBAO: " + ex);
            throw new Exception("Couldn't open connection to database: " +
                    ex.getMessage());
        }
    }
    
    public void remove() {
        try {
            con.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    protected synchronized Connection getConnection() {
        while (conFree == false) {
            try {
                wait();
            } catch (InterruptedException e) {
            }
        }
        
        conFree = false;
        notify();
        
        return con;
    }
    
    protected synchronized void releaseConnection() {
        while (conFree == true) {
            try {
                wait();
            } catch (InterruptedException e) {
            }
        }
        
        conFree = true;
        notify();
    }
        

    
    public ArrayList<CurrencyDetails> checkCurreny(String currency, String date) throws Exception{
    	ArrayList <CurrencyDetails> currencies = new ArrayList<CurrencyDetails>();
    	
    	currencies = getDBCurreny(currency, date);
    	if(currencies.size() == 0)
    	{
    		String rate = null;
    		fetchData r = new fetchData();
    		
    		try{
    		rate = r.getRate("sgd", currency);
    		
    		}
    		catch(Exception e)
    		{
    			return null;
    		}
    		CurrencyDetails cd = new CurrencyDetails(currency,date,rate);
    		insertCurreny(cd);
    		currencies.add(cd);
    	}
    	
    	return currencies;
    }
    
    public boolean addBulkCurreny(String currency, String dateFrom, String dateTo) throws Exception {
    	ArrayList <CurrencyDetails> currencies = new ArrayList<CurrencyDetails>();
    	
    	fetchData r = new fetchData();
    	currencies = r.getHistoricRangeRate("sgd", currency, dateFrom, dateTo);
    		
    	for(CurrencyDetails cd: currencies)	
    	{insertCurreny(cd);}
 
    	return true;
    }
    
    public boolean insertCurreny(CurrencyDetails cd) throws Exception {
    	try {
    		String insertStatement = "insert into currency values (?,?,?)";
            getConnection();
                      
            PreparedStatement prepStmt = con.prepareStatement(insertStatement);
            prepStmt.setString(1, cd.getCountry_currency_code());
            prepStmt.setString(2, cd.getDate());
            prepStmt.setString(3, cd.getValue());
                        
            prepStmt.executeUpdate();
            
            prepStmt.close();
        } catch (SQLException ex) {
            return false;
        }
        
        releaseConnection();
		return true;
    }
    
    
    
    public ArrayList<CurrencyDetails> getDBCurreny(String currency, String date) throws Exception {
    	ArrayList <CurrencyDetails> currencies = new ArrayList<CurrencyDetails>();
        
        try {
            String selectStatement = "select * from currency where country_currency_code= ? and date = ?";
            getConnection();
         
            PreparedStatement prepStmt = con.prepareStatement(selectStatement);
            prepStmt.setString(1, currency);
            prepStmt.setString(2, date);
            ResultSet rs = prepStmt.executeQuery();
            
            while (rs.next()) {
                CurrencyDetails bd = new CurrencyDetails(rs.getString(1), rs.getString(2), rs.getString(3));
                
                if (!rs.getString(3).equals(null)) 
                {
                	currencies.add(bd);
                }
            }
            
            prepStmt.close();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        
        releaseConnection();
        Collections.sort(currencies);
        
        return currencies;
    }
    
    public ArrayList<String> getDBKnownCurrencies() throws Exception {
    	ArrayList <String> currencies = new ArrayList<String>();
        
        try {
            String selectStatement = "select * from currency_codes";
            getConnection();
         
            PreparedStatement prepStmt = con.prepareStatement(selectStatement);;
            ResultSet rs = prepStmt.executeQuery();
            
            while (rs.next()) {
                String cd = rs.getString(2);
                
                if (!rs.getString(2).equals(null)) 
                {
                	currencies.add(cd);
                }
            }
            
            prepStmt.close();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        
        releaseConnection();
        Collections.sort(currencies);
        
        return currencies;
    }
    
    public boolean updateDBKnownCurrencies(String date) throws Exception {
    	ArrayList <String> currencies = new ArrayList<String>();
    	fetchData r = new fetchData();
    	currencies = r.getSupportedCurrencies(date);

    	int i = 1;
    	
    	try {
    		String insertStatement = "delete from currency_codes";
            getConnection();
                      
            PreparedStatement prepStmt = con.prepareStatement(insertStatement);                      
            prepStmt.executeUpdate();
            
            prepStmt.close();
         
        } catch (SQLException ex) {
            return false;
        }
        
        releaseConnection();
    	
    	
    	for(String s: currencies)
    	{
    	try {
    		String insertStatement = "insert into currency_codes values (?,?)";
            getConnection();
                      
            PreparedStatement prepStmt = con.prepareStatement(insertStatement);
            prepStmt.setInt(1, i);
            prepStmt.setString(2, s);
                        
            prepStmt.executeUpdate();
            
            prepStmt.close();
            i++;
        } catch (SQLException ex) {
            return false;
        }
        
        releaseConnection();
    	}
		return true;

    }
}
