<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%String sdpath = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>提示信息</title>
</head>
<body onload="changeActive(1)">
<%@include file="../include/top.jsp" %>
<div class="container">
<div class="oartop">提示信息</div>
<table border="0" cellspacing="0" cellpadding="0" class="rtable2" width="100%">
<tr>
<td><font color="red">当前未在订餐允许时间内，请稍后重试</font></td>
</tr>


</table>
</div>
</body>
</html>