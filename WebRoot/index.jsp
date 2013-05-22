<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="com.boryou.entity.*"%>   
<%@ page isELIgnored="false"%>
<%
String sdpath = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sdpath+"/";
%>
<!--  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/global.css" />
<link rel="stylesheet" type="text/css" href="css/boryou.css" />
<title>ifan</title>
</head>
<frameset rows="140px,*,20px" border="0" >
  <frame src="<%=sdpath%>/boryou/include/top.jsp" noresize="noresize" name="topFrame" id="topFrame"></frame>
  <frameset cols="140px,*" border="0">
 <frame src="<%=sdpath%>/boryou/include/left_tools.jsp" name="leftFrame" id="leftFrame" noresize="noresize"></frame>
 <frame src="<%=sdpath%>/boryou/notice_notice.action" noresize="noresize" name="mainFrame" id="mainFrame"></frame>
 </frameset>
 <frame src="<%=sdpath%>/boryou/include/bottom.jsp" noresize="noresize" ></frame>
  <noframes>
  <body>
  抱歉，您的浏览器不支持框架
  </body>
  </noframes>
</frameset>
</html>
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>main</title>
</head>
<body onload="changeActive(0)">
<%@ include file="boryou/include/top.jsp" %>
<div class="container">
<div class="oartop"><a>首页</a> </div>
<table border="0" cellspacing="0" cellpadding="0" class="rtable2" width="100%">
<tr>
	<td valign="top">
	午餐订餐时间段：${requestScope.open} 时 ${requestScope.open_minite } 分 - ${requestScope.noon} 时 ${requestScope.noon_minite } 分
	</td>
</tr>
<tr>
<td>
晚餐订餐时间段：${requestScope.dinner} 时 ${requestScope.dinner_minite } 分 - ${requestScope.shutdown} 时 ${requestScope.shutdown_minite } 分
</td>
</tr>
</table>
	
</div>
</body>
</html>
