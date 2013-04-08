package com.boryou.entity;

import java.util.Date;

/**
 * BOrderUser entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class BOrderUser implements java.io.Serializable {

	// Fields

	private long userId;
	private String userName;
	private String userPassword;
	private String userRealName;
	private String email;
	private String registIp;
	private String loginIp;
	private int typeId;
	private Date recentEmail;

	// Constructors

	/** default constructor */
	public BOrderUser() {
	}

	/** minimal constructor */
	public BOrderUser(String userName, String userPassword,
			String userRealName, String registIp, int typeId) {
		this.userName = userName;
		this.userPassword = userPassword;
		this.userRealName = userRealName;
		this.registIp = registIp;
		this.typeId = typeId;
	}

	/** full constructor */
	public BOrderUser(String userName, String userPassword,
			String userRealName, String email, String registIp, String loginIp,
			int typeId, Date recentEmail) {
		this.userName = userName;
		this.userPassword = userPassword;
		this.userRealName = userRealName;
		this.email = email;
		this.registIp = registIp;
		this.loginIp = loginIp;
		this.typeId = typeId;
		this.recentEmail = recentEmail;
	}

	// Property accessors

	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return this.userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserRealName() {
		return this.userRealName;
	}

	public void setUserRealName(String userRealName) {
		this.userRealName = userRealName;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRegistIp() {
		return this.registIp;
	}

	public void setRegistIp(String registIp) {
		this.registIp = registIp;
	}

	public String getLoginIp() {
		return this.loginIp;
	}

	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	public int getTypeId() {
		return this.typeId;
	}

	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	public Date getRecentEmail() {
		return this.recentEmail;
	}

	public void setRecentEmail(Date recentEmail) {
		this.recentEmail = recentEmail;
	}

}