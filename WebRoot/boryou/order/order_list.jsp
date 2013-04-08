<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="java.util.*"%>   
 <%@page language="java" import="com.boryou.util.*"%>  
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
<script src="<%=path %>/boryou/js/jquery.js" type="text/javascript"></script>
<script src="<%=path %>/boryou/js/global.js" type="text/javascript"></script>
<title>ifan</title>
<script type="text/javascript">


function cancelOrder(orderId){
if(window.confirm("确定要取消今天的订单？")){
    document.forms["orderListForm"].elements["orderId"].value=orderId;
    document.forms["orderListForm"].action="<%=path%>/boryou/order_cancelOrder.action";
    document.forms["orderListForm"].submit();
    }
}
      //弹出窗
     function pop(){
         var popBox=document.getElementById('popBox_list');
         var popMask=document.getElementById('popMask_list');
         var popbox01=document.getElementById('popbox01_list');
         popBox.style.display="block";
         popMask.style.display="block";
         popbox01.style.display="block";
      }
      //关闭弹出窗
      function closeSubmitWindow(){
         var popBox=document.getElementById('popBox_list');
         var popMask=document.getElementById('popMask_list');
         var popbox01=document.getElementById('popbox01_list');
         popBox.style.display="none";
         popMask.style.display="none";
         popbox01.style.display="none";
         return false;
      }
      

function checkAll(){
    var cbOrders=document.getElementsByName("cbCheckOrder");
    var cbCheckAll=document.getElementsByName("cbCheckAllOrders");
    for(var i=0;i<cbOrders.length;i++){
        cbOrders[i].checked=cbCheckAll[0].checked;
    }
}

function validateCheck(){
    var check=false;
    var cbCheckOrder=document.getElementsByName("cbCheckOrder");
    for(var i=0;i<cbCheckOrder.length;i++){
        if(cbCheckOrder[i].checked){
            check=true;
            break;
        }
    }
    return check;
}

function checkOrder(){
    if(validateCheck()){
       
       document.forms["orderListForm"].action="<%=path%>/boryou/order_checkOrder.action";
       document.forms["orderListForm"].submit();
    }else{
       alert("请至少选择一项订单");
       return false;
    }
}
var regexNoteChange = /^.{1,25}$/;
function updateNote(index,orderId) {
			var changeNote = document.getElementById("txtChangeNote" + index).value;
			var initChangeNote = document.getElementById("lblChangeNote" + index).innerHTML;
			
			if (!regexNoteChange.test(changeNote)) {
				alert("备注信息不能为空且小于25个字符！");
			} else {
			    document.forms["orderListForm"].elements["orderId"].value=orderId;
			    document.forms["orderListForm"].elements["changeNote"].value = changeNote;
				document.forms["orderListForm"].action="<%=path%>/boryou/order_updateNote.action";
			    document.forms["orderListForm"].submit();
			}
}


function toUpdateNote(index) {
			$("span[id=before" + index +"]").hide();
			$("span[id=after" + index +"]").show();
			
			var initChangeNote = $("#lblChangeNote" + index).text();
			$("#txtChangeNote" + index).val(initChangeNote);
		}
		
 function cancelUpdateNote(index) {
		$("span[id=before" + index + "]").show();
		$("span[id=after" + index + "]").hide();
		}

 $(function() {
			$("span[id^=after]").hide();
		});
		
</script>
</head>
<body>
<div class="oarcont">
<div class="oartop"><a>当前订单</a> </div>
<table border="0" cellspacing="0" cellpadding="0" class="rtable2" width="100%">
<tr>

    <td valign="top">
    <div class="rtabcont2">
	<div class="rnavtable6" style="margin-top:0px;">
	<div><font color="red">${requestScope.message }</font></div>		
	</div>	
	
	<form id="orderListForm" method="post">
	<input type="hidden" name="changeNote"/>
	<input type="hidden" name="orderId"/>
	  <%
	     List<BOrder> orderList =(List<BOrder>)request.getAttribute("orderList");
	     if(orderList!=null&&orderList.size()>0){
	     BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
	     %>
	    
	    <div>目前共有 <font color="red">${requestScope.totalNumber}</font> 份订单，加饭总数：  <font color="red"> ${requestScope.totalExtraNum} </font>份</div>
	    <div align="left">
	    <%
	    String logValue=(String)request.getAttribute("logValue");
	    if(user.getTypeId() < 3){
	        if(logValue==null){
	    %>
	    <input value="提交今天所有订单" onclick="pop()" type="button" />
	    <font color="red">*点击提交订单，所有人都不能继续下订单和取消订单。然后开始进行订单的结算</font>
	    <%  }else{
	    %>
	     <input value="结算订单" onclick="checkOrder()" type="button" />
	    <%  }
	    }
	    %>
	    </div>
	   
		<table width="90%" border="0" cellspacing="1" cellpadding="0" class="rtable2">
		  <tr class="tt">
		    <td width="5%"><input type="checkbox" name="cbCheckAllOrders" onclick="checkAll()" /> </td>
		    <td width="5%">序号</td>
		    <td width="10%">姓名</td>
		    <td width="15%" align="center">下单时间</td>
		     <td width="10%" align="center">加饭</td>
		     <td width="20%" align="center">留言</td>
		     <td width="10%" align="center">付款</td>
		     <td width="15%" align="center">找零备注</td>
		     <td width="10%" align="center">操作</td>
		       
		  </tr>
	  <!-- 列表部分 -->
	<%   
	     int index=0;
	     for(BOrder item:orderList){
	     
	   %>
	  	<tr>
	  	    <td width="5%">
	  	    <%if(item.getChecked()==0){ %>
	  	    <input type="checkbox" name="cbCheckOrder" value="<%=item.getOrderId() %>" /> 
	  	    <%} %>
	  	    </td>
		  	
		  	<td width="5%" align="center">
		  	<%=++index %>
	    	</td>
	    	
		    <td width="10%"> 
		     <%=item.getRealUsername() %>
		    </td>
		    
		    <td width="15%" align="center">
		    <%=item.getOrderTime().toString().substring(0,19)%>
		    
	    	</td>
	    	<td align="center" width="10%">&nbsp;
		    <%=item.getExtraNumber() %> 份
	    	</td>
	    	
	    	<td title="<%=item.getNote() %>" width="20%">
	    	<%if(item.getNote().length()>16){ %>
		    <%=item.getNote().substring(0,16) %> 
		    <%}else{ %>
		     <%=item.getNote() %> 
		    <% }%>
	    	</td>
	    	
	    	<td align="center" width="10%">
		    <%if(item.getChecked()==0){ %>
		    <font color="red">未支付</font>
		    <%}else{ %>
		    已支付
		    <%} %>
	    	</td>
	    	<td width="15%" align="center">
	    	<span id="before<%=index %>"><label id="lblChangeNote<%=index %>"><%if(item.getChangeNote()!=null&&item.getChangeNote()!=""){%><%=item.getChangeNote()%><%}%></label></span>
		    <span id="after<%=index %>"><input type="text" id="txtChangeNote<%=index %>" size="15" maxlength="20" /></span>
	    	</td>
	    	
	    	<td align="center" width="10%">
	    	<%
	    	if(logValue==null){
	    	    if(user!=null){
	    	        if(item.getUserId()==user.getUserId()){
	    	%>
	    	<input type="button" value="取消订单" onclick="javascirtp:cancelOrder(<%=item.getOrderId()%>)"/>
	    	<%
	    	        }
	    	    }
	    	}else if(user.getTypeId() < 3){
	    	%>
	    	<span id="before<%=index %>">
	    	<input type="button" value="备注" onclick="javascript:toUpdateNote(<%=index %>)"/>
	       
	        </span>
	        <span id="after<%=index %>">
	         <input type="button" value="保存" onclick="updateNote(<%=index %>,<%=item.getOrderId()%>)" />
	         <input type="button" value="取消" onclick="cancelUpdateNote(<%=index %>)"/>
	        </span>
	    	<%} %>
	    	</td>
	    	
		  </tr>
		  <%} %>
		</table>
		<%}else{%>
		  <font>今天还没有人下订单，您可以<a href="<%=path %>/boryou/order_myorder.action"><b>点此下单</b></a></font>
		  <%} %>
	</form>
	</div>
   <div id="popMask_list" style="background:#999; opacity:0.6; filter:alpha(opacity=60); width:100%; height:100%; position:absolute; top:0; left:0;display:none;"></div>
    <div id="popBox_list" style=" position:absolute; top:150px; left:0; width:100%;display:none;">
		<!-- 提交订单验证码 -->				
		 <div id="popbox01_list" class="popbox flacont2" style="display:none;">
		   <div class="title"><span><a onclick="closeSubmitWindow()" href="javascript:void(0);">关闭</a></span>提交订单</div>
		         <div class="mes">   
		        <form action="<%=path%>/boryou/order_submitOrder.action" method="post">
		        <table id="loginbox" width="100%" border="0" cellspacing="0" cellpadding="0" class="flatables2">
		        <tr>
		        <td class="f14">验证码:</td>
		        <td>
		        <input class="input2" type="text" name="vcode" style="width:45px"/>
		        <img src="<%=path %>/boryou/include/vcode.jsp" alt="点击切换" style="cursor: pointer;" onclick="this.src='<%=path %>/boryou/include/vcode.jsp?vc=' + Math.random()"/>
	            </td>
		         </tr>
				<tr class="tts2">
				<td align="right" colspan="2"><input type="submit" value="提交"/></td>
				</tr>                                
				</table> 
				</form>
				</div>   
    </div>
	</div>				 
	<div class="clear"></div>		
	</td>	
	</tr>
	</table>
</div>
</body>
</html>