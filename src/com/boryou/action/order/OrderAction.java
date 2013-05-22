package com.boryou.action.order;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.boryou.action.AbstractAction;
import com.boryou.dao.BLogDao;
import com.boryou.dao.BOrderDao;
import com.boryou.entity.BOrder;
import com.boryou.entity.BOrderUser;
import com.boryou.util.Common;
import com.boryou.util.Constant4Web;

public class OrderAction extends AbstractAction {
	
	
	private BOrderDao dao=new BOrderDao();
    private BLogDao logDao=new BLogDao();
    
    private static SimpleDateFormat sf4export = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static SimpleDateFormat sf4exportdata = new SimpleDateFormat("yyyyMMddHHmm");
    private static SimpleDateFormat sf4manage =new SimpleDateFormat("yyyy-MM-dd");
    private static SimpleDateFormat sf4query = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    /**
     * 订单管理界面
     * @return
     */
    public String orderManage(){
    	 int nowPage=0;
		 try{
		     if(request.getAttribute("nowPage") == null){
			    nowPage=Integer.parseInt(request.getParameter("nowPage"));
		     }else{
		    	 nowPage = Integer.parseInt((String)request.getAttribute("nowPage"));
		     }
		 }catch(Exception E){
	         nowPage=1;
	     }
		 List<BOrder> result=dao.listOrderRecordByDay(nowPage);
		 request.setAttribute("result", result);
		 if(result!=null&&result.size()>0){
		 	request.setAttribute("date", sf4manage.format(result.get(0).getOrderTime()));
		 }
		 request.setAttribute("message", request.getAttribute("message"));
		 request.setAttribute("nowPage", nowPage);
		 request.setAttribute("totalNum", dao.countTotalOrder());
		 request.setAttribute("totalDay",(int)dao.countTotalDay());
		 return "order_manage";
	}
    
    /**
     * ajax翻页
     */
    public void orderManageAjax(){
    	PrintWriter out = null;
    	List<BOrder> result = new ArrayList<BOrder>();
    	int nowPage = 1;
    	try{
    		nowPage = Integer.parseInt(request.getParameter("nowPage"));
    	}catch (Exception e) {
			// TODO: handle exception
		}
    	try{
    		out = response.getWriter();
    		result = dao.listOrderRecordByDay(nowPage);
    		out.print(generatorJSON(result));
    	}catch (Exception e) {
			// TODO: handle exception
		}finally{
			if(out != null)
				out.close();
		}
    }
    
    /**
     * json拼接
     * @param list
     * @return
     */
    private String generatorJSON(List<BOrder> list){
    	StringBuffer sb = new StringBuffer("[");
    	for(BOrder order : list){
    		sb.append("{");
    		sb.append("id:" + order.getOrderId() + ",");
    		sb.append("userRealName:'" + order.getRealUsername() + "',");
    		sb.append("orderTime:'" + order.getOrderTime().toString().substring(0, 19) + "',");
    		sb.append("extraNum:" + order.getExtraNumber() + ",");
    		sb.append("note:'" + (order.getNote().length() > 16 ? order.getNote().substring(0,16) : order.getNote()) + "',");
    		sb.append("completeNote:'" + order.getNote() + "',");
    		sb.append("checked:'" + (order.getChecked() == 0 ? "未支付" : "已支付") + "',");
    		sb.append("changeNote:'" + (order.getChangeNote() == null ? "" : order.getChangeNote())+ "'");
    		sb.append("}");
    		sb.append(",");
    	}
    	if(sb.lastIndexOf(",") != -1){
    		sb = new StringBuffer(sb.substring(0, sb.lastIndexOf(",")));
    	}
    	sb.append("]");
    	return sb.toString();
    }
    
    
    
    
    /**
     * 订单查询界面
     * @return
     */
    public String query(){
    	String startTime = (String)request.getParameter("startTime");
		String endTime = (String)request.getParameter("endTime");
		String userRealName = (String)request.getParameter("userRealName");
		String checked = (String)request.getParameter("checkSelect");
		int nowPage = 0;
		int pageSize = 20;
		try{
			 nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}catch(Exception e){
		     nowPage = 1;
		}
		long totalNum = 0L;
		List<BOrder> result = new ArrayList<BOrder>();
		Object[] temp = null;
		Date start = null;
		Date end = null;
        if(startTime != null && endTime != null 
        		&& !startTime.equalsIgnoreCase("") && !endTime.equalsIgnoreCase("")){
        	try {
        		start = sf4query.parse(startTime);
        		end = sf4query.parse(endTime);
        		if(start.getTime() < end.getTime()){
        			Date[] time = new Date[]{sf4query.parse(startTime),sf4query.parse(endTime)};
        			temp = dao.queryOrders(time, userRealName,checked,nowPage,pageSize);
        			result = (List<BOrder>)temp[0];
        			totalNum = (Long)temp[1];
        		}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }else{
        	startTime = (String)request.getSession().getAttribute(Constant4Web.QUERY_STARTTIME);
			endTime = (String)request.getSession().getAttribute(Constant4Web.QUERY_ENDTIME);
			userRealName = (String) request.getSession().getAttribute(Constant4Web.QUERY_USERNAME);
        	if(startTime != null && endTime != null 
        			&& !startTime.equalsIgnoreCase("") && !endTime.equalsIgnoreCase("")){
				try {
					if(startTime.equalsIgnoreCase("")){
						startTime = sf4query.format(Constant4Web.open());
					}
					if(endTime.equalsIgnoreCase("")){
						endTime = sf4query.format(new Date());
					}
					start = sf4query.parse(startTime);
        		    end = sf4query.parse(endTime);
        		    if(request.getSession().getAttribute(Constant4Web.QUERY_SELECT) != null){
        		    	checked = (String) request.getSession().getAttribute(Constant4Web.QUERY_SELECT);
        		    }
        		    if(start.getTime() < end.getTime()){
        			    Date[] time = new Date[]{sf4query.parse(startTime),sf4query.parse(endTime)};
        			    temp = dao.queryOrders(time, userRealName,checked,nowPage,pageSize);
            			result = (List<BOrder>)temp[0];
            			totalNum = (Long)temp[1];
        		    }
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
        }
        request.getSession().setAttribute(Constant4Web.QUERY_STARTTIME, startTime);
        request.getSession().setAttribute(Constant4Web.QUERY_ENDTIME, endTime);
        request.getSession().setAttribute(Constant4Web.QUERY_USERNAME, userRealName);
        request.getSession().setAttribute(Constant4Web.QUERY_SELECT, checked == null ? "-1" : checked);
        request.setAttribute("result", result);
        request.setAttribute("nowPage", nowPage);
        request.setAttribute("totalNum", totalNum);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("message", request.getAttribute("message"));
       return "query";
    }
    
    /**
     * 取消订单
     * @return
     */
	public String cancelOrder(){
		if(logDao.submited()){
			request.setAttribute("message", "");
		}else{
			long orderId=Long.parseLong(request.getParameter("orderId"));
			dao.cancelOrder(orderId);
			request.setAttribute("message", "取消成功");
		}
		return list();
	}
	
	/**
	 * 结算订单
	 * @return
	 */
	public String checkOrder(){
		BOrderUser currentUser=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		if(currentUser != null && currentUser.getTypeId()> 2){
			request.setAttribute("message", "");
		}else{
			String[] orderIds = request.getParameterValues("cbCheckOrder");
			for(int i=0;i<orderIds.length;i++){
				dao.checkOrder(Long.parseLong(orderIds[i]));
			}
			request.setAttribute("message", "结算成功");
		}
		return list();
	}
	
	/**
	 * 删除作废订单
	 * @return
	 */
	public String delOrder(){
		String[] strIds = request.getParameterValues("cbSelectOne");
		String nowPage = request.getParameter("nowPage4Del");
		if(dao.deleteOrder(strIds)){
			request.setAttribute("message", "删除成功");
		}else{
			request.setAttribute("message", "删除失败！");
		}
		request.setAttribute("nowPage",nowPage);
		return orderManage();
	}
	
	/**
	 * 导出订单
	 */
	
	public void exportOrder(){
		String startTime = (String)request.getSession().getAttribute(Constant4Web.QUERY_STARTTIME);
		String endTime = (String)request.getSession().getAttribute(Constant4Web.QUERY_ENDTIME);
		String userRealName = (String) request.getSession().getAttribute(Constant4Web.QUERY_USERNAME);
		String strChecked = (String) request.getSession().getAttribute(Constant4Web.QUERY_SELECT);
		Date start = null;
		Date end = null;
		
		if(startTime != null && endTime != null
				&& !startTime.equalsIgnoreCase("") && !endTime.equalsIgnoreCase("")){
			try {
				start = sf4export.parse(startTime);
			    end = sf4export.parse(endTime);
			} catch (ParseException e) {
					// TODO Auto-generated catch block
			}
			Date[] time = new Date[]{start,end};
			List<BOrder> result = dao.queryOrders(time, userRealName, strChecked);
			response.setContentType("application/vnd.ms-excel");  
			response.setCharacterEncoding("utf-8");  
			response.setHeader("Content-disposition", "attachment; filename="  
			               + sf4exportdata.format(new Date()) + ".xls");  
			BufferedOutputStream os = null;
			try{
				os = new BufferedOutputStream(response.getOutputStream());
				createExcel(result,os);
				response.flushBuffer();
			}catch (Exception e) {
				// TODO: handle exception
			}finally{
				if(os != null){
					try {
						os.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
		    }
		}else{
			PrintWriter out = null;
			try {
				out = response.getWriter();
				out.println("<script>alert('请选择查询时间');window.location.href='boryou/order_query.action'</script>");
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
	}
	
	/**
	 * 导出Excel订单
	 * @param list
	 * @param out
	 * @throws IOException 
	 * @throws IOException
	 */
	
	private void createExcel(List<BOrder> list,BufferedOutputStream os) throws IOException{
		    
			HSSFWorkbook wb = new HSSFWorkbook(); //建立新HSSFWorkbook对象
			HSSFSheet sheet = wb.createSheet("orders.xls"); //建立新的sheet对象
			HSSFHeader header = sheet.getHeader();     
	        header.setCenter("订单列表");  
			HSSFCellStyle cellStyle = wb.createCellStyle();
			HSSFCellStyle posStyle  = wb.createCellStyle();
			HSSFDataFormat format = wb.createDataFormat();
			cellStyle.setDataFormat(format.getFormat("text"));
			posStyle.setDataFormat(format.getFormat("General"));
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			String[] head = {"订单号", "姓名" , "加饭数量", "是否支付", "留言", "备注", "  下单时间  "}; 
			for(int i=0; i<head.length; i++){
				cell = row.createCell(i);
				cell.setCellStyle(cellStyle);
				cell.setCellValue(head[i]);
			}
			int index = 0;
			for(BOrder item : list){
				HSSFRow r = sheet.createRow(++index);
				HSSFCell cell0 = r.createCell(0);
				cell0.setCellStyle(cellStyle);
				cell0.setCellValue(item.getOrderId());
				
				HSSFCell cell1 = r.createCell(1);
				cell1.setCellStyle(cellStyle);
				cell1.setCellValue(item.getRealUsername());
				
				HSSFCell cell2 = r.createCell(2);
				cell2.setCellStyle(cellStyle);
				cell2.setCellValue(item.getExtraNumber());
				
				HSSFCell cell3 = r.createCell(3);
				cell3.setCellStyle(cellStyle);
				cell3.setCellValue(item.getChecked() == 0 ? "否" : "是");
				
				HSSFCell cell4 = r.createCell(4);
				cell4.setCellStyle(cellStyle);
				cell4.setCellValue(item.getNote());
				
				HSSFCell cell5 = r.createCell(5);
				cell5.setCellStyle(cellStyle);
				cell5.setCellValue(item.getChangeNote());
				
				HSSFCell cell6 = r.createCell(6);
				cell6.setCellStyle(cellStyle);
				cell6.setCellValue(sf4query.format(item.getOrderTime()));
			}
			wb.write(os);
		}
	
	/**
	 * 今日订单列表
	 * @return
	 */
	public String list(){
		BOrderDao dao=new BOrderDao();
		List<BOrder> list= dao.searchTodaysOrder();
		int totalExtraNum=0;
		if(logDao.submited()){
			request.setAttribute("logValue", "off");
		}
		for(BOrder item:list){
			totalExtraNum += item.getExtraNumber();
		}
		request.setAttribute("totalNumber", list.size());
		request.setAttribute("totalExtraNum",totalExtraNum);
		request.setAttribute("orderList", list);
		return "list";
	}
	
	/**
	 * 下订单界面
	 * @return
	 */
	public String myorder(){
		    request.setAttribute("ordered", request.getAttribute("ordered"));
		    long now = new Date().getTime();
		    if(now < Constant4Web.open().getTime() || (now >= Constant4Web.noon().getTime() && 
		    		now < Constant4Web.dinner().getTime()) || now >= Constant4Web.shutdown().getTime()){
		    	return "error";
		    }else{
		    	return "order";
		    }
	}
	
	/**
	 * 下订单事件
	 * @return
	 */
	public String order(){
		BOrderUser user =(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		if(user!=null){
			if(logDao.submited()){
				request.setAttribute("message","管理员已提交该时间段订单，请直接与管理员联系");
			}else{
				if(dao.ordered(user.getUserId())){
					request.setAttribute("ordered", "ordered");
					request.setAttribute("message","您已经订过，请勿重复订餐,您可以在列表页取消您当前时间段内的订餐");
	                return "order";
				}else{
					request.setAttribute("ordered", "not");
					int extraNumber=0;
					try{
					     extraNumber=Integer.parseInt(request.getParameter("extraNum"));
					    }catch(Exception er){
					    	er.printStackTrace();
					    }
					     String note=(String)request.getParameter("note");
					     BOrder newOrder=new BOrder();
					     newOrder.setUserId(user.getUserId());
					     newOrder.setRealUsername(user.getUserRealName());
					     newOrder.setExtraNumber(extraNumber);
					     newOrder.setOrderTime(new Date());
					     newOrder.setChecked(0);
					     newOrder.setNote(note);
					     dao.add(newOrder);
					     request.setAttribute("message", "订餐成功！");
				    }
				}
			}
		return list();
	}
	
	/**
	 * 提交所有订单，关闭系统
	 * @return
	 */
	public String submitOrder(){
		BOrderUser currentUser=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		if(currentUser !=null && currentUser.getTypeId() > 2){
			request.setAttribute("message", "您无权提交");
		}else{
			// 
			String vcode = request.getParameter("vcode");
			if (vcode == null
					|| !vcode.equalsIgnoreCase((String)request.getSession().getAttribute(
							"vcode"))) {
				request.setAttribute("message", "验证码有误");
			}else{
				String ip = request.getHeader("x-forwarded-for") == null ? request.getRemoteAddr() : request.getHeader("x-forwarded-for");
				int info = logDao.submitOrder(currentUser.getUserId(),ip);
				switch(info){
				case 0:
					request.setAttribute("message", "今日订单已提交过，请刷新页面");
					break;
				case 1:
					request.setAttribute("message", "提交成功！");
					break;
				default:
				}
			}
		}
		return list();
	}
	
	/**
	 * 修改订单找零备注
	 * @return
	 */
	public String updateNote(){
		BOrderUser currentUser=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
		if(currentUser!=null&&currentUser.getTypeId() > 2){
			request.setAttribute("message", "您没有修改的权限");
		}else{
			long orderId=Long.parseLong(request.getParameter("orderId"));
			String changeNote=request.getParameter("changeNote");
			BOrder order=dao.get(orderId);
			order.setChangeNote(changeNote);
			dao.updateOrder(order);
			request.setAttribute("message", "备注成功");
		}
		return list();
	}
	
	/**
	 * 今日菜单
	 * @return
	 */
	public String menu(){
		return "menu";
	}
	
	
}
