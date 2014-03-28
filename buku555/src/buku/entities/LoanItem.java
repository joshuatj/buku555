package buku.entities;

// Generated Mar 22, 2014 2:39:02 AM by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * LoanItem generated by hbm2java
 */
public class LoanItem implements java.io.Serializable {

	private Integer id;
	private User userByLoanUserId;
	private User userByOwnerUserId;
	private ItemType itemType;
	private Date date;
	private String description;
	private String photo;
	private String establishmentPhoto;
	private String loanStatus;

	public LoanItem() {
	}

	public LoanItem(User userByLoanUserId, User userByOwnerUserId,
			ItemType itemType, Date date, String description, String photo,
			String establishmentPhoto, String loanStatus) {
		this.userByLoanUserId = userByLoanUserId;
		this.userByOwnerUserId = userByOwnerUserId;
		this.itemType = itemType;
		this.date = date;
		this.description = description;
		this.photo = photo;
		this.establishmentPhoto = establishmentPhoto;
		this.loanStatus = loanStatus;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUserByLoanUserId() {
		return this.userByLoanUserId;
	}

	public void setUserByLoanUserId(User userByLoanUserId) {
		this.userByLoanUserId = userByLoanUserId;
	}

	public User getUserByOwnerUserId() {
		return this.userByOwnerUserId;
	}

	public void setUserByOwnerUserId(User userByOwnerUserId) {
		this.userByOwnerUserId = userByOwnerUserId;
	}

	public ItemType getItemType() {
		return this.itemType;
	}

	public void setItemType(ItemType itemType) {
		this.itemType = itemType;
	}

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getEstablishmentPhoto() {
		return this.establishmentPhoto;
	}

	public void setEstablishmentPhoto(String establishmentPhoto) {
		this.establishmentPhoto = establishmentPhoto;
	}

	public String getLoanStatus() {
		return this.loanStatus;
	}

	public void setLoanStatus(String loanStatus) {
		this.loanStatus = loanStatus;
	}

}
