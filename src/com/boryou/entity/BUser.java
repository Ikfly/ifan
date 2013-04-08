package com.boryou.entity;

/**
 * BUser entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class BUser implements java.io.Serializable {

	// Fields

	private long userId;
	private String userName;
	private String userPs;
	private String userEmail;
	private String telephone;
	private Integer modifyAuthority;
	private Integer canlog;
	private Integer groupId;
	private Integer typeId;

	// Constructors

	/** default constructor */
	public BUser() {
	}

	/** minimal constructor */
	public BUser(String userName, String userPs, Integer modifyAuthority,
			Integer canlog) {
		this.userName = userName;
		this.userPs = userPs;
		this.modifyAuthority = modifyAuthority;
		this.canlog = canlog;
	}

	/** full constructor */
	public BUser(String userName, String userPs, String userEmail,
			String telephone, Integer modifyAuthority, Integer canlog,
			Integer groupId, Integer typeId) {
		this.userName = userName;
		this.userPs = userPs;
		this.userEmail = userEmail;
		this.telephone = telephone;
		this.modifyAuthority = modifyAuthority;
		this.canlog = canlog;
		this.groupId = groupId;
		this.typeId = typeId;
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

	public String getUserPs() {
		return this.userPs;
	}

	public void setUserPs(String userPs) {
		this.userPs = userPs;
	}

	public String getUserEmail() {
		return this.userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getTelephone() {
		return this.telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Integer getModifyAuthority() {
		return this.modifyAuthority;
	}

	public void setModifyAuthority(Integer modifyAuthority) {
		this.modifyAuthority = modifyAuthority;
	}

	public Integer getCanlog() {
		return this.canlog;
	}

	public void setCanlog(Integer canlog) {
		this.canlog = canlog;
	}

	public Integer getGroupId() {
		return this.groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public Integer getTypeId() {
		return this.typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

}