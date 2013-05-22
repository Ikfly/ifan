<%@ page language="java" contentType="text/html;"
    pageEncoding="gbk"%>
<%@ page isELIgnored="false"%>
<%
String sdpath = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sdpath+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="gbk">
<title>菜单上传</title>
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

<script type="text/javascript">
/*
var speed=15;
var tab=document.getElementById("demo");
var tab1=document.getElementById("demo1");
var tab2=document.getElementById("demo2");
tab2.innerHTML=tab1.innerHTML;
function Marquee(){
if(tab2.offsetWidth-tab.scrollLeft<=0)
tab.scrollLeft-=tab1.offsetWidth
else{
tab.scrollLeft++;
}
}
var MyMar=setInterval(Marquee,speed);
tab.onmouseover=function() {clearInterval(MyMar)};
tab.onmouseout=function() {MyMar=setInterval(Marquee,speed)};
*/


</script>
</head>
<body onload="changeActive(5)">
<%@include file="../include/top.jsp" %>
<div class="container">
<div class="oartop"><a>菜单上传</a> </div>

	<table class="table">
	<form action="<%=sdpath %>/UploadImgServlet" method="post" enctype="multipart/form-data">
	<tr>
	<td>请选择菜单图片上传</td>
	<td></td>
	</tr>
	<tr>
	<td><input type="file" name="fileforload" size="30" /></td>
	<td><input type="submit" class="btn" value="上传"/></td>
	</tr>
	</form>
	</table>
</div>

</body>
</html>