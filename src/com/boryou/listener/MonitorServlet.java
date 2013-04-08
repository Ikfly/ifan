package com.boryou.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.boryou.util.Constant4Web;

public class MonitorServlet implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		
	}

	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		//检查
		try {
			checkSystemSet();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//菜单线程
//		OrderListThread orderlistThread = OrderListThread.getInstance();
//		orderlistThread.start();
		
	}
	
	private void checkSystemSet() throws Exception{
		if(Constant4Web.open().getTime() >= Constant4Web.noon().getTime() ||
				Constant4Web.noon().getTime() >= Constant4Web.checkour().getTime() || 
				Constant4Web.checkour().getTime() >= Constant4Web.dinner().getTime() ||
				Constant4Web.dinner().getTime() >= Constant4Web.shutdown().getTime()){
			throw new Exception("订餐系统时间设置有误，请检查!");
		}
	}

}
