package com.boryou.dao;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.boryou.entity.BOrderUser;
import com.boryou.util.MD5Util;


public class BOrderUserDao {
	
	BaseHibernateDAO baseDao=new BaseHibernateDAO();
	
	public BOrderUser get(long userId) {
		return (BOrderUser)baseDao.load(userId,BOrderUser.class);
	}
	
	
	public long add(BOrderUser user){
		user.setUserPassword(MD5Util.MD5(user.getUserPassword()));
		return (Long)baseDao.save(user);
	}
	
	public List<BOrderUser> searchUserByUserName(String userName){
		String hql4name="FROM BOrderUser WHERE userName='"+userName+"'";
		return (List<BOrderUser>)baseDao.searchByHql(hql4name, null);
	}
	
	public List<BOrderUser> searchUserByEmail(String userEmail){
		String hql4name="FROM BOrderUser WHERE email='"+userEmail+"'";
		return (List<BOrderUser>)baseDao.searchByHql(hql4name, null);
	}
	

	
	/*
	@Deprecated
	public Object checkLogin(String userName,String userPassword){
		List<BOrderUser> users=this.searchUserByUserName(userName);
		if(users!=null&&users.size()>0){
			if(users.get(0).getUserPassword().equalsIgnoreCase(userPassword)){
				return users.get(0);
			}else{
				return -1;
			}
		}else{
		    List list=this.searchBoryouUser(userName);
		    if(list!=null&&list.size()>0){
		     	List boryouUser=this.searchBoryouUser(userName, userPassword);
			    if(boryouUser!=null&&boryouUser.size()>0){
			     	return boryouUser.get(0);
			    }else{
				    return -1;
			    }
		    }else{
		    	return 0;
		    }
		}
	}
	*/
	
	/**
	 * 
	 */
	public Object checkLogin(String userName,String userPassword){
		List<BOrderUser> users=this.searchUserByUserName(userName);
		if(users!=null&&users.size()>0){
			String strMD5 = MD5Util.MD5(userPassword);
			if(users.get(0).getUserPassword().equals(strMD5)){
				return users.get(0);
			}else{
				return -1;
			}
		}else{
			return 0;
		}
	}
	
	
	public List<BOrderUser> searchUserByIp(String ip){
		String hql="FROM BOrderUser WHERE registIp='"+ip+"'";
		return (List<BOrderUser>)baseDao.searchByHql(hql, null);
	}
	
	
	public boolean isUserNameExists(String userName){
		boolean isExists = false;
		String hql = "SELECT COUNT(*) FROM BOrderUser WHERE userName = '"+userName+"'";
		List<Long> list = baseDao.searchByHql(hql, null);
		if (list != null && list.size() > 0) {
			long count = list.get(0);
			if (count > 0) {
				isExists = true;
			}
		}
		return isExists;
	}
	
	public boolean isEmailExists(String userEmail){
		boolean isExists = false;
		String hql = "SELECT COUNT(*) FROM BOrderUser WHERE email = '"+userEmail+"'";
		List<Long> list = baseDao.searchByHql(hql, null);
		if (list != null && list.size() > 0) {
			long count = list.get(0);
			if (count > 0) {
				isExists = true;
			}
		}
		return isExists;
	}
	
	public boolean isUserEmailExists(String email){
		boolean isExists = false;
		String hql = "SELECT COUNT(*) FROM BOrderUser WHERE email = '"+email+"'";
		List<Integer> list = baseDao.searchByHql(hql, null);
		if (list != null && list.size() > 0) {
			int count = list.get(0);
			if (count > 0) {
				isExists = true;
			}
		}
		return isExists;
	}
	
	public long regist(String userName,String userPassword,String userRealName,String email){
		BOrderUser user=new BOrderUser();
		user.setUserName(userName);
		user.setUserPassword(userPassword);
		user.setUserRealName(userRealName);
		user.setEmail(email);
		return this.add(user);
	}
	
	public boolean checkOldPwd(String userName,String oldPwd){
		String str = MD5Util.MD5(oldPwd);
		String hql = "FROM BOrderUser WHERE userName = '"+userName+"' AND userPassword='"+str+"'";
		List list=baseDao.searchByHql(hql,null);
		if(list!=null&&list.size()>0){
			return true;
		}else{
			return false;
		}
	}
	
	public void saveRecentIp(String loginIp,long userId){
		BOrderUser user=this.get(userId);
		user.setLoginIp(loginIp);
		baseDao.update(user);
	}
	
	public int update(BOrderUser user,String newPwd){
		user.setUserPassword(MD5Util.MD5(newPwd));
		baseDao.update(user);
		return 1;
	}
	
	public int updateEmail(BOrderUser user,String email){
		user.setEmail(email);
		baseDao.update(user);
		return 1;
	}
	
	public void emailStaff(BOrderUser user,String tempPwd){
		user.setUserPassword(MD5Util.MD5(tempPwd));
		user.setRecentEmail(new Date());
		baseDao.update(user);
	}
	
	public void accessUser(BOrderUser user,int typeId){
		    user.setTypeId(typeId);
			baseDao.update(user);
	}
	
	public static void main(String[] args) {
		BOrderUserDao dao=new BOrderUserDao();
		//dao.regist("test", "123", "admin", "1@qq.com");
		//System.out.println(dao.checkLogin("test", "123"));
//		if(dao.isUserNameExists("test")){
//			System.out.println("exist");
//		}
		if(dao.isUserNameExists("liuhang")){
			System.out.println("exist");
		}else{
			System.out.println("not");
		}
		
	}
	
	
	
	

}
