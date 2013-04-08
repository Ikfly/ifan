<%@ page language="java" import="java.util.Date" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="com.boryou.entity.*"%>
<%@ page language="java" import="com.boryou.util.*"%>

<%
SimpleDateFormat sf=new SimpleDateFormat("HH:mm:ss");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

BOrderUser user = (BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
	 
 %>
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
	<script type="text/javascript" src="<%=path %>/boryou/js/AjaxObject.js"></script>
	<script type="text/javascript" src="<%=path %>/boryou/js/ajax-pushlet-client.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />
	<script type="text/javascript">
	
      var step = 0;
      var st = null;
      function flash_title(message) {
          if (step == 5) { step = 0 }
          if (step == 4) { window.top.document.title = message+'☆☆☆☆☆☆☆☆' }
          if (step == 3) { window.top.document.title = '☆☆'+message+'☆☆☆☆☆☆' }
          if (step == 2) { window.top.document.title = '☆☆☆☆'+message+'☆☆☆☆' }
          if (step == 1) { window.top.document.title = '☆☆☆☆☆☆'+message+'☆☆' }
          if (step == 0) { window.top.document.title = '☆☆☆☆☆☆☆☆'+message}
          step++;
          //window.top.document.title.backgroundColor="orange";
          st = setTimeout("flash_title('"+message+"')", 700);
      }
	
	var userId = ${sessionScope.USER.userId};
	var userName = '${sessionScope.USER.userName}';
	var userRealName = '${sessionScope.USER.userRealName}';
	
	PL.setDebug(false);
	
	function listen(){
	    PL.joinListen("/message/"+userId,userId,userName,userRealName);
	    setInterval("window.top.frames['topFrame'].document.getElementById('clock').innerHTML=new Date().toLocaleString();",1000);
	}
	
	function onEvent(event){
	    var onlineNumber = event.get("online_number");
	    if(onlineNumber){
	        document.getElementById("onlineNb").innerHTML = onlineNumber;
	    }
	}
	
	function onData(event){
	    var str = event.get("p_subject");
	    var userRealName = str.substring(str.lastIndexOf("/")+1,str.length);
	    var temp = str.substring(9,str.lastIndexOf("/"));
	    var senderId = temp.substring(temp.lastIndexOf("/")+1,temp.length);
	    var message = event.get("message");
	    flash_title(userRealName+":"+message);
	    setTimeout("clearFlash();",7000);
	    if(getDoc(senderId)){
	        if(getDoc("chatWindow").style.display=="block"){
	            if(senderId == getDoc("receiver").value){
	                fetchMessage(senderId);
	                clearFlash();
	            }
	        }else{
	            getDoc(senderId).style.backgroundColor="orange";
	        }
	    }else{
	       document.getElementById("onlineUserList").style.backgroundColor="orange";
	    }
	}
	
	function clearFlash(){
	    if(st != null){
	        clearTimeout(st);
	        window.top.document.title="ifan";
	    }
	}
	
	function fetchMessage(userId){
	    var url="<%=path%>/boryou/online_deliver.action";
	    var info="senderId="+userId;
	    var ajax=new Ajax(url,"POST",true,info);
	    ajax.dealResult=function(result){
	        if(result&&result.length>0){
	            generatorMes(eval(result),userId);
	        }
	    };
	    ajax.executeRequest();
	}
	
	function generatorMes(result,userId){
	    var content="";
	    if(getDoc("receiver").value==userId){
	         content = getDoc("chatHistory").value;
	    }
	    for(var i=0;i<result.length;i++){
	        content += result[i].senderName+"  " + window.top.frames['topFrame'].document.getElementById("clock").innerHTML+"\r"+result[i].message+"\r";
	    }
	    getDoc("chatHistory").value=content;
	    getDoc("chatHistory").scrollTop = getDoc("chatHistory").scrollHeight - getDoc("chatHistory").scrollWidth+100;//滚动
	}
	
	function leave(){
       PL.leave();
    }
	
	function showOnline(){
	    clearFlash();
	    document.getElementById("onlineUserList").style.backgroundColor="#edf0f8";
	    changePage("<%=path%>/boryou/online/online_user.jsp");
	    
	    
	}
	function getDoc(id){
	    return window.top.frames["mainFrame"].document.getElementById(id);
	}
	
	
	function changePage(url){
	    window.top.frames["mainFrame"].location.href = url;
	}
	
	</script>
</head>

<body onload="listen();return false;" onunload="leave();return false;">
<div class="oartop" align="right"> > </div>
<div style="float:left;width:130px;background:#edf0f8;border-right:0px #0f5599 solid;overflow:hidden;">
<table width="100%">
<tr>
<td valign="top" align="right">
<div align="right" border="1">
		<ul>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/notice_notice.action')"><b>系统首页</b></a></li>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/ShowImgServlet')"><b>今日菜单</b></a></li>
		<%if(user != null && user.getTypeId() < 3){ %>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/order_menu.action')"><b>菜单管理</b></a></li>
		<%} %>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/order_myorder.action')"><b>在线下单</b></a></li>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/order_list.action')"><b>当前订单</b></a></li>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/order_orderManage.action')"><b>订单管理</b></a></li>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/order_query.action')"><b>订单查询</b></a></li>
		<li><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/user_userManage.action')"><b>用户管理</b></a></li>
		<li id="messageBox"><a href="javascript:void()" onclick="changePage('<%=path %>/boryou/message_messageBox.action')"><b>消息盒子</b></a></li>
		
		 <li><a  id="onlineUserList" href="javascript:void(0)" onclick="showOnline()"><b>在线好友</b></a></li>
		 (<font id="onlineNb">0</font>)
		</ul>
	</div>
</td>
</tr>
</table>
</body>
</html>

