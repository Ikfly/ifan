<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false"%>
<%@page import="java.util.*"%>
<%@page import="com.boryou.entity.*"%>
<%@page import="java.text.SimpleDateFormat;"%>

<% SimpleDateFormat sf4Show=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	
	
	int nowPage=(Integer)request.getAttribute("nowPage");
	long totalNum=(Long)request.getAttribute("totalNum");
	int pageSize=(Integer)request.getAttribute("pageSize");	
	long senderId=(Long)request.getAttribute("senderId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>ifan</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />

				
<script type="text/javascript">
    var nowPage=<%=nowPage%>;
    var totalNum=<%=totalNum%>;
    var pageSize=<%=pageSize%>;
    var senderId=<%=senderId%>;
    var pageNum;
    
    if(totalNum%pageSize==0){
	     pageNum=totalNum/pageSize;
	   }else{
	      pageNum=((totalNum-(totalNum%pageSize))/pageSize)+1;
	   }
	   
    function nextPage(){
   
	   if(nowPage>=pageNum){
	      alert("已经是最后一页了");
	      return;
	   }else{
	   var url="<%=path%>/boryou/message_messageDetail.action?senderId="+senderId+"&nowPage="+(nowPage+1);
	      window.location.href=url ;
	   }
	}
	
	function pageUp(){
	   if(nowPage<=1){
	      alert("已经是第一页了");
	      return;
	   }else{
	   var url="<%=path%>/boryou/message_messageDetail.action?senderId="+senderId+"&nowPage="+(nowPage-1);
	      window.location.href=url ;
	   }
	}
	
	function lastPage(){
	    if(nowPage>=pageNum){
	        alert("已经是最后一页了");
	        return;
	    }else{
	    var url="<%=path%>/boryou/message_messageDetail.action?senderId="+senderId+"&nowPage="+pageNum;
	    window.location.href=url ;
	    }
	}
	    
	function firstPage(){
	    if(nowPage<=1){
	        alert("已经是第一页了");
	        return;
	    }else{
	    var url="<%=path%>/boryou/message_messageDetail.action?senderId="+senderId+"&nowPage="+1;
	    window.location.href=url ;
	    }
	}
	
	
	 function gotoPage(){
	      var page=document.getElementById("pageIndex").value;
	      if(!isNaN(page)){
	          if(page<=0||page>pageNum){
	              alert("超出页码范围");    
	      }else{
	             var url="<%=path%>/boryou/message_messageDetail.action?senderId="+senderId+"&nowPage="+page;
	             window.location.href=url ;
	      }
	      }else{
	           alert("输入页数不合法");    
	      }
    }
	
</script>
</head>
<body>
<div class="oarcont">
<div class="oartop"><a href="<%=path %>/boryou/message_messageBox.action">消息盒子</a> &gt; 消息详情</div>
<table border="0" cellspacing="0" cellpadding="0" class="rtable2" width="100%">
<tr>
<td valign="top">

<div class="rnavtable6">
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="rtable2" align="center">
<% List<BMessage> list=(List<BMessage>)request.getAttribute("result");
    if(list!=null&&list.size()>0){
        for(BMessage item:list){
 %>
<tr class="tt">
<td colspan="2"><b><%=item.getSenderName() %></b>(<%=sf4Show.format(item.getSendTime())%>)</td>

</tr>
<tr>
<td colspan="2"><%=item.getMessage() %></td>
</tr>
<tr>
<td colspan="3">

</td>
</tr>
<%    }
   }%>
</table>
<div class="page1"><span>第 <input type="text" id="pageIndex" size="7" value="<%=nowPage %>"  /> 
	页 <input  onclick="javascript:gotoPage()"  type="button" value="GO" />　　<a class="fblue2" href="javascript:firstPage()">第一页</a>　<a class="fblue2" href="javascript:pageUp()">上一页</a>　<a class="fblue2" href="javascript:nextPage()">下一页</a>　<a class="fblue2" href="javascript:lastPage()">最后一页</a>
	</span>共<font class="fred2"><%=totalNum %></font>条消息 每页<font class="fred2"><%=pageSize %></font>条，
	共<font class="fred2"><%if(totalNum%pageSize==0){
    %><%=totalNum/pageSize %><%}else{%>
	<%=totalNum/pageSize+1%>
	<%}%></font>页</div>

		<div class="clear"></div>
	</div>
	</td>
	</tr>
</table>
</div>
</body>
</html>
