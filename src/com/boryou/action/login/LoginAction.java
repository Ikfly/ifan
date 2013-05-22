package com.boryou.action.login;


import com.boryou.action.AbstractAction;
import com.boryou.dao.BOrderUserDao;
import com.boryou.entity.BOrderUser;
import com.boryou.util.Constant4Web;

public class LoginAction extends AbstractAction{
	
	private BOrderUserDao userDao=new BOrderUserDao();
	
	public String login(){
		String userName=(String)request.getParameter("user.userName");
		String password=(String)request.getParameter("user.userPassword");
        Object result=userDao.checkLogin(userName, password);
        if(result instanceof Integer){
        	int mes=(Integer)result;
        	if(mes==0){
        		request.setAttribute("message", "用户不存在");
        	}else{
        		request.setAttribute("message", "密码错误");
        	}
        	return "login";
        }else{
        	BOrderUser user=(BOrderUser)result;
        	String loginIp="";
        	loginIp = request.getHeader("x-forwarded-for") == null ? request.getRemoteAddr() : request.getHeader("x-forwarded-for");
        	userDao.saveRecentIp(loginIp, user.getUserId());
        	request.getSession().setAttribute(Constant4Web.USER, user);
        	return notice();
        }
	}
	
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
