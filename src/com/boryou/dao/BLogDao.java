package com.boryou.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.boryou.entity.BLog;
import com.boryou.util.Constant4Web;


public class BLogDao {
	BaseHibernateDAO baseDao=new BaseHibernateDAO();
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public int submitOrder(long userId,String ip){
		//不到点不能提交
//		long now = new Date().getTime();
//		if(now < Constant4Web.lunch().getTime() ||(now > Constant4Web.noon().getTime() && now < Constant4Web.dinner().getTime())){
//			return -1;
//		}
		if(submited()){
			return 0;
		}else{
			BLog log=new BLog();
			log.setCreateTime(new Date());
			log.setUserId(userId);
			log.setIp(ip);
			baseDao.save(log);
			return 1;
		}
	}
	
	public boolean submited(){
		String hql="FROM BLog WHERE createTime BETWEEN ? AND ?";
		List list = new ArrayList();
		long now = new Date().getTime();
		if(now >= Constant4Web.open().getTime() && now < Constant4Web.noon().getTime()){
			Date[] mtime =  {Constant4Web.open(),Constant4Web.noon()};
			list = baseDao.searchByHql(hql,mtime);
		}else if(now >= Constant4Web.dinner().getTime() && now < Constant4Web.shutdown().getTime()){
			Date[] atime =  {Constant4Web.dinner(),Constant4Web.shutdown()};
			list = baseDao.searchByHql(hql,atime);
		}else{
			return true;
		}
		if(list.size()>0){
			return true;
		}else{
			return false;
		}
	}
	
}
