package com.boryou.action.online;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import nl.justobjects.pushlet.core.Dispatcher;
import nl.justobjects.pushlet.core.Event;
import nl.justobjects.pushlet.core.Session;
import nl.justobjects.pushlet.core.SessionManager;

import com.boryou.action.AbstractAction;
import com.boryou.dao.BMessageDao;
import com.boryou.entity.BMessage;
import com.boryou.entity.BOrderUser;
import com.boryou.util.Constant4Web;

public class OnlineAction extends AbstractAction{

	private BMessageDao dao=new BMessageDao();
    private static SimpleDateFormat sf=new SimpleDateFormat("HH:mm:ss");
    
	/**
	 * 得到在线用户列表
	 */
	public void fetchOnline(){
		BOrderUser user = (BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		PrintWriter out = null;
		try{
			out = response.getWriter();
			out.println(generatorOnlineUsers(user));
		}catch(Exception er){
			
		}finally{
			out.flush();
			out.close();
		}
	}
	
	/**
	 * 在线用户格式
	 * @param user
	 * @return
	 */
	private String generatorOnlineUsers(BOrderUser user){
		StringBuffer json=new StringBuffer("[");
		boolean hasUser = false;
		Map map = SessionManager.getInstance().getSessions();
		for(Iterator it = map.entrySet().iterator();it.hasNext();){
			Entry entry=(Entry)it.next();
			if(((String)entry.getKey()).equals(user.getUserId()+"")){continue;}
				hasUser=true;
				Session session = (Session)entry.getValue();
					json.append("{id:'"+entry.getKey()+"',userName:'"+ session.getUserName()+"'},");
		}
		if(hasUser){
			json=new StringBuffer(json.substring(0, json.lastIndexOf(",")));
		}
		json.append("]");
		return json.toString();
	}
	
	
	/**
	 * 拉取发送给自己的消息
	 */
	public void deliver(){
		BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		long senderId=Long.parseLong(request.getParameter("senderId"));
		List<BMessage> newMessages = dao.fetchNewMes(user.getUserId(),senderId);
		PrintWriter out=null;
		try{
			out = response.getWriter();
			String result=generatorMessage(newMessages);
			out.print(result);
		}catch(Exception er){
			
		}finally{
			out.flush();
			out.close();
		}
	}
	/**
	 * 转换消息格式
	 * @param newMessages
	 * @return
	 */
	public String generatorMessage(List<BMessage> newMessages){
		if(newMessages!=null&&newMessages.size()>0){
			StringBuffer json=new StringBuffer("[");
			boolean hasMessage=false;
			for(BMessage item:newMessages){
				hasMessage=true;
				item.setIsRead(1);
				dao.update(item);
			    json.append("{senderName:'"+item.getSenderName()+"',time:'"+sf.format(item.getSendTime())+"',message:'"+item.getMessage()+"'},");	
			}
			if(hasMessage){
				json=new StringBuffer(json.substring(0, json.lastIndexOf(",")));
			}
			json.append("]");
			return json.toString();
		}
		return "";
	}
	
	public void sendMessage(){
		BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		String message=(String)request.getParameter("chatInput");
		long receiver =Long.parseLong(request.getParameter("receiver"));
		BMessage mes=new BMessage();
		mes.setSenderId(user.getUserId());
		mes.setSenderName(user.getUserRealName());
		mes.setIsRead(0);
		mes.setReceiverId(receiver);
		mes.setSendTime(new Date());
		mes.setMessage(message);
		dao.add(mes);
		String userRealName;
		try {
			userRealName = new String(user.getUserRealName().getBytes("UTF-8"),"ISO-8859-1");
			Event event = Event.createDataEvent("/message/"+receiver+"/"+user.getUserId()+"/"+userRealName);
			message = new String(message.getBytes("UTF-8"),"ISO-8859-1");
			event.setField("message", message);
			Dispatcher.getInstance().multicast(event);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		System.out.println(new Date()+" ("+System.currentTimeMillis()+") "+user.getUserRealName()+" 发送消息至 "+receiver+" :"+message);
	}
	
	
}
