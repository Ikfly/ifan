<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>
 <%@page language="java" import="java.util.*"%>   
 <%@page language="java" import="com.boryou.util.*"%>  
 <%@page language="java" import="com.boryou.entity.*"%>   
<%@ page isELIgnored="false"%>
<%

List<BOrder> result = (List<BOrder>)request.getAttribute("result");
String sdpath = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sdpath+"/";
String selectCheck = (String)request.getSession().getAttribute(Constant4Web.QUERY_SELECT);
int nowPage=(Integer)request.getAttribute("nowPage");
long totalNum=(Long)request.getAttribute("totalNum");	
int pageSize=(Integer)request.getAttribute("pageSize");	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%=sdpath %>/boryou/datepickerHH/WdatePicker.js" defer="defer"></script>

<title>订单查询</title>
<script type="text/javascript">
    
    var nowPage=<%=nowPage%>;
    var totalNum=<%=totalNum%>;
    var pageSize=<%=pageSize%>;
    var pageNum;
    if(totalNum % pageSize == 0){
	     pageNum=totalNum/pageSize;
	   }else{
	      pageNum=((totalNum-(totalNum%pageSize))/pageSize)+1;
	   }
	   
    function nextPage(){
   
	   if(nowPage>=pageNum){
	    //  alert("已经是最后一页了");
	      return;
	   }else{
	   var url="<%=sdpath%>/boryou/order_query.action?nowPage="+(nowPage+1);
	      window.location.href=url ;
	   }
	}
	
	function pageUp(){
	   if(nowPage<=1){
	    //  alert("已经是第一页了");
	      return;
	   }else{
	   var url="<%=sdpath%>/boryou/order_query.action?nowPage="+(nowPage-1);
	      window.location.href=url ;
	   }
	}
	
	function lastPage(){
	    if(nowPage>=pageNum){
	      //  alert("已经是最后一页了");
	        return;
	    }else{
	    var url="<%=sdpath%>/boryou/order_query.action?nowPage="+pageNum;
	    window.location.href=url ;
	    }
	}
	    
	function firstPage(){
	    if(nowPage<=1){
	    //    alert("已经是第一页了");
	        return;
	    }else{
	    var url="<%=sdpath%>/boryou/order_query.action?nowPage="+1;
	    window.location.href=url ;
	    }
	}
	
	
	 function gotoPage(){
	      var page=document.getElementById("pageIndex").value;
	      if(!isNaN(page)){
	          if(page<=0||page>pageNum){
	              alert("超出页码范围");    
	      }else{
	             var url="<%=sdpath%>/boryou/order_query.action?nowPage="+page;
	             window.location.href=url ;
	      }
	      }else{
	           alert("输入页数不合法");    
	      }
    }

	function queryOrder(){
	    document.forms["QueryForm"].action="<%=sdpath%>/boryou/order_query.action";
	    document.forms["QueryForm"].submit();
	}
	
	function exportExcel(){
	    document.forms["QueryForm"].action="<%=sdpath%>/boryou/order_exportOrder.action";
	    document.forms["QueryForm"].submit();
	}
</script>
</head>
<body onload="changeActive(3)"> 
<%@include file="../include/top.jsp" %>
<div class="container">
    <div class="oartop"><a>订单查询</a> </div>
    </br>
    <form id="QueryForm" method="post" class="form-inline">
    <lable>开始时间: </lable>
    <input name="startTime"  class="Wdate" type="text" onfocus="WdatePicker({isShowClear:false,readOnly:true, skin:'whyGreen'})" size="5" value="${sessionScope.QUERY_STARTTIME }" />
    <lable>截止时间: </lable>
	<input name="endTime" class="Wdate" type="text" onfocus="WdatePicker({isShowClear:false,readOnly:true, skin:'whyGreen'})" size="5" value="${sessionScope.QUERY_ENDTIME }" />
	<lable>姓名</lable>
	<input id="userRealName" name="userRealName" type="text" value="${sessionScope.QUERY_USERNAME}" />
	<select name="checkSelect">
	<option value="-1" <% if(selectCheck.equals("-1")){%> selected="selected" <%}%>>全部</option>
	<option value="0" <% if(selectCheck.equals("0")){%> selected="selected" <%}%>>未付款</option>
	<option value="1" <% if(selectCheck.equals("1")){%> selected="selected" <%}%>>已付款</option>
	</select>
	<input name="query" class="btn btn-primary" type="button" value="查询" onclick="javascript:queryOrder()" /></td>
	<input name="exportToExcel" class="btn" type="button" value="导出" onclick="javascript:exportExcel()"/>
	</form>
	  <div><font color="red">${requestScope.message}</font></div>
	 <div><span>第 <input type="text" id="pageIndex" size="3" value="<%=nowPage %>"  /> 
	页 <input  onclick="javascript:gotoPage()"  type="button" class="btn" value="GO" />　　<a class="fblue2" href="javascript:firstPage()">第一页</a>　<a class="fblue2" href="javascript:pageUp()">上一页</a>　<a class="fblue2" href="javascript:nextPage()">下一页</a>　<a class="fblue2" href="javascript:lastPage()">最后一页</a>
	</span>共<font class="fred2"><%=totalNum %></font>条记录 每页<font class="fred2"><%=pageSize %></font>条，
	共<font class="fred2"><%if(totalNum%pageSize==0){
    %><%=totalNum/pageSize %><%}else{%>
	<%=totalNum/pageSize+1%>
	<%}%></font>页</div>
		<table width="100%" class="table table-striped table-hover">
		  <tr>
		    <td width="5%"><b>序号</b></td>
		    <td width="10%"><b>姓名</b></td>
		    <td width="15%" align="center"><b>下单时间</b></td>
		     <td width="20%" align="center"><b>留言</b></td>
		     <td width="8%" align="center"><b>付款</b></td>
		     <td width="15%" align="center"><b>找零备注</b></td>
		  </tr>
	<%int index = 0;
	if(result != null && result.size()>0 ){
	    for(BOrder item : result){ 
	   %>
	  	<tr>
		  	<td width="5%" align="center">
		  <%=++index %>
	    	</td>
		    <td>
		     <%=item.getRealUsername() %>
		    </td>
		    
		    <td align="center">
		  <%=item.getOrderTime().toString().substring(0,19) %>
		    
	    	</td>
	    	<td align="center">&nbsp;
		   <%=item.getNote() %>
	    	</td>
	    	
	    	<td align="center">
		    <%if(item.getChecked() == 0 ){ %>
		    <font color="red">未支付</font>
		    <%}else{ %>
		    已支付
		   <%} %>
	    	</td>
	    	<td align="center">
	    	<%if(item.getChangeNote() !=null){ %>
	    	   <%=item.getChangeNote() %>
	    	<%} %>
	    	</td>
		  </tr>
		  <%}
		  } %>
		</table>
</div>
</body>
</html>