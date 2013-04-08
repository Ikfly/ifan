package com.boryou.action.email;

import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import com.boryou.action.AbstractAction;
import com.boryou.dao.BOrderUserDao;
import com.boryou.entity.BOrderUser;

public class EmailAction extends AbstractAction {
	
	private BOrderUserDao dao = new BOrderUserDao();
	private final long rest = 5*60*1000L;
	
	public String email(){
		String userEmail = request.getParameter("userEmail");
		BOrderUser user =null;
		try{
		    user = dao.searchUserByEmail(userEmail).get(0);
		}catch(Exception er){ 
			return "login";
		}
		if(user.getRecentEmail() != null ){
			long time = new Date().getTime()- user.getRecentEmail().getTime();
			if(time < rest){
				request.setAttribute("message", "您发送邮件过于频繁，请5分钟后再试！");
				 return "login";
		    }
		}
		String ip = request.getHeader("x-forwarded-for") == null ? request.getRemoteAddr() : request.getHeader("x-forwarded-for");
		user.setLoginIp(ip);
		String tempPwd = String.valueOf(UUID.randomUUID()).substring(0,6);
		try{
			JavaMail.sendEmail(user,tempPwd);
			dao.emailStaff(user,tempPwd);
			request.setAttribute("message", "邮件发送成功，请到邮箱查收。");
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				request.setAttribute("message", "邮件发送失败，请稍后重试。");
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
			    request.setAttribute("message", "邮件发送失败，请稍后重试。");
		    }catch(Exception e2){
			    request.setAttribute("message", "重置密码错误，请重试");
			}
		return "login";
	}

}
