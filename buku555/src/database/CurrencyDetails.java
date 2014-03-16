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

public class CurrencyDetails implements Comparable {
    private String country_currency_code = null;
    private String date = null;
    private String value = null;

    public CurrencyDetails() {
    }

    public CurrencyDetails(String country_currency_code, String date, String rate) 
    {
        this.setCountry_currency_code(country_currency_code);
        this.setDate(date);
        this.setValue(rate);
    }

    public int compareTo(Object o) {
        CurrencyDetails n = (CurrencyDetails) o;
        int lastCmpC = country_currency_code.compareTo(n.country_currency_code);
        int lastCmpD = date.compareTo(n.date);
        
        if(lastCmpC == 0 && lastCmpD ==0)
        	return 0;
        
        return 1;
    }

	public String getCountry_currency_code() {
		return country_currency_code;
	}

	public void setCountry_currency_code(String country_currency_code) {
		this.country_currency_code = country_currency_code;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String rate) {
		this.value = rate;
	}
}
