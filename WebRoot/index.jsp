<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="java.util.*"%>   
 <%@page language="java" import="com.boryou.entity.*"%>   
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/boryou.css" />
<title>ifan</title>
</head>
<frameset rows="140px,*,20px" border="0" >
  <frame src="<%=path%>/boryou/include/top.jsp" noresize="noresize" name="topFrame" id="topFrame"></frame>
  <frameset cols="140px,*" border="0">
 <frame src="<%=path%>/boryou/include/left_tools.jsp" name="leftFrame" id="leftFrame" noresize="noresize"></frame>
 <frame src="<%=path%>/boryou/notice_notice.action" noresize="noresize" name="mainFrame" id="mainFrame"></frame>
 </frameset>
 <frame src="<%=path%>/boryou/include/bottom.jsp" noresize="noresize" ></frame>
  <noframes>
  <body>
  抱歉，您的浏览器不支持框架
  </body>
  </noframes>
</frameset>
</html>