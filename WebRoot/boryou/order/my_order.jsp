<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="java.util.*"%>   
 <%@page language="java" import="com.boryou.entity.*"%>   
<%@ page isELIgnored="false"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />
<title>ifan</title>
<script type="text/javascript">
function myOrder(){
     window.location.href="<%=path%>/OrderServlet";
}

</script>

<script type="text/javascript">
function addExtreRice(){
  var extra=document.getElementById("extraRice");
  var extraSpan=document.getElementById("extraSpan");
  var extraRadios=document.getElementsByName("extraRadioNum");
  if(extra.checked){
      extraSpan.style.display="block";
      for(var i=0;i<extraRadios.length;i++){
          extraRadios[i].disabled=true;
      }
  }else{
      for(var i=0;i<extraRadios.length;i++){
          extraRadios[i].disabled=false;
      }
       extraSpan.style.display="none";
       document.getElementById("extraNum").value="";
  }
} 


var shields = /^[\s\S]*?<\/?script>[\s\S]*?$/;

function order(){
    var extra=document.getElementById("extraRice");
    var extraNum=document.getElementById("extraNum").value;
    var note=document.getElementById("note").value;
    var tips=document.getElementById("checkTips");
    if(extra.checked){
        if(isNaN(extraNum)){
            tips.innerHTML="加饭数目请输入整数数字";
            return false;
        }
        if(extraNum.length==0){
            tips.innerHTML="请输入正整数";
            return false;
        }
        if(extraNum.length>1){
           if(extraNum<0){
               tips.innerHTML="请输入正整数";
               return false;
           }
           tips.innerHTML="您吃不了这么多";
           return false;
        }
        document.forms["orderForm"].elements["extraRiceNum"].value=extraNum;
    }else{
        document.forms["orderForm"].elements["extraRiceNum"].value="";
    }
    if(note.length>49){
        tips.innerHTML="备注字数不要超过50个字";
        return false;
    }
    note = note.replace("<script>","");
    note = note.replace("<\/script>","");
    document.forms["orderForm"].action="<%=path%>/boryou/order_order.action";
    document.forms["orderForm"].submit();
}


function cancelOrder(){
       window.location.href="<%=path%>/boryou/order_cancelOrder.action";
}

</script>
</head>
<body>
<div class="oarcont">
<div class="oartop"><a>在线下单</a> </div>
<table border="0" cellspacing="0" cellpadding="0" class="rtable2" width="100%">
<tr>
	<td valign="top" >
	<div class="rnavtable6" style="margin-top:0px;">
	<div class="rtabcont2">
	<form id="orderForm" method="post">
	<input type="hidden" name="extraRiceNum"/>
	<div><font color="red">${requestScope.message }</font>
	<font id="checkTips" color="red"></font>
	<br/>
	</div>
		<table width="80%" border="1" cellspacing="0" cellpadding="0" class="rtable2">
		   <tr class="tt">
		    <td class="f14" colspan="2">订单:</td>
		  </tr>
		  <tr>
		    <td width="22%" class="f14">加饭:<img src="<%=path %>/boryou/img/rice.jpg"/> </td>
		    <td  width="50%">
		    <span id="chooseSpan">
		    <input type="radio"  name="extraRadioNum" checked="checked"  value="0"/>
		    <label>不多加</label>
		     &nbsp
		    <input type="radio" name="extraRadioNum"  value="1"/>
		    <label>加1份</label>
		     &nbsp
		    <input type="radio" name="extraRadioNum" value="2"/>
		    <label>加2份</label>
		     &nbsp
		    </span>
		    <input type="checkbox" id="extraRice"  onclick="addExtreRice()" />
		    <label>其它</label>
		      <span id="extraSpan" style="display:none">
		      加
		      <input type="text" id="extraNum" name="extraNum" size="5" />
		      份
		      </span>
		    </td>
		  </tr>
		   <tr>
		    <td width="22%" class="f14">备注:</td>
		    <td  width="50%">
		      <textarea style="resize:none" id="note" name="note" rows="3" cols="40"></textarea>
		    </td>
		  </tr>
		  <tr>
		    <td class="f14">&nbsp;</td>
		    <td>
		       <input type="button" value="提交"  onclick="order()" />  
		    </td>
		  </tr>
		</table>
		</form>
	</div>
	</td>
	</tr></table>
	</div>
</body>
</html>