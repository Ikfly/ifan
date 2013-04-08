<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<base href="<%=basePath %>" />
	<title>ifan注册页</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />
	<script type="text/javascript" src="<%=path %>/boryou/js/AjaxObject.js"></script>
	
	<script type="text/javascript">
	
	 function isExistsEmail(userEmail){
            var isExists = true;
			var url = "<%=path%>/boryou/user_isExistEmail.action";
			var info = "userEmail="+userEmail;
			// 进行 Ajax 请求
			var ajax = new Ajax(url, "POST", false, info);
			ajax.dealResult = function(result) {
				if (result) {
					if (result.indexOf("true") != -1) {
						isExists = true;
					} else {
						isExists = false;
					}
				}
			};
			ajax.executeRequest();
			return isExists;
    }
	
	function back(){
	    window.location.href="<%=path%>/boryou/login.jsp";
	 }
	 
	 var regexEmail = /^[\w-]+@[\w-]+(\.[\w-]+)+$/;
	 function sendEmail(){
	     var userEmail=document.forms["registForm"].elements["userEmail"].value;
	     var tips = document.getElementById("checkTips");
	     if(!regexEmail.exec(userEmail)){
	         tips.innerHTML=" 邮箱格式不正确";
	         return false;
	     }else if(!isExistsEmail(userEmail)){
	         tips.innerHTML=" 该邮箱地址未在系统中注册";
	         return false;
	     }else{
	         document.forms["registForm"].action="<%=path %>/boryou/email_email.action";
	         document.forms["registForm"].submit();
	     }
	 }
	</script>
</head>

<body>
<div class="logintab">
	<form id="registForm"  method="post">
	<div align="left">
	<font id="checkTips"  color="red"></font>
	</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="logintable1">
		<tr>
		  <td></td>
		  <td>请输入您注册的邮箱</td>
		  </tr>
		  <tr>
		    <td width="22%" class="f14">邮箱地址:</td>
		    <td width="78%">
		      <input class="input1" type="text" id="userEmail" name="userEmail" /><span  style="color:red";>  *</span>
		    </td>
		  </tr>
		  
		  <tr>
		    <td class="f14">&nbsp;</td>
		    <td>
		      <input  type="button" value="确 定" onclick="sendEmail()" />　
		      <input  type="button" onclick="back()" value="返 回" />
		    </td>
		  </tr>
		  
		</table>
		<div class="loginbot"> </div>
	    <div class="clear"></div>
    </form>
</div>
</body>
</html>
