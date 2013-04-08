package com.boryou.action.online;

import java.util.ArrayList;
import java.util.List;

import com.boryou.action.AbstractAction;
import com.boryou.dao.BMessageDao;
import com.boryou.dao.BOrderUserDao;
import com.boryou.entity.BMessageBox;
import com.boryou.entity.BOrderUser;
import com.boryou.util.Constant4Web;

public class MessageAction extends AbstractAction {
	
	private BMessageDao dao=new BMessageDao();
    private BOrderUserDao userDao=new BOrderUserDao();
	
    /**
     * 消息盒子界面
     * @return
     */
	public String messageBox(){
		BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		List<Long> senders=dao.listSenders(user.getUserId());
		List<BMessageBox> boxs=new ArrayList<BMessageBox>();
		for(long sender:senders){
			BMessageBox box = new BMessageBox();
			BOrderUser temp = userDao.get(sender);
			box.setSenderId(sender);
			box.setSenderName(temp.getUserRealName());
			box.setSenderUserName(temp.getUserName());
			box.setUnReadNum(dao.countNewMessageNum(sender,user.getUserId()));
			boxs.add(box);
		}
		request.setAttribute("result", boxs);
		return "message_box";
	}
	
	/**
	 * 消息详情
	 * @return
	 */
	public String messageDetail(){
		BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		  int nowPage=0;
		  int pageSize=10;
		  long senderId=0;
		  try{
			  senderId=Long.parseLong(request.getParameter("senderId"));
		  }catch(Exception er){
			  senderId=0;
		  }
		  try{
			 nowPage=Integer.parseInt(request.getParameter("nowPage"));
		    }catch(Exception E){
		     nowPage=1;
		 }
		    request.setAttribute("result", dao.listMessageRecord(user.getUserId(), senderId, nowPage, pageSize));
		    request.setAttribute("nowPage", nowPage);
		    request.setAttribute("totalNum",dao.countTotalMessageNum(senderId, user.getUserId()));
		    request.setAttribute("pageSize", pageSize);
		    request.setAttribute("senderId", senderId);
		   return "message_detail";
	}
	
	

}
