package com.boryou.action.notice;

import com.boryou.action.AbstractAction;
import com.boryou.util.Constant4Web;

public class NoticeAction extends AbstractAction {
	
	public String notice(){
		request.setAttribute("open", Constant4Web.OPEN);
		request.setAttribute("open_minite", Constant4Web.OPENMINITE);
		request.setAttribute("noon", Constant4Web.NOON);
		request.setAttribute("noon_minite", Constant4Web.NOONMINITE);
		request.setAttribute("dinner", Constant4Web.DINNERSTART);
		request.setAttribute("dinner_minite", Constant4Web.DINNERMINITE);
		request.setAttribute("shutdown", Constant4Web.SHUTDOWN);
		request.setAttribute("shutdown_minite", Constant4Web.SHUTDOWNMINITE);
		return "notice";
	}

}
