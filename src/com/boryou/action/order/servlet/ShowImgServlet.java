/**
*@author liuhang
*@date Dec 18, 2012
*/
package com.boryou.action.order.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.boryou.util.Constant4Web;


public class ShowImgServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		FileInputStream fis = null;
		OutputStream out = null;
		response.setContentType("image/jpg;charset=gbk");
		File file = new File(Constant4Web.MENU_PATH + Constant4Web.MENU_NAME);
		if(file != null){
			try {
				out = response.getOutputStream();
				fis = new FileInputStream(file);
				byte[] b = new byte[1024];
				int len = 0;
				while((len = fis.read(b)) != -1){
					out.write(b, 0, len);
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally{
				if(fis != null){
					try {
						fis.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(out != null){
					try {
						out.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		   
	}

}
