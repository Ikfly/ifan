package com.boryou.entity;

import java.util.Date;

/**
 * BOrder entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class BOrder implements java.io.Serializable {

	// Fields

	private long orderId;
	private long userId;
	private String realUsername;
	private Date orderTime;
	private int extraNumber;
	private int checked;
	private String note;
	private String changeNote;


	public String getChangeNote() {
		return changeNote;
	}

	public void setChangeNote(String changeNote) {
		this.changeNote = changeNote;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	/** default constructor */
	public BOrder() {
	}

	/** full constructor */
	public BOrder(long userId, String realUsername, Date orderTime,
			int extraNumber, int checked,String note,String changeNote) {
		this.userId = userId;
		this.realUsername = realUsername;
		this.orderTime = orderTime;
		this.extraNumber = extraNumber;
		this.checked = checked;
		this.note=note;
		this.changeNote=changeNote;
	}

	public long getOrderId() {
		return orderId;
	}

	public void setOrderId(long orderId) {
		this.orderId = orderId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getRealUsername() {
		return realUsername;
	}

	public void setRealUsername(String realUsername) {
		this.realUsername = realUsername;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public int getExtraNumber() {
		return extraNumber;
	}

	public void setExtraNumber(int extraNumber) {
		this.extraNumber = extraNumber;
	}

	public int getChecked() {
		return checked;
	}

	public void setChecked(int checked) {
		this.checked = checked;
	}

	
}