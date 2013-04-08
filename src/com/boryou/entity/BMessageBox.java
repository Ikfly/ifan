package com.boryou.entity;

public class BMessageBox implements java.io.Serializable{
    
	public long senderId;
	public String senderName;
	public String senderUserName;
	public long unReadNum;
	public long getSenderId() {
		return senderId;
	}
	public void setSenderId(long senderId) {
		this.senderId = senderId;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public long getUnReadNum() {
		return unReadNum;
	}
	public void setUnReadNum(long unReadNum) {
		this.unReadNum = unReadNum;
	}
	public BMessageBox(){
	
	}
	
	public BMessageBox(long senderId, String senderName, long unReadNum) {
		super();
		this.senderId = senderId;
		this.senderName = senderName;
		this.unReadNum = unReadNum;
	}
	public String getSenderUserName() {
		return senderUserName;
	}
	public void setSenderUserName(String senderUserName) {
		this.senderUserName = senderUserName;
	}
	
	
}
