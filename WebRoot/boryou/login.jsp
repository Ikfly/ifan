<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String message=(String)request.getAttribute("message"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<base href="<%=basePath %>" />
	<title>登录</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
	<link rel="stylesheet" type="text/css" href="boryou/css/global.css" />
	<link rel="stylesheet" type="text/css" href="boryou/css/boryou.css" />
	<link rel="stylesheet" type="text/css" href="boryou/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="boryou/css/bootstrap-responsive.min.css"/>
	
	
	<script type="text/javascript">
	
		function getCookie(c_name){
			if (document.cookie.length>0){
  				c_start=document.cookie.indexOf(c_name + "=");
  				if (c_start!=-1){ 
					c_start=c_start + c_name.length+1;
					c_end=document.cookie.indexOf(";",c_start);
					if (c_end==-1) c_end=document.cookie.length;
					return unescape(document.cookie.substring(c_start,c_end));
				} 
			}
			return "";
		}

		function setCookie(c_name,value,expiredays){
			var exdate=new Date();
			exdate.setDate(exdate.getDate()+expiredays);
			document.cookie=c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
		}  
		
		function Clearcookie(){  
			var exdate=new Date();
			exdate.setDate(exdate.getDate()+7);
			document.cookie="userName=;expires="+exdate.toGMTString();
			document.cookie="passWord=;expires="+exdate.toGMTString();
    	}  
		
		function isSave () {
			return document.getElementById("isSave").checked;
		} 
		
		function loadCookies(){
			if(getCookie("userName")!="''" && getCookie("userName")!=null)
				window.document.forms[0].elements["user.userName"].value = getCookie("userName");
			if(getCookie("passWord")!="''" && getCookie("passWord")!=null)
				window.document.forms[0].elements["user.userPassword"].value = getCookie("passWord");
		}
		
		function saveCookie(){
				Clearcookie();
				setCookie("userName",document.forms[0].elements["user.userName"].value,7);
				setCookie("passWord",document.forms[0].elements["user.userPassword"].value,7);
		}
		
		function initCookie() {
			window.loadCookies();
			//window.history.forward();
		}
		
		function reg(){
		    window.location.href="<%=path%>/boryou/regist.jsp";
		}
		
		function sendPwdEmail(){
		    window.location.href="<%=path%>/boryou/forgetPwd.jsp";
		}
		
		function login(){
		    saveCookie();
		    if(document.getElementById("userName").value.replace(/\s/g,'').length==0
		    ||document.getElementById("password").value.replace(/\s/g,'').length==0){
		       alert("用户名或密码为空");
		       return false;
		    }else{
		       document.forms["loginForm"].action="<%=path %>/boryou/login_login.action";
	           document.forms["loginForm"].submit();
		    }
		}
	</script>
</head>

<body onload="initCookie();">
<div class="logintab">
    
	<form class="form-horizontal" id="loginForm"  action="<%=path %>/LoginServlet" method="post">
	<font color="#FF0000" size="+1">${requestScope.message }</font>
	<div class="control-group">
		<lable class="control-label" for="userName">用户名</lable>
		<div class="controls">
		  <input type="text" id="userName" name="user.userName" placeholder="用户名"/>
		</div>
	</div>
	<div class="control-group">
		<lable class="control-label" for="userName">密码</lable>
		<div class="controls">
		  <input type="password" id="password" name="user.userPassword" placeholder="密码"/>
		  
		</div>
	</div>
	<div class="control-group">
      <div class="controls">
        <button class="btn btn-primary" type="button"onclick="login()" >登 录</button>　
	    <button class="btn" type="button" onclick="reg()" >注 册</button>
	    <button type="button" class="btn btn-link"  onclick="sendPwdEmail()">忘记密码？</button>
      </div>
    </div>
	<div align="center"><b>ifan  2.4</b></div>
    </form>
    </div>
</body>
</html>
