package buku.entities;

// Generated Mar 22, 2014 2:39:02 AM by Hibernate Tools 4.0.0

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Currency generated by hbm2java
 */
public class Currency implements java.io.Serializable {

	private Integer id;
	private String countryCurrencyCode;
	private Date date;
	private Integer value;
	private Set billSpliteeses = new HashSet(0);
	private Set transactions = new HashSet(0);

	public Currency() {
	}

	public Currency(String countryCurrencyCode, Date date, Integer value,
			Set billSpliteeses, Set transactions) {
		this.countryCurrencyCode = countryCurrencyCode;
		this.date = date;
		this.value = value;
		this.billSpliteeses = billSpliteeses;
		this.transactions = transactions;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCountryCurrencyCode() {
		return this.countryCurrencyCode;
	}

	public void setCountryCurrencyCode(String countryCurrencyCode) {
		this.countryCurrencyCode = countryCurrencyCode;
	}

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getValue() {
		return this.value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}

	public Set getBillSpliteeses() {
		return this.billSpliteeses;
	}

	public void setBillSpliteeses(Set billSpliteeses) {
		this.billSpliteeses = billSpliteeses;
	}

	public Set getTransactions() {
		return this.transactions;
	}

	public void setTransactions(Set transactions) {
		this.transactions = transactions;
	}

}
