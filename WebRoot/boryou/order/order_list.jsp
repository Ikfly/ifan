<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="java.util.*"%>   
 <%@page language="java" import="com.boryou.util.*"%>  
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
	
<title>当前订单</title>
<script type="text/javascript">


function cancelOrder(orderId){
if(window.confirm("确定要取消今天的订单？")){
    document.forms["orderListForm"].elements["orderId"].value=orderId;
    document.forms["orderListForm"].action="<%=sdpath%>/boryou/order_cancelOrder.action";
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
       
       document.forms["orderListForm"].action="<%=sdpath%>/boryou/order_checkOrder.action";
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
				document.forms["orderListForm"].action="<%=sdpath%>/boryou/order_updateNote.action";
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

</script>
</head>
<body onload="changeActive(2)">
<%@include file="../include/top.jsp" %>
<div class="container">
<div class="oartop"><a>当前订单</a> </div>
<table border="0" cellspacing="0" cellpadding="0" class="table table-striped table-hover" width="100%">
<tr>

    <td valign="top">
    <div class="rtabcont2">
	<div class="rnavtable6" style="margin-top:0px;">
	<div>
	
	<font color="red">${requestScope.message }</font>
	
	</div>	
	
	</div>	
	
	<form id="orderListForm" method="post">
	<input type="hidden" name="changeNote"/>
	<input type="hidden" name="orderId"/>
	  <%
	     List<BOrder> orderList =(List<BOrder>)request.getAttribute("orderList");
	     if(orderList!=null&&orderList.size()>0){
	     %>
	    
	    <div>目前共有 <font color="red">${requestScope.totalNumber}</font> 份订单，加饭总数：  <font color="red"> ${requestScope.totalExtraNum} </font>份</div>
	    <br/>
	    <div align="left">
	    <%
	    String logValue=(String)request.getAttribute("logValue");
	    if(user.getTypeId() < 3){
	        if(logValue==null){
	    %>
	    <!-- Button to trigger modal -->
        <input href="#myModal" role="button" type="button" class="btn btn-danger" data-toggle="modal" value="提交订单"/>
	    <div class="alert">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>注意!</strong> 点击提交订单，所有人都不能继续下订单和取消订单。
        </div>
	    <%  }else{
	    %>
	     <button class="btn btn-primary" onclick="checkOrder()">结算订单</button>
	    <%  }
	    }
	    %>
	    </div>
	   
		<table class="table">
		  <tr>
		    <td width="5%"><input type="checkbox" name="cbCheckAllOrders" onclick="checkAll()" /> </td>
		    <td width="5%">序号</td>
		    <td width="10%">姓名</td>
		    <td width="15%" align="center">下单时间</td>
		     <td width="10%" align="center">加饭</td>
		     <td width="20%" align="center">留言</td>
		     <td width="10%" align="center">付款</td>
		     <!--  
		     <td width="15%" align="center">找零备注</td>
		     -->
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
	    	<!-- 
	    	<td width="15%" align="center">
	    	<span id="before<%=index %>"><label id="lblChangeNote<%=index %>"><%if(item.getChangeNote()!=null&&item.getChangeNote()!=""){%><%=item.getChangeNote()%><%}%></label></span>
		    <span id="after<%=index %>"><input type="text" id="txtChangeNote<%=index %>" size="15" maxlength="20" /></span>
	    	</td>
	    	-->
	    	<td align="center" width="10%">
	    	<%
	    	if(logValue==null){
	    	    if(user!=null){
	    	        if(item.getUserId()==user.getUserId()){
	    	%>
	    	
	    	<button class="btn btn-warning" onclick="javascirtp:cancelOrder(<%=item.getOrderId()%>)">取消订单</button>
	    	<%
	    	        }
	    	    }
	    	}else if(user.getTypeId() < 3){
	    	%>
	    	<!-- 
	    	<span id="before<%=index %>">
	    	<input type="button" value="备注" onclick="javascript:toUpdateNote(<%=index %>)"/>
	       
	        </span>
	        <span id="after<%=index %>">
	         <input type="button" value="保存" onclick="updateNote(<%=index %>,<%=item.getOrderId()%>)" />
	         <input type="button" value="取消" onclick="cancelUpdateNote(<%=index %>)"/>
	        </span>
	         -->
	    	<%} %>
	    	</td>
	    	
		  </tr>
		  <%} %>
		</table>
		<%}else{%>
		  <font>今天还没有人下订单，您可以<a class="btn" href="<%=sdpath %>/boryou/order_myorder.action"><b>点此下单</b></a></font>
		  <%} %>
	</form>
	</div>
  	 
	</td>	
	</tr>
</table>
	

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">提交订单</h3>
  </div>
  <div class="modal-body">
    <form action="<%=sdpath%>/boryou/order_submitOrder.action" method="post" class="form-inline">
	<lable>验证码:</lable>
    <input class="input2" type="text" name="vcode" style="width:45px"/>
	<img src="<%=sdpath %>/boryou/include/vcode.jsp" alt="点击切换" style="cursor: pointer;" onclick="this.src='<%=sdpath %>/boryou/include/vcode.jsp?vc=' + Math.random()"/>
	<input type="submit" value="提交" class="btn"/>
	</form>
   </div>
</div>
	
</div>
</body>
</html>