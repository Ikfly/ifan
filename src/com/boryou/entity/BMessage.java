package com.boryou.entity;

import java.util.Date;

/**
 * BMessage entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class BMessage implements java.io.Serializable {

	// Fields

	private long messageId;
	private long senderId;
	private String senderName;
	private long receiverId;
	private String message;
	private Date sendTime;
	private int isRead;

	// Constructors

	/** default constructor */
	public BMessage() {
	}

	/** full constructor */
	public BMessage(long senderId, String senderName, long receiverId,
			String message, Date sendTime, int isRead) {
		this.senderId = senderId;
		this.senderName = senderName;
		this.receiverId = receiverId;
		this.message = message;
		this.sendTime = sendTime;
		this.isRead = isRead;
	}

	// Property accessors

	public long getMessageId() {
		return this.messageId;
	}

	public void setMessageId(long messageId) {
		this.messageId = messageId;
	}

	public long getSenderId() {
		return this.senderId;
	}

	public void setSenderId(long senderId) {
		this.senderId = senderId;
	}

	public String getSenderName() {
		return this.senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public long getReceiverId() {
		return this.receiverId;
	}

	public void setReceiverId(long receiverId) {
		this.receiverId = receiverId;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getSendTime() {
		return this.sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public int getIsRead() {
		return this.isRead;
	}

	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}

}