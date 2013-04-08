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
	<title>ifan</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
	<link rel="stylesheet" type="text/css" href="boryou/css/global.css" />
	<link rel="stylesheet" type="text/css" href="boryou/css/boryou.css" />
	<!--  
	<link rel="icon" href="http://192.168.1.138:8080/ifan/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="http://192.168.1.138:8080/ifan/favicon.ico" type="image/x-icon" /> 
	-->
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
	<form id="loginForm" action="<%=path %>/LoginServlet" method="post">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="logintable1">
		<tr><td></td><td><font color="#FF0000" size="+1">${requestScope.message }</font></td></tr>
		  <tr>
		    <td width="22%" class="f14">用户名:</td>
		    <td width="78%">
		      <input class="input1" type="text" id="userName" name="user.userName" />
		    </td>
		  </tr>
		  <tr>
		    <td class="f14">密  码:</td>
		    <td>
		    	<input class="input1" type="password" id="password" name="user.userPassword" />
	    	</td>
		  </tr>
		  <tr>
		    <td class="f14">&nbsp;</td>
		    <td>
		      <input  type="button"  value="登 录" onclick="login()" />　
		      <input  type="button" onclick="reg()" value="注 册" />
		      &nbsp
		      <a href="javascript:void(0)" onclick="javascript:sendPwdEmail()">忘记密码？</a>
		    </td>
		  </tr>
		</table>
		<br/>
		<div align="center"><b>ifan  2.4</b></div>
    </form>
</div>
</body>
</html>
