package com.boryou.action.email;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.boryou.entity.BOrderUser;

public class JavaMail {
	public static void sendEmail(BOrderUser user,String tempPwd) throws AddressException, MessagingException{
		    String host = "smtp.ym.163.com";   //发件人使用发邮件的电子信箱服务器
			String from = "service1@boryou.com";    //发邮件的出发地（发件人的信箱）
			String to = user.getEmail();   //发邮件的目的地（收件人信箱）
			Properties props = System.getProperties(); // Setup mail server
			props.put("mail.smtp.host", host); // Get session
			props.put("mail.smtp.auth", "true"); //通过验证
		    MyAuthenticator myauth = new MyAuthenticator("service1@boryou.com","123456");
			Session session = Session.getDefaultInstance(props, myauth);
//			    session.setDebug(true);
			    // Define message
			MimeMessage message = new MimeMessage(session);
			    // Set the from address
			message.setFrom(new InternetAddress(from));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			    // Set the subject
		    message.setSubject("博约网上订餐系统密码找回");
			    // Set the content
		    message.setText("您好,"+user.getUserRealName()+" 您在订餐系统的用户名为:"+
			    	user.getUserName()+" ,您的临时密码是" + tempPwd + "\n请在下次登录后修改您的密码！\n" +
			    				"博约在线订餐系统");
			message.saveChanges();
			Transport.send(message);
	}
	 static class MyAuthenticator extends javax.mail.Authenticator {
	      private String strUser;
	      private String strPwd;
	      public MyAuthenticator(String user, String password) {
	        this.strUser = user;
	        this.strPwd = password;
	      }
	    protected PasswordAuthentication getPasswordAuthentication() {
	        return new PasswordAuthentication(strUser, strPwd);
	    }
	 }
}
