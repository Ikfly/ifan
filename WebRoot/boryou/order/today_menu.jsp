<%@ page language="java" contentType="text/html;"
    pageEncoding="gbk"%>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="gbk">
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
<body>
<div class="oarcont">
<div class="oartop"><a>菜单管理</a> </div>
	<table border="0" cellspacing="0" cellpadding="0"  width="20%">
	<form action="<%=path %>/UploadImgServlet" method="post" enctype="multipart/form-data">
	<tr>
	<td>选择菜单图片上传</td>
	<td></td>
	</tr>
	<tr>
	<td><input type="file" name="fileforload" size="30" /></td>
	<td><input type="submit" value="上传"/></td>
	</tr>
	</form>
	</table>
</div>
	<!-- 
<div id="demo">
<div id="indemo">
<div id="demo1">

<a href="#"><img src="<%=path %>/boryou/img/b10.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b12.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b13.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b14.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b15.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b1.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b2.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b3.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b4.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b5.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b6.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b8.jpg" border="0" /></a>
<a href="#"><img src="<%=path %>/boryou/img/b9.jpg" border="0" /></a>

</div>
<div id="demo2"></div>
</div>
</div>
	</td>
</tr>
	 -->


</body>
</html>