package com.boryou.entity;

import java.util.Date;

/**
 * BLog entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class BLog implements java.io.Serializable {

	// Fields

	private long logId;
	private Date createTime;
	private long userId;
	private String ip;

	// Constructors

	/** default constructor */
	public BLog() {
	}

	/** full constructor */
	public BLog(Date createTime, long userId,String ip) {
		this.createTime = createTime;
		this.userId = userId;
		this.ip=ip;
	}

	// Property accessors

	public long getLogId() {
		return this.logId;
	}

	public void setLogId(long logId) {
		this.logId = logId;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

}