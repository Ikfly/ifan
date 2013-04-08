package com.boryou.action;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.util.ServletContextAware;

import com.opensymphony.xwork2.ActionSupport;

public class AbstractAction extends ActionSupport implements ServletRequestAware,ServletResponseAware,ServletContextAware{
	
	protected HttpServletRequest request;
	
	protected HttpServletResponse response;
	
	private ServletContext servletContext;
	
	private Map session;

	public void setServletRequest(HttpServletRequest req) {
		// TODO Auto-generated method stub
		this.request = req;
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void setServletResponse(HttpServletResponse resp) {
		// TODO Auto-generated method stub
		this.response = resp;
		response.setContentType("text/html; charset=UTF-8");
	}

	public void setServletContext(ServletContext sc) {
		// TODO Auto-generated method stub
		this.servletContext = sc;
	}
	
	public void setSession(Map session){
	    this.session = session;	
	}
	

}
