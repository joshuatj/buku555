package buku.entities;

// Generated Mar 22, 2014 2:39:02 AM by Hibernate Tools 4.0.0

import java.util.HashSet;
import java.util.Set;

/**
 * User generated by hbm2java
 */
public class User implements java.io.Serializable {

	private Integer id;
	private String fbUserId;
	private String email;
	private String password;
	private boolean receiveNotiMail;
	private boolean isRegistered;
	private Set bills = new HashSet(0);
	private Set loanMoneysForOwnerUserId = new HashSet(0);
	private Set loanMoneysForLoanUserId = new HashSet(0);
	private Set billSpliteeses = new HashSet(0);
	private Set transactionsForFromUserId = new HashSet(0);
	private Set loanItemsForOwnerUserId = new HashSet(0);
	private Set transactionsForToUserId = new HashSet(0);
	private Set loanItemsForLoanUserId = new HashSet(0);

	public User() {
	}

	public User(String fbUserId, boolean isRegistered) {
		this.fbUserId = fbUserId;
		this.isRegistered = isRegistered;
	}

	public User(String fbUserId, String email, String password, boolean receiveNotiMail,
			boolean isRegistered, Set bills, Set loanMoneysForOwnerUserId,
			Set loanMoneysForLoanUserId, Set billSpliteeses,
			Set transactionsForFromUserId, Set loanItemsForOwnerUserId,
			Set transactionsForToUserId, Set loanItemsForLoanUserId) {
		this.fbUserId = fbUserId;
		this.email = email;
		this.password = password;
		this.isRegistered = isRegistered;
		this.receiveNotiMail = receiveNotiMail;
		this.bills = bills;
		this.loanMoneysForOwnerUserId = loanMoneysForOwnerUserId;
		this.loanMoneysForLoanUserId = loanMoneysForLoanUserId;
		this.billSpliteeses = billSpliteeses;
		this.transactionsForFromUserId = transactionsForFromUserId;
		this.loanItemsForOwnerUserId = loanItemsForOwnerUserId;
		this.transactionsForToUserId = transactionsForToUserId;
		this.loanItemsForLoanUserId = loanItemsForLoanUserId;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFbUserId() {
		return this.fbUserId;
	}

	public void setFbUserId(String fbUserId) {
		this.fbUserId = fbUserId;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
	public boolean isReceiveNotiMail() {
		return receiveNotiMail;
	}

	public void setReceiveNotiMail(boolean receiveNotiMail) {
		this.receiveNotiMail = receiveNotiMail;
	}

	public boolean isIsRegistered() {
		return this.isRegistered;
	}

	public void setIsRegistered(boolean isRegistered) {
		this.isRegistered = isRegistered;
	}

	public Set getBills() {
		return this.bills;
	}

	public void setBills(Set bills) {
		this.bills = bills;
	}

	public Set getLoanMoneysForOwnerUserId() {
		return this.loanMoneysForOwnerUserId;
	}

	public void setLoanMoneysForOwnerUserId(Set loanMoneysForOwnerUserId) {
		this.loanMoneysForOwnerUserId = loanMoneysForOwnerUserId;
	}

	public Set getLoanMoneysForLoanUserId() {
		return this.loanMoneysForLoanUserId;
	}

	public void setLoanMoneysForLoanUserId(Set loanMoneysForLoanUserId) {
		this.loanMoneysForLoanUserId = loanMoneysForLoanUserId;
	}

	public Set getBillSpliteeses() {
		return this.billSpliteeses;
	}

	public void setBillSpliteeses(Set billSpliteeses) {
		this.billSpliteeses = billSpliteeses;
	}

	public Set getTransactionsForFromUserId() {
		return this.transactionsForFromUserId;
	}

	public void setTransactionsForFromUserId(Set transactionsForFromUserId) {
		this.transactionsForFromUserId = transactionsForFromUserId;
	}

	public Set getLoanItemsForOwnerUserId() {
		return this.loanItemsForOwnerUserId;
	}

	public void setLoanItemsForOwnerUserId(Set loanItemsForOwnerUserId) {
		this.loanItemsForOwnerUserId = loanItemsForOwnerUserId;
	}

	public Set getTransactionsForToUserId() {
		return this.transactionsForToUserId;
	}

	public void setTransactionsForToUserId(Set transactionsForToUserId) {
		this.transactionsForToUserId = transactionsForToUserId;
	}

	public Set getLoanItemsForLoanUserId() {
		return this.loanItemsForLoanUserId;
	}

	public void setLoanItemsForLoanUserId(Set loanItemsForLoanUserId) {
		this.loanItemsForLoanUserId = loanItemsForLoanUserId;
	}

}
