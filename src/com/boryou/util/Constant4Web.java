package com.boryou.util;

import java.util.Calendar;
import java.util.Date;

public class Constant4Web {
	
	//用户标示
    public final static String USER = "USER";
    
    public final static String QUERY_STARTTIME = "QUERY_STARTTIME";
    
    public final static String QUERY_ENDTIME = "QUERY_ENDTIME";
    
    public final static String QUERY_USERNAME = "QUERY_USERNAME";
    
    public final static String QUERY_SELECT = "QUERY_SELECT";
    //订餐功能开启时间
    public final static int OPEN = 7;
    public final static int OPENMINITE = 0;
	//中午自动提交时间
	public final static int NOON = 10;        //10点
	public final static int NOONMINITE = 30;  //30分
	
	//无午餐结算截止时间
	public final static int CHECKHOUR = 13;      
	public final static int CHECKMINITE = 30;     
	
	//允许每天下午最早订饭时间
	public final static int DINNERSTART = 15;  
	public final static int DINNERMINITE = 30; 
	
	//订餐功能关闭时间
	public final static int SHUTDOWN = 19;    
	public final static int SHUTDOWNMINITE = 30;  
	
	//菜单图片
	public final static String MENU_PATH = "conf/";
	public final static String MENU_NAME = "menu.jpg";
	
    public static Date getTime(int hour,int minite){
    	Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, hour);
		calendar.set(Calendar.MINUTE, minite);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
    }
	
	public static Date checkour(){
		return getTime(CHECKHOUR,CHECKMINITE);
	}
	
	public static Date dinner(){
		return getTime(DINNERSTART,DINNERMINITE);
	}
	
	public static Date noon(){
		return getTime(NOON,NOONMINITE);
	}
	
	public static Date shutdown(){
		return getTime(SHUTDOWN,SHUTDOWNMINITE);
	}
    
	public static Date open(){
		return getTime(OPEN,OPENMINITE);
	}
	
}
