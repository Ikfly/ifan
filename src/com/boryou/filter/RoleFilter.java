package com.boryou.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.boryou.entity.BOrderUser;
import com.boryou.util.Constant4Web;

public class RoleFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest request=(HttpServletRequest)arg0;
		String path = request.getServletPath();
		if(path.endsWith("/ifan")){
			System.out.println();
		}
		if(path.endsWith("login.jsp")||path.endsWith("forgetPwd.jsp")
				||path.endsWith("regist.jsp")
				||path.endsWith("/login.action")
				||path.endsWith("/isUserNameExist.action")
				||path.endsWith("/isExistEmail.action")
				||path.endsWith("/regist.action")
				||path.endsWith(".css") || path.endsWith(".js")||path.endsWith(".ico")
				||path.endsWith(".gif") || path.endsWith(".jpg")|| path.endsWith(".swf")){
			arg2.doFilter(arg0, arg1);
			return;
		}
		BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		if(user==null){
			PrintWriter out = arg1.getWriter();
			out.println("<script>"
					+ "window.top.location.href='" + request.getContextPath()
					+ "/boryou/login.jsp';</script>");
			out.flush();
			out.close();
			return;
		}
		arg2.doFilter(arg0, arg1);
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
