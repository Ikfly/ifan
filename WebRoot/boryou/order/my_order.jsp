<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="java.util.*"%>   
 <%@page language="java" import="com.boryou.entity.*"%>   
<%@ page isELIgnored="false"%>

<%
String sdpath = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sdpath+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>在线下单</title>
<script type="text/javascript">
function myOrder(){
     window.location.href="<%=sdpath%>/OrderServlet";
}

</script>

<script type="text/javascript">

var shields = /^[\s\S]*?<\/?script>[\s\S]*?$/;
function order(){
    var extraNum=document.getElementById("extraNum").value;
    var note=document.getElementById("note").value;
    var tips=document.getElementById("checkTips");
    if(extraNum.length > 1){
        if(isNaN(extraNum)){
            tips.innerHTML="加饭数目请输入整数数字";
            return false;
        }
        if(extraNum.length > 2){
             tips.innerHTML="加饭数量限制在个位数";
             return false;
        }
    }
    document.forms["orderForm"].elements["extraRiceNum"].value=extraNum;
    if(note.length>49){
        tips.innerHTML="备注字数不要超过50个字";
        return false;
    }
    note = note.replace("<script>","");
    note = note.replace("<\/script>","");
    document.forms["orderForm"].action="<%=sdpath%>/boryou/order_order.action";
    document.forms["orderForm"].submit();
}


function cancelOrder(){
    window.location.href="<%=sdpath%>/boryou/order_cancelOrder.action";
}

</script>
</head>
<body onload="changeActive(1)">
<%@include file="../include/top.jsp" %>
<div class="container">
<div class="oartop"><a>在线下单</a> </div>
<br/>
<div>
    <font color="red">${requestScope.message }</font>
	<font id="checkTips" color="red"></font>
</div>
	<form id="orderForm" method="post" class="form-horizontal">
	 <input type="hidden" name="extraRiceNum"/>
	  <div class="control-group">
	    <label class="control-label">加饭:</label>
	     <div class="controls">
           <input type="text" id="extraNum" name="extraNum" placeholder="0"/>
         </div>
	  </div>
	  <div class="control-group">
	     <lable class="control-label">备注:</lable>
	     <div class="controls">
           <textarea style="resize:none" id="note" name="note" rows="3" cols="40"></textarea>
         </div>
	  </div>
	  <div class="control-group">
	     <div class="controls">
           <input type="button" value="提交" class="btn btn-primary" onclick="order()" />  
         </div>
	  </div>
	  </form>
	</div>
</body>
</html>