package com.boryou.action.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.boryou.action.AbstractAction;
import com.boryou.dao.BOrderUserDao;
import com.boryou.entity.BOrderUser;
import com.boryou.util.Constant4Web;

public class UserAction extends AbstractAction{
	
	private BOrderUserDao dao = new BOrderUserDao();
	
	/**
	 * 用户管理界面
	 * @return
	 */
	public String userManage(){
		BOrderUser user = (BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		request.setAttribute("oldEmail", dao.get(user.getUserId()).getEmail());
		return "user_manage";
	}
	
	/**
	 * 用户注册
	 * @return
	 */
	public String regist(){
		String userEmail=(String)request.getParameter("userEmail");
		if(userEmail == null || userEmail.equalsIgnoreCase("")) return "login";
		if(dao.isEmailExists(userEmail)){
			request.setAttribute("message", "请勿重复注册");
			return "login";
		}
		String userName=(String)request.getParameter("userName");
		String userPassword=(String)request.getParameter("userPassword");
		String userRealName=(String)request.getParameter("userRealName");
		
		BOrderUser user = new BOrderUser();
		user.setUserName(userName);
		user.setUserPassword(userPassword);
		user.setUserRealName(userRealName);
		user.setEmail(userEmail);
		String ip="0";
		ip = request.getHeader("x-forwarded-for") == null ? request.getRemoteAddr():request.getHeader("x-forwarded-for");
        user.setRegistIp(ip);
		user.setTypeId(3);
		try{
			dao.add(user);
			request.setAttribute("message", "注册成功！");
		}catch(Exception er){
			request.setAttribute("message", "注册失败，请稍后再试");
		}
		return "login";
	}
	
	/**
	 * 用户授权
	 * @return
	 */
	public String access(){
		String strAccessTypeId = (String)request.getParameter("accessTypeId");
		String userName = (String)request.getParameter("user4update");
		BOrderUser user = (BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		try{
			if(user == null) return "user_manage";;
			if(user.getTypeId() > 2){
				request.setAttribute("message", "您无权授权");
				return  "user_manage";
			}
			if(user.getUserName().equals(userName)){
				request.setAttribute("message", "您不能修改自己的授权");
				return  "user_manage";
			}
			List<BOrderUser> users = dao.searchUserByUserName(userName);
			if(users != null && users.size() > 0){
				BOrderUser target = users.get(0);
				if(user.getTypeId() > 1){
					if(target.getTypeId() <= user.getTypeId()){
						request.setAttribute("message", "没有足够权限修改此用户授权");
						return "user_manage";
					}
				}
				int accessTypeId = Integer.parseInt(strAccessTypeId);
				dao.accessUser(target,accessTypeId);
				request.setAttribute("message", "修改授权成功," + userName + "现在的授权值为：" + strAccessTypeId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "user_manage";
	}
	
	/**
	 * 验证修改密码时的老密码
	 */
	public void checkOldPwd(){
		String userName = (String)request.getParameter("userName");
		String oldPwd = (String)request.getParameter("oldPwd");
		PrintWriter out=null;
		try {
			out = response.getWriter();
			out.print(dao.checkOldPwd(userName,oldPwd));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 验证邮箱是否存在
	 */
	public void isExistEmail(){
		String userEmail=(String)request.getParameter("userEmail");
		PrintWriter out=null;
		try{
			out=response.getWriter();
			out.print(dao.isEmailExists(userEmail));
		}catch (Exception e) {
			// TODO: handle exception
		} finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 验证用户名是否存在
	 */
	public void isUserNameExist(){
		String userName=(String)request.getParameter("userName");
		PrintWriter out = null;
		try{
			out=response.getWriter();
			out.print(dao.isUserNameExists(userName));
		}catch (Exception e) {
			// TODO: handle exception
		} finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 修改邮箱
	 * @return
	 */
	public String updateEmail(){
		BOrderUser currentUser=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		String userName=(String)request.getParameter("userName");
		String newEmail=(String)request.getParameter("newEmail");
		if(userName!=null&&!userName.equals(currentUser.getUserName())){
			request.setAttribute("message","请您重新登录后再修改邮箱");
		}else{
			int i=dao.updateEmail(currentUser,newEmail);
			if(i==1){
				request.setAttribute("message","修改成功！");
			}else{
				request.setAttribute("message","修改失败,请重新登录后再试");
			}
		}
		return userManage();
	}
	
	public void updatePwd(){
		BOrderUser currentUser=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		String userName=(String)request.getParameter("userName");
		String newPwd=(String)request.getParameter("newPwd");
		PrintWriter out = null;
		try{
			out = response.getWriter();
			if(userName == null || !userName.equals(currentUser.getUserName())){
				out.print("false");
			}else{
				int i=dao.update(currentUser,newPwd);
				if(i==1){
					if(currentUser != null){
					    request.getSession().removeAttribute(Constant4Web.USER);
						request.getSession().invalidate();
					}
					out.print("true");
				}else{
					out.print("false");
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
		}finally{
			if(out != null)
				out.close();
		}
	}
	
	/**
	 * 注销
	 * @return
	 */
	public String logout(){
		BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		//用户下线
		if(user != null){
			request.getSession().removeAttribute(Constant4Web.USER);
			request.getSession().invalidate();
		}
		return "login";
	}
	
	

}
