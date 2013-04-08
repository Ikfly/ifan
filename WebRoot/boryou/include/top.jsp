<%@ page language="java"  pageEncoding="utf-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<title>ifan登录页</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<style type="text/css">
		A {
			cursor:pointer;
		}
	</style>
	<script src="<%=path %>/boryou/js/jquery.js" type="text/javascript"></script>
	<script src="<%=path %>/boryou/js/global.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />
	<script type="text/javascript">
    function logout(){
         
         window.top.location.href="<%=path %>/boryou/user_logout.action";
    }
    
     function about(){
         var info_mes = "";
         info_mes += "\n";
         info_mes += "作者:  superkey";
         info_mes += "\n";
         info_mes += "Email: astro.liuhang@gmail.com";
         info_mes += "\n";
         info_mes += "QQ:    124915122";
         info_mes += "\n\n";
         info_mes += "欢迎反馈系统bug和提出改进意见";
         alert(info_mes);
    }
 
</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="rtable2">
<tr>
<td colspan="2"><a href="http://www.boryou.com" target="_blank"><img src="<%=path %>/boryou/img/head/logo1.gif" title="博约科技" border="0" /></a></td></tr>
<tr>
<td align="left" width="70%">${sessionScope.USER.userRealName}(${sessionScope.USER.userName }) 欢迎您使用订餐系统！
</td>
<td align="right">
现在是<font id="clock"></font>
</td>
</tr>
<tr>
<td><div id="broadcast"></div></td>
<td>
<div align="right">
<a href="javascript:void()" onclick="about();"><b>关于系统</b></a>
<a href="javascript:void()" onclick="logout();"><b>注销登录</b></a>
</div>
</td>
</tr>

</table>
</body>
</html>

