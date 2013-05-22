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
<title>消息盒子</title>

<script type="text/javascript">
   function showMessageDetail(senderId){
       window.location.href="<%=path%>/boryou/message_messageDetail.action?senderId="+senderId;
       
   }
</script>

</head>
<body>
<div class="oarcont">
<div class="oartop"><a>消息盒子</a> </div>
<table border="0" cellspacing="0" cellpadding="0" class="rtable2" width="100%">
<tr>

	<td valign="top">

<div class="oarcont" id="boryou">
	
	<div class="rnavtable6">
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="rtable2" align="center">
<%
    List<BMessageBox> result=(List<BMessageBox>)request.getAttribute("result");
    if(result!=null&&result.size()>0){
    for(BMessageBox box:result){
 %>
<tr class="tt">
<td colspan="2"><b><a href="javascript:void(0)" onclick="javascript:showMessageDetail(<%=box.getSenderId()%>)">(<%=box.getSenderUserName() %>)<%=box.getSenderName() %></a></b></td>

</tr>
<tr>
<td colspan="2">
<a href="javascript:void(0)" onclick="javascript:showMessageDetail(<%=box.getSenderId()%>)">共<font color="red"><b><%=box.getUnReadNum() %></b></font>条未读消息</a>
</td>
</tr>
<tr>
<td colspan="2">
</td>
</tr>
<%} 
    }else{%>
    <div align="center">您当前还没有收到过消息 </div>
    <%} %>
</table>
		<div class="clear"></div>
	</div>
	</td>
	</tr></table>
	
</div>
</body>
</html>