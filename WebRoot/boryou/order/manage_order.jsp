<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="java.util.*"%>  
 <%@page language="java" import="com.boryou.util.*"%>  
 <%@page language="java" import="com.boryou.entity.*"%>   
<%@ page isELIgnored="false"%>
<%
String sdpath = request.getContextPath();

	int nowPage=(Integer)request.getAttribute("nowPage");
	long totalNum=(Long)request.getAttribute("totalNum");
	int totalDay=(Integer)request.getAttribute("totalDay");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>订单管理</title>
<script type="text/javascript">
   var nowPage=<%=nowPage%>;
   var totalNum=<%=totalNum%>;
   var totalDay=<%=totalDay%>;
	   
    function nextPage(){
	   if(nowPage>=totalDay){
	     // alert("已经是最后一页了");
	      return;
	   }else{
	      nowPage++;
	      refreshOrders(nowPage);
	      pageIndex(nowPage);
	   }
	}
	
	function pageUp(){
	   if(nowPage<=1){
	     // alert("已经是第一页了");
	      return;
	   }else{
	       nowPage--;
	       refreshOrders(nowPage);
	       pageIndex(nowPage);
	   }
	}
	
	function lastPage(){
	    if(nowPage>=totalDay){
	      //  alert("已经是最后一页了");
	        return;
	    }else{
	        refreshOrders(totalDay);
	        pageIndex(totalDay);
	        nowPage = totalDay;
	    }
	}
	    
	function firstPage(){
	    if(nowPage<=1){
	      //  alert("已经是第一页了");
	        return;
	    }else{
	        refreshOrders(1);
	        pageIndex(1);
	        nowPage = 1;
	    }
	}
	
	
	 function gotoPage(){
	      var page=document.getElementById("pageIndex").value;
	      if(!isNaN(page)){
	          if(page<=0||page>totalDay){
	              alert("超出页码范围");    
	      }else{
	           refreshOrders(page);
	           nowPage = page;
	      }
	      }else{
	           alert("输入页数不合法");    
	      }
    }
	
	function selectAll(){
	    var cbsa = document.getElementById("cbSelectAll");
	    var cbs = document.getElementsByName("cbSelectOne");
	    for(var i =0;i<cbs.length;i++){
	        cbs[i].checked = cbsa.checked;
	    }
	}
	
	function cbValidate(){
	    var cbs = document.getElementsByName("cbSelectOne");
	    var checked = false;
	    for(var i =0;i<cbs.length;i++){
	        if(cbs[i].checked){
	            checked = true;
	            break;
	        }
	    }
	    return checked;
	}
	
	function delOrder(){
	    if(cbValidate()){
	        if(window.confirm("确定要删除吗?")){
	            document.forms["historyForm"].elements["nowPage4Del"].value=nowPage;
	            document.forms["historyForm"].action="<%=sdpath%>/boryou/order_delOrder.action";
	            document.forms["historyForm"].submit();
	        }
	    }else{
	        alert("请至少选择一项删除");
	    }
	}
	
	function refreshOrders(nowPage){
	    var url = "<%=sdpath%>/boryou/order_orderManageAjax.action";
	    var info = "nowPage="+nowPage;
	    var ajax = new Ajax(url,"POST",false,info);
	    ajax.dealResult = function(result) {
	        if(result){
	            generatorOrders(eval(result));
	        }
	    }
	    ajax.executeRequest();
	}
	
	function generatorOrders(result){
	    var content = '<table class="table table-striped table-hover">';
	    content += '<tr>';
		content += '<td align="left" width="5%"><input type="checkbox" id="cbSelectAll" onclick="javascript:selectAll()"/></td>';
		content += '<td width="5%" >序号</td>';
		content += '<td width="10%">姓名</td>';
		content += '<td width="15%" align="center">下单时间</td>';
		content += '<td width="10%" align="center">加饭</td>';   
		content += '<td width="25%" align="center">留言</td>';
		content += '<td width="8%" align="center">付款</td>';
		//content += '<td width="15%" align="center">找零备注</td>';  
		content += '</tr>';
	    for(var i=0;i < result.length;i++){
	        var order = result[i];
	        content += '<tr>';
	        content += '<td><input type="checkbox" name="cbSelectOne" value="' + order.id +'" /></td>';
	        content += '<td width="5%" align="center">' + (i+1) + '</td>';
	        content += '<td>' + order.userRealName + '</td>';
	        content += '<td>' + order.orderTime + '</td>';
	        content += '<td>' + order.extraNum + '</td>';
	        content += '<td title="' + order.completeNote + '">' + order.note + '</td>';
	        content += '<td align="center">' + order.checked + '</td>';
	        //content += '<td>' + order.changeNote + '</td>';
	        content += '</tr>';
	    }
	    var order_div = document.getElementById("orderTable");
	    order_div.innerHTML = content;
	}
	
	function pageIndex(page){
	    document.getElementById("pageIndex").value = page;
	}


</script>
</head>
<body onload="refreshOrders(nowPage);changeActive(6);return false;">
<%@include file="../include/top.jsp" %>
<div class="container">
<div class="oartop" ><a>订单管理</a> </div>
   <div><font color="red">${requestScope.message} </font></div>
	   <div class="page1"><span>第 <input type="text" id="pageIndex" size="7" value="<%=nowPage %>"  /> 
	天 <input  onclick="javascript:gotoPage()"  type="button" class="btn" value="GO" />　　<a class="fblue2" href="javascript:firstPage()">昨天</a>　<a class="fblue2" href="javascript:pageUp()">前一天</a>　<a class="fblue2" href="javascript:nextPage()">后一天</a>　<a class="fblue2" href="javascript:lastPage()">最初一天</a>
	</span>共<font class="fred2"><%=totalNum %></font>条历史记录 
	共<font class="fred2"><%=totalDay %></font>天的历史记录</div>	
	
	   <%if(user.getTypeId() < 3){ %>
	   <br/>
	   <div><input class="btn btn-danger" type="button" name="delOrder" id="delOrder" onclick="javascript:delOrder()" value="删除"/></div>
	   <div class="alert">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>注意!</strong> 删除订单数据，将不可恢复
        </div>
	   <%} %>
	   <br/>
	    <form name="historyForm" id="historyForm" method="post" >
	    <input type="hidden" name="nowPage4Del" value="<%=nowPage %>"/>
	    <div id="orderTable" >这天没有订单记录</div>
		</form>
</div>
</body>
</html>