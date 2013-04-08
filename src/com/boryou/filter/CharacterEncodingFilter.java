package com.boryou.filter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
public class CharacterEncodingFilter implements Filter {
	
	private FilterConfig filterConfig = null;
	private String encoding = null;

	public void destroy() {
		// TODO Auto-generated method stub
		this.filterConfig = null;
		this.encoding = null;
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest request=(HttpServletRequest)arg0;
		String methodName=request.getMethod();
		if(methodName.equalsIgnoreCase("post")){
			request.setCharacterEncoding("utf-8");
		}else{
			request = new MyRequestWrapper(request);
		}
		arg1.setContentType("text/html;charset=UTF-8");
		chain.doFilter(request, arg1);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.filterConfig = filterConfig;

		/* 获取字符编码 */
		this.encoding = filterConfig.getInitParameter("encoding");
		if (encoding == null || "".equals(encoding))
			encoding = "utf-8";
	}
	
	/**
	 * 内部类，继承自 HttpServletRequestWrapper 类
	 */
	public class MyRequestWrapper extends HttpServletRequestWrapper {
		HttpServletRequest request = (HttpServletRequest) super.getRequest();

		public MyRequestWrapper(HttpServletRequest request) {
			super(request);
		}

		@Override
		public String getParameter(String name) {
			String value = this.encode(request.getParameter(name));
			return value;
		}

		@Override
		public String[] getParameterValues(String name) {
			String[] values = request.getParameterValues(name);
			if (values != null) {
				for (int i = 0; i < values.length; i++) {
					values[i] = this.encode(values[i]);
				}
			}
			return values;
		}

		/**
		 * 字符编码处理
		 * @param value 编码前的字符串
		 * @return 编码后的字符串
		 */
		public String encode(String value) {
			if (value != null) {
				try {
					value = new String(value.getBytes("ISO-8859-1"),
							CharacterEncodingFilter.this.encoding);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
			return value;
		}
	}
}
