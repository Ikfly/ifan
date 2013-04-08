package com.boryou.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;


public class Common {
	
	private Common(){}
	
	public static void writeImg(String strFile,byte[] b){
		FileOutputStream os = null;
		try{
			os = new FileOutputStream(strFile);
			os.write(b);
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
	}
	
	public static byte[] readImg(String strFile){
		byte[] result = null;
		File file = new File(strFile);
		if(file != null){
			FileInputStream fis = null;
			result = new byte[(int)file.length()];
			try {
				 fis = new FileInputStream(file);
				 fis.read(result);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
//				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
//				e.printStackTrace();
			} finally{
				if(fis != null){
					try {
						fis.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		return result;
	}
	
	
	public static String readFileText(String strFile,String encoding){
		String text = null;
		File file = new File(strFile);
		if(file != null){
			FileInputStream fis = null;
			byte[] b = new byte[(int)file.length()];
			try {
				 fis = new FileInputStream(file);
				 fis.read(b);
				 text = new String(b,encoding);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e1) {
				// TODO: handle exception
				e1.printStackTrace();
			}catch (IOException e) {
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
			}
		}
		return text;
	}
	
	
	public static ArrayList<String> readFileByLine(String strFile,String encoding){
		ArrayList<String> result = new ArrayList<String>();
		File file = new File(strFile);
		if(file == null) return result;
		FileInputStream fis = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		try{
			fis = new FileInputStream(file);
			isr = new InputStreamReader(fis,encoding);
			br = new BufferedReader(isr);
			String line = null;
			while((line = br.readLine()) != null){
				line = line.trim();
				if(line.startsWith("#") || line.equalsIgnoreCase("")) continue;
				result.add(line);
			}
		}catch (Exception e) {
			// TODO: handle exception
//			e.printStackTrace();
		}finally{
			if(fis != null){
				try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(isr != null){
				try {
					isr.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(br != null){
				try {
					br.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return result;
	}
	
	public static void writeFile(String strFile,String strSrc){
		FileOutputStream os = null;
		OutputStreamWriter osw = null;
		BufferedWriter br = null;
		PrintWriter out = null;
		try {
			os = new FileOutputStream(strFile);
			osw = new OutputStreamWriter(os,"utf-8");
			br = new BufferedWriter(osw);
			out = new PrintWriter(br);
			out.write(strSrc);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(out != null){
				out.close();
			}
			if(br != null){
				try {
					br.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(os != null){
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(osw != null){
				try {
					osw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	private static void createfolder(String strFile){
		if(strFile !=null){
			if(strFile.lastIndexOf("/")!=-1){
				File file=new File(strFile);
				if(!file.exists()){
					file.mkdirs();
				}
			}
		}
	}
	
	public static void wf(String file,String content,boolean isAdd){
		PrintWriter out = null;
		FileOutputStream fo = null;
		OutputStreamWriter os = null;
		BufferedWriter bf = null;
		try {
			fo = new FileOutputStream(file,isAdd);
		} catch (FileNotFoundException e1) {
			createfolder(file);
			try {
				fo = new FileOutputStream(file,isAdd);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				return ;
			}
		}
		try{
			os = new OutputStreamWriter(fo,"utf-8");
			bf = new BufferedWriter(os);
			out = new PrintWriter(bf);
			out.write(content);
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}finally{
			try {
				if(out!=null){
					out.close();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(bf!=null){
					bf.close();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(os!=null){
					os.close();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(fo!=null){
					fo.close();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
	
	public static ArrayList<String> readToList(InputStream in){
	    ArrayList<String> result = new ArrayList<String>();
	    if(in == null) return result;
	    InputStreamReader isr = null;
	    BufferedReader br = null;
	    try {
			isr = new InputStreamReader(in,"utf-8");
			br = new BufferedReader(isr);
			String line = null;
			while((line = br.readLine()) != null){
				line = line.trim();
				if(!line.equalsIgnoreCase("")){
					result.add(line);
				}
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(isr != null){
				try {
					isr.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				isr = null;
			}
			try {
				in.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			in = null;
		}
	    return result;
	}

}
