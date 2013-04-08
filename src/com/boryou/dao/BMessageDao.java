package com.boryou.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.boryou.HibernateSessionFactory;
import com.boryou.entity.BMessage;

public class BMessageDao {
	
	BaseHibernateDAO baseDao=new BaseHibernateDAO();
	
	
	public long add(BMessage mes){
		return (Long)baseDao.save(mes);
	}
	
	public Date start(){
		Calendar start=Calendar.getInstance();
		start.set(Calendar.HOUR_OF_DAY, 0);
		start.set(Calendar.MINUTE, 0);
		start.set(Calendar.SECOND,0);
		return start.getTime();
	}
	
	public Date validity(){
		Calendar validity=Calendar.getInstance();
		validity.add(Calendar.DATE,-10);
		validity.set(Calendar.HOUR_OF_DAY, 0);
		validity.set(Calendar.MINUTE, 0);
		validity.set(Calendar.SECOND, 0);
		return  validity.getTime();
	}
				
	public Date now(){
		return new Date();
	}
	
	public List<BMessage> fetchNewMes(long receiverId,long senderId){
		String hql="FROM BMessage WHERE isRead=0  AND receiverId="+receiverId+" AND senderId="+senderId+" AND sendTime BETWEEN ? AND ? ORDER BY sendTime ASC";
		Date[] time={this.start(),this.now()};
		return (List<BMessage>)baseDao.searchByHql(hql, time);
	}
	
	public List<Long> fetchMesSender(long receiverId){
		String hql="SELECT DISTINCT senderId FROM BMessage WHERE receiverId="+receiverId+" AND isRead=0";
		return (List<Long>)baseDao.searchByHql(hql, null);
	}
	
	public void update(BMessage item){
		baseDao.update(item);
	}

	public List<Long> listSenders(long userId){
		String hql="SELECT DISTINCT senderId FROM BMessage WHERE receiverId="+userId;
		return (List<Long>)baseDao.searchByHql(hql, null);
	}
	
	public long countNewMessageNum(long senderId,long receiverId){
		String hql="SELECT COUNT(*) FROM BMessage WHERE senderId="+senderId+" AND isRead=0 AND receiverId="+receiverId;
	    List<Long> list=baseDao.searchByHql(hql, null);
	    if(list!=null&&list.size()>0){
	    	return list.get(0);
	    }
	    return 0;
	}
	
	public long countTotalMessageNum(long senderId,long receiverId){
		String hql="SELECT COUNT(*) FROM BMessage WHERE (senderId="+senderId+" AND receiverId="+receiverId+") OR (" +
				"senderId="+receiverId+" AND receiverId="+senderId+")";
	    List<Long> list=baseDao.searchByHql(hql, null);
	    if(list!=null&&list.size()>0){
	    	return list.get(0);
	    }
	    return 0;
	}
	
	
	
	public List<BMessage> listMessageRecord(long receiverId,long senderId,int startPage,int pageSize){
		//String hql="FROM BMessage WHERE isRead=0  AND receiverId="+receiverId+" AND senderId="+senderId+" ORDER BY sendTime ASC";
		String hql="FROM BMessage WHERE (receiverId="+receiverId+" AND senderId="+senderId+" ) OR (receiverId="+senderId+" AND senderId="+receiverId+") ORDER BY sendTime DESC";
		Session session=HibernateSessionFactory.getSession();
		Query query=session.createQuery(hql);
		query.setFirstResult((startPage-1)*pageSize);
		query.setMaxResults(pageSize);
		List<BMessage> list=query.list();
		for(BMessage message:list){
			if(message.getReceiverId()==receiverId){
				message.setIsRead(1);
				this.update(message);
			}
		}
		if(session.isOpen()){
			session.close();
		}
		return list;
	}
	
	
	
	public static void main(String[] args) {
		BMessageDao dao=new BMessageDao();
//		BMessage mes=new BMessage();
//		mes.setSender(122L);
//		mes.setReceiver(122L);
//		mes.setSendTime(new Date());
//		mes.setMessage("ww");
//		mes.setIsRead(0);
//		dao.add(mes);
//		dao.fetchNewMes(42L,60L);
		//System.out.println(dao.validity());
		dao.listMessageRecord(42L,60,1,40);
	}
	
	
	
	

}
