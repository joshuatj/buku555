package buku.entities;

// Generated Mar 22, 2014 2:39:02 AM by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Bill generated by hbm2java
 */
public class Bill implements java.io.Serializable {

	private Integer id;
	private User user;
	private Date date;
	private Double totalAmount;
	private String reason;
	private String photo;

	public Bill() {
	}

	public Bill(User user) {
		this.user = user;
	}

	public Bill(User user, Date date, Double totalAmount, String reason,
			String photo) {
		this.user = user;
		this.date = date;
		this.totalAmount = totalAmount;
		this.reason = reason;
		this.photo = photo;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Double getTotalAmount() {
		return this.totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

}
