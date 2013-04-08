package com.boryou.util;

import java.text.SimpleDateFormat;
import java.util.List;



import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.boryou.entity.BOrder;

public class ExcelTool {
	
	private static SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static void exportToExcel(List<BOrder> list){
		
//		File file = new File(new Date());
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
			cell6.setCellValue(sf.format(item.getOrderTime()));
			
		}
		
//		BufferedOutputStream out = new BufferedOutputStream(resp.getOu);
		
//		try {
//			FileOutputStream fileOut = new FileOutputStream(file.getPath());
//			wb.write(fileOut);
//			wb.getBytes();
//			fileOut.close();
//			
//		} catch (FileNotFoundException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	}
	
	public static void main(String[] args) {
//		new ExcelTool().exportStaff();
	}

}
