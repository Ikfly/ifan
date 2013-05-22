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
	<title>找回密码</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
	<link rel="stylesheet" type="text/css" href="boryou/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="boryou/css/bootstrap-responsive.min.css"/>
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
    <font id="checkTips"  color="red"></font>
	<form id="registForm"  method="post" class="form-horizontal">
	<div class="control-group">
	    <label class="control-label" for="userEmail">邮箱地址:</label>
	    <div class="controls">
	       <input type="text" id="userEmail" name="userEmail" /><span  style="color:red";>  *</span>
	    </div>
	</div>
	<div class="control-group">
	    <div class="controls">
	         <input class="btn btn-primary" type="button" value="确 定" onclick="sendEmail()" />　
		     <input class="btn" type="button" onclick="back()" value="返 回" />
	    </div>
	</div>
    </form>
</div>
</body>
</html>
