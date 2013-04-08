package com.boryou.action.order.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.boryou.util.Constant4Web;


public class UploadImgServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		// TODO Auto-generated method stub
		PrintWriter out = null;
	    File tempPathFile = new File("conf/buffer");
	    if (!tempPathFile.exists()) {
	       tempPathFile.mkdirs();
	    }
	    try {
	       out = response.getWriter();
	       // Create a factory for disk-based file items
	       DiskFileItemFactory factory = new DiskFileItemFactory();
	       // Set factory constraints
	       factory.setSizeThreshold(4096); // 设置缓冲区大小，这里是4kb
	       factory.setRepository(tempPathFile);//设置缓冲区目录
	       // Create a new file upload handler
	       ServletFileUpload upload = new ServletFileUpload(factory);
	       // Set overall request size constraint
	       upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB
	       List items = upload.parseRequest(request);//得到所有的文件
	       Iterator i = items.iterator();
	       //while (i.hasNext()) {
	       FileItem fi = (FileItem) i.next();
	       String type = fi.getContentType();
	       if(!type.startsWith("image")){
	    	   out.println("<script>alert('请上传图片');location.href='boryou/order_menu.action'</script>");   
	    	   return;
	       }
//	       if(fileName.endsWith("."))
//	       if (fileName != null) {	//保存文件
	       File savedFile = new File(Constant4Web.MENU_PATH, Constant4Web.MENU_NAME);
       	   fi.write(savedFile);
//	       }
	       out.println("<script>alert('上传成功!');location.href='boryou/order_menu.action'</script>");                  
	    } catch (Exception e) {
	       e.printStackTrace();
	       out.println("<script>alert('上传失败');location.href='boryou/order_menu.action'</script>");             
	    }
	}
	
	private static void createfolder(String strFile){
		if(strFile != null){
			if(strFile.lastIndexOf("/")!=-1){
				File file = new File(strFile.substring(0,strFile.lastIndexOf("/")));
				if(!file.exists()){
					file.mkdirs();
				}
			}
		}
	}
	
	

}
