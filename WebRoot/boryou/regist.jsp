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
	<title>注册</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="boryou/css/global.css" />
	<link rel="stylesheet" type="text/css" href="boryou/css/boryou.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/bootstrap-responsive.min.css"/>
	<script type="text/javascript" src="<%=path %>/boryou/js/AjaxObject.js"></script>
	<script type="text/javascript">
	function back(){
	    window.location.href="<%=path%>/boryou/login.jsp";
	 }
	 function isExistsUserName(userName){
            var isExists = true;
			var url = "<%=path%>/boryou/user_isUserNameExist.action";
			var info = "userName="+userName;
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
   
   
     var regexUserRealName = /^([\u4E00-\u9FA5]){2,8}$/;
	 var regexUserPs = /^[A-Za-z0-9]{6,10}$/;
	 var regexEmail = /^[\w-]+@[\w-]+(\.[\w-]+)+$/;
	 var user_name=/^[a-zA-Z]{2,15}$/;   
	 function regist(){
	        if(validateUserName() && validateEmail() && validateRealName() && validatePwd()){
	             document.forms["registForm"].action="<%=path %>/boryou/user_regist.action";
	             document.forms["registForm"].submit();
	        }else{
	            return false;
	        }
	 }
	 
	 function clearsp(id){
	     var sp = document.getElementById(id);
	     sp.innerHTML = " *";
	     return false;
	 }
	 
	 function validateUserName(){
	     var spUserName = document.getElementById("spUserName");
	     var userName=document.getElementById("userName").value.replace(/\s/g,'');
	     if(!user_name.exec(userName)){
	         spUserName.innerHTML=" 用户名必须是2-15个的字母";
	         return false;
	     }else if(isExistsUserName(userName)){
	         spUserName.innerHTML=" 该用户名已被注册";
	         return false;
	     }
	     return true;
	 }
	 
	 function validateEmail(){
	     var spEmail = document.getElementById("spEmail");
	     var userEmail = document.getElementById("userEmail").value;
	     if(!regexEmail.exec(userEmail)){
	         spEmail.innerHTML=" 邮箱格式不正确";
	         return false;
	     }else if(isExistsEmail(userEmail)){
	         spEmail.innerHTML=" 该邮箱已被注册";
	         return false;
	     }
	     return true;
	 }
	 
	 function validateRealName(){
	     var spRealName = document.getElementById("spRealName");
	     var userRealName = document.getElementById("userRealName").value;
	     if(!regexUserRealName.exec(userRealName)){
	         spRealName.innerHTML=" 真实姓名必须为2-8个汉字或字符";
	         return false;
	     }
	     return true;
	 }
	 
	 function validatePwd(){
	     var spPwd = document.getElementById("spPwd");
	     var userPassword=document.getElementById("userPassword").value;
	     if(!regexUserPs.exec(userPassword)){
	         spPwd.innerHTML=" 密码必须为6-10个字母或数字";
	         return false;
	     }
	     return true;
	 }
	 
	</script>
</head>

<body>
<div class="logintab">
    <font id="checkTips"  color="red"></font>
	<form id="registForm"  method="post" class="form-horizontal">
	<div class="control-group">
	    <lable class="control-label" for="userName">用户名:</lable>
	    <div class="controls">
	      <input type="text" id="userName" name="userName" onfocus="clearsp('spUserName')" onblur="validateUserName()" /><span id="spUserName"  style="color:red";>  *</span>
	    </div>
	</div>
	
	<div class="control-group">
	    <lable class="control-label" for="userEmail">常用邮箱:</lable>
	    <div class="controls">
	       <input type="text" id="userEmail" name="userEmail" onfocus="clearsp('spEmail')" onblur="validateEmail()" /><span id="spEmail" style="color:red";>  *</span>
	    </div>
	</div>
	
	<div class="control-group">
	    <lable class="control-label" for="userRealName">真实姓名:</lable>
	    <div class="controls">
	       <input type="text" id="userRealName" name="userRealName" onfocus="clearsp('spRealName')" onblur="validateRealName()" /><span id="spRealName" style="color:red";>  *</span>
	    </div>
	</div>
	
	<div class="control-group">
	    <lable class="control-label" for="userPassword">密  码:</lable>
	    <div class="controls">
	       <input type="password" id="userPassword" name="userPassword" onfocus="clearsp('spPwd')" onblur="validatePwd()" /><span id="spPwd" style="color:red";>  *</span>
	    </div>
	</div>
	
	<div class="control-group">
	    <div class="controls">
	      <input class="btn btn-primary" type="button" value="注 册" onclick="regist()" />　
	      <input class="btn" type="button" onclick="back()" value="返 回" />
	    </div>
	</div>
    </form>
</div>
</body>
</html>
