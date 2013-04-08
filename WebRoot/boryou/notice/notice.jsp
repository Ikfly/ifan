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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />
<title>ifan</title>
<style type="text/css">
<!--
#demo {
background: #FFF;
overflow:hidden;
border: 1px dashed #CCC;
width: 1000px;
}
#demo img {
border: 3px solid #F2F2F2;
}
#indemo {
float: left;
width: 800%;
}
#demo1 {
float: left;
}
#demo2 {
float: left;
}
-->
</style>
</head>
<body>
<div class="oarcont">
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