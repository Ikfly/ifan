package com.boryou.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


import org.hibernate.Query;
import org.hibernate.Session;

import com.boryou.HibernateSessionFactory;
import com.boryou.dao.BaseHibernateDAO;
import com.boryou.entity.BOrder;
import com.boryou.util.Constant4Web;

public class BOrderDao {
	
	BaseHibernateDAO baseDao=new BaseHibernateDAO();
	static long oneDayTimeInMills=24*60*60*1000;
	public BOrder get(long orderId) {
		return (BOrder)baseDao.load(orderId,BOrder.class);
	}
	
	public long add(BOrder order){
		return (Long)baseDao.save(order);
	}
	
	
	private Date init(){
		Calendar init=Calendar.getInstance();
		init.clear();
		return init.getTime();
	}
	
	private Date yestoday(){
		Calendar yestoday = Calendar.getInstance();
		yestoday.add(Calendar.DAY_OF_YEAR, -1);
		yestoday.set(Calendar.HOUR_OF_DAY, 23);
		yestoday.set(Calendar.MINUTE, 59);
		yestoday.set(Calendar.SECOND,59);
		return yestoday.getTime();
	}
	
	/**
	 * 查询当日所在时间段订单
	 * @return
	 */
	public List<BOrder> searchTodaysOrder(){
		String hql="FROM BOrder WHERE orderTime BETWEEN ? AND ? ORDER BY orderTime ASC ";
		long now = new Date().getTime();
		if(now < Constant4Web.checkour().getTime()){
			Date[] mtime={Constant4Web.open(),Constant4Web.noon()};
			return (List<BOrder>)baseDao.searchByHql(hql,mtime);
		}else{
			Date[] atime={Constant4Web.dinner(),Constant4Web.shutdown()};
			return (List<BOrder>)baseDao.searchByHql(hql,atime);
		}
	}
	
	
	
	public boolean ordered(long userId){
		String hql="FROM BOrder WHERE userId = "+userId+" AND orderTime BETWEEN ? AND ?";
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
		if(list!=null && list.size()>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 取消订单
	 * @param orderId
	 */
	public void cancelOrder(long orderId){
		if(get(orderId)!=null){
			baseDao.delete(get(orderId));
		}
	}
	
	/**
	 * 批量删除订单
	 * @param strIds
	 */
	public boolean deleteOrder(String[] strIds){
		if(strIds == null || strIds.length == 0) return false;
		StringBuffer sb = new StringBuffer();
		for(String strId : strIds){
			sb.append(strId);
			sb.append(",");
		}
		sb = new StringBuffer(sb.substring(0, sb.lastIndexOf(",")));
		baseDao.deleteMany("b_order", "order_id",sb.toString());
		return true;
	}
	
	/**
	 * 结算
	 * @param orderId
	 */
	public void checkOrder(long orderId){
		BOrder order=this.get(orderId);
		order.setChecked(1);
		baseDao.update(order);
	}
	
	public void updateOrder(BOrder order){
		baseDao.update(order);
	}
	
	public List<BOrder> listOrderRecord(int startPage,int pageSize){
		String hql="FROM BOrder ORDER BY orderTime DESC";
		Session session=HibernateSessionFactory.getSession();
		Query query=session.createQuery(hql);
		query.setFirstResult((startPage-1)*pageSize);
		query.setMaxResults(pageSize);
		List<BOrder> list=query.list();
		if(session.isOpen()){
			session.close();
		}
		return list;
	}
	
	private Date historyStart(int days){
		Calendar start=Calendar.getInstance();
		start.add(Calendar.DAY_OF_YEAR,-days);
		start.set(Calendar.HOUR_OF_DAY, 0);
		start.set(Calendar.MINUTE, 0);
		start.set(Calendar.SECOND, 0);
		return start.getTime();
	}
	
	private Date historyEnd(int days){
		Calendar end=Calendar.getInstance();
		end.add(Calendar.DAY_OF_YEAR,-days+1);
		end.set(Calendar.HOUR_OF_DAY, 0);
		end.set(Calendar.MINUTE, 0);
		end.set(Calendar.SECOND, 0);
		return end.getTime();
	}
	
	public List<BOrder> listOrderRecordByDay(int days){
		Date[] time={this.historyStart(days),this.historyEnd(days)};
		String hql="FROM BOrder WHERE orderTime BETWEEN ? AND ? ORDER BY orderTime ASC";
		return (List<BOrder>)baseDao.searchByHql(hql, time);
	}
	
	/**
	 * 统计总订单数目
	 * @return
	 */
	public long countTotalOrder(){
		String hql="SELECT COUNT (*) FROM BOrder WHERE orderTime BETWEEN ? AND ?";
		Date[] time={init(),yestoday()};
		List<Long> list=baseDao.searchByHql(hql, time);
		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return 0;
	}
	
	/**
	 * 统计一天订单数目
	 * @return
	 */
	public long countTotalDay(){
	    String hql="SELECT orderTime FROM BOrder ORDER By orderTime ASC";
	    List<Date> list=baseDao.searchByHql(hql, null);
	    Date start=list.get(0);
	    Date end=list.get(list.size()-1);
	    long temp=(end.getTime()-start.getTime())/(1000*60*60*24);
	    return temp;
	}
	
	public long countQueryOrders(Date[] time,String userRealName,String strChecked){
		String hql = "FROM BOrder WHERE orderTime BETWEEN ? AND ? ";
		if(userRealName != null && !userRealName.equalsIgnoreCase("")){
			hql +=" AND realUsername LIKE '%" + userRealName + "%'";
		}
		if(strChecked != null && !strChecked.equalsIgnoreCase("-1")){
			try{
				int checked = Integer.parseInt(strChecked);
				hql += " AND checked = " + checked;
			}catch(NumberFormatException e){
				e.printStackTrace();
			}
		}
		return baseDao.searchByHql(hql, time).size();
	}
	
	public List<BOrder> queryOrders(Date[] time,String userRealName,String strChecked){
		String hql = "FROM BOrder WHERE orderTime BETWEEN ? AND ? ";
		if(userRealName != null && !userRealName.equalsIgnoreCase("")){
			hql +=" AND realUsername LIKE '%" + userRealName + "%'";
		}
		if(strChecked != null && !strChecked.equalsIgnoreCase("-1")){
			try{
				int checked = Integer.parseInt(strChecked);
				hql += " AND checked = " + checked;
			}catch(NumberFormatException e){
				e.printStackTrace();
			}
		}
		return (List<BOrder>)baseDao.searchByHql(hql, time);
	}
	
	public Object[] queryOrders(Date[] time,String userRealName,String strChecked,int startPage,int pageSize){
		String hql = "FROM BOrder WHERE orderTime BETWEEN ? AND ? ";
		if(userRealName != null && !userRealName.equalsIgnoreCase("")){
			hql +=" AND realUsername LIKE '%" + userRealName.trim() + "%'";
		}
		if(strChecked != null && !strChecked.equalsIgnoreCase("-1")){
			try{
				int checked = Integer.parseInt(strChecked);
				hql += " AND checked = " + checked;
			}catch(NumberFormatException e){
				e.printStackTrace();
			}
		}
		return baseDao.searchByHqlLimit(hql, time,startPage,pageSize);
	}
	
}
