<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%String sdpath = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>在线好友</title>
	<script type="text/javascript">
	
	document.onkeypress = function(event){
	var   e   =   event||window.event; 
    var   k   =   e.which||e.keyCode;
	var   ele   = e.target||e.srcElement; 
    switch(k)
    {
      case   13:
	   switch(ele.id){
	       case "chatInput":
	             sendMessage();
		         break;
	   }
       break;
    }
  };
	
	var regR = /\r/g;
    var regN = /\n/g;
	function sendMessage(){
	    var inputValue=document.getElementById("chatInput").value;
	    inputValue=inputValue.replace(/(^\s*)/g,"");
	    if(inputValue.length==0){
	        document.getElementById("chatInput").value="";
	        return false;
	    }
	    if(document.getElementById("chatInput").value.length>50){
	        alert("一次消息不要超过50字");
	        return false;
	    }
	    document.getElementById("chatHistory").value+="我："+ window.top.frames['topFrame'].document.getElementById('clock').innerHTML+"\r" + document.getElementById("chatInput").value+"\r";
	    var url="<%=sdpath%>/boryou/online_sendMessage.action?receiver=" + document.getElementById("receiver").value;
	    var inputMes = document.getElementById("chatInput").value;
        inputMes = inputMes.replace(regR,"\\r").replace(regN,"\\n");
	    var info="chatInput="+inputMes;
	    var ajax=new Ajax(url,"POST",false,info);
	    ajax.dealResult=function(result){
	        
	    };
	    ajax.executeRequest();
	    document.getElementById("chatHistory").scrollTop = document.getElementById("chatHistory").scrollHeight - document.getElementById("chatHistory").scrollWidth - 90;//滚动
	    document.getElementById("chatInput").value="";
	}
	
	function chatwith(userId){
	    if(document.getElementById("receiver").value!=userId){
	        clearText();
	    }
	    fetchMessage(userId);
	    document.getElementById(userId).style.backgroundColor="#edf0f8";
	    var userName = document.getElementById(userId).innerHTML;
	    document.getElementById("receiver").value=userId;
	    document.getElementById("chatTitle").innerHTML="与"+userName+"聊天中";
	    document.getElementById("chatWindow").style.display="block";
	   // document.getElementById("popbox01").style.display="block";
	    //pup('popbox01');
	}
	
	function closeWindow(windowId){
	    document.getElementById(windowId).style.display="none";
	}
	
	function clearText(){
	    document.getElementById("chatInput").value="";
	    document.getElementById("chatHistory").value="";
	}
	
	function fetchOnlineUser(){
	    var url="<%=sdpath%>/boryou/online_fetchOnline.action";
	    var info ="";
	    var ajax=new Ajax(url,"GET",true,info);
	    ajax.dealResult=function(result){
	        if(result && result.length>0){
	            generatorOnlineList(eval(result));
	        }
	    };
	    ajax.executeRequest();
	}
	
	function generatorOnlineList(result){
	    //document.getElementById("onlineNb").innerHTML=result.length;
	       var content="<table border='1' width='100%' align='center'>";
	       for(var i=0;i<result.length;i++){
	            var user=result[i];
	            content+="<tr><td align='center'>";
	            content+="<a href='javascript:void(0)' onclick='javascript:chatwith("+user.id+")'><span id='"+user.id+"'>("+user.userName+ ")</span></a>"
	            content+="</td></tr>";
	       }
	       content+="</table>"
	       document.getElementById("userList").innerHTML=content;
	}
	
	
	function generatorMesSenders(senderId){
	     if(getDoc(senderId)){
	          setTimeout("flash("+senderId+");",100);
	          setTimeout("flash("+senderId+");",300);
	          setTimeout("flash("+senderId+");",500);
	          setTimeout("flash("+senderId+");",700);
	          setTimeout("flash("+senderId+");",900);
	          setTimeout("flash("+senderId+");",1100);
	          setTimeout("flash("+senderId+");",1300);
	          if(document.getElementById("chatWindow").style.display=="block"){
	              if(getDoc("receiver").value==senderId){
	                  fetchMessage(senderId);
	              }
	          }
	      }
	 }

	function flash(id){
	     var item = document.getElementById(id);
	     if(item){
	       if(item.style.backgroundColor!="orange"){
		       item.style.backgroundColor="orange";
		   }else{
		       item.style.backgroundColor="#edf0f8";
		   }
	     }
	}
	
	function fetchMessage(userId){
	    var url="<%=sdpath%>/boryou/online_deliver.action";
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
	    if(document.getElementById("chatWindow").style.display=="block"){
	        if(document.getElementById("receiver").value==userId){
	            content = document.getElementById("chatHistory").value;
	        }
	    }
	    for(var i=0;i<result.length;i++){
	        content += result[i].senderName+"  " + window.top.frames['topFrame'].document.getElementById("clock").innerHTML+"\r"+result[i].message+"\r";
	    }
	    document.getElementById("chatHistory").value=content;
	    document.getElementById("chatHistory").scrollTop=document.getElementById("chatHistory").scrollHeight-document.getElementById("chatHistory").scrollWidth+100;//滚动
	}
	</script>
</head>
<body onload="fetchOnlineUser();changeActive(7);return false;">
<%@include file="../include/top.jsp" %>
<div class="container">
<div class="oartop"><a>在线好友</a> </div>
<table class="table">
<tr>
	<td valign="top" colspan="2" >
	
	</td>
	</tr>
	<tr>
	<td width="15%" align="left">
		<div id="userList" align="center">
	</div>
	</td>
	<td>


<div id="chatWindow" style="display:none" align="center">
	<div style='align:right; width:100%;height:20px;line-height:25px;color:#333;font:bold 14px "宋体";background-color:#e8e8e8;margin:0px auto;padding:5px 0 0 0px;'>
          <font id="chatTitle"></font>
         <a onclick="closeWindow('chatWindow')" href="javascript:void(0)">关闭</a> 
         </div>
	    <form id="chatForm" name="chatForm" method="post" >
	    <input type="hidden" id="receiver" name="receiver" />
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="flatables2">
        <tr class="tts2">
         <td align="center">
             <textarea id="chatHistory" name="chatHistory" style="resize:none;font-size:14px;" readonly="readonly"  rows="5" cols="50" ></textarea>
            </td>
          </tr>
            <tr class="tts2">
            <td align="center">
             <textarea id="chatInput" name="chatInput" style="resize:none;font-size:14px;"  rows="5" cols="50" ></textarea>
            </td>
          </tr>
          <tr class="tts2">
            <td align="right"> 
             <input type="button" value="清空" onclick="clearText()" />
             <input type="button" value="关闭" onclick="closeWindow('chatWindow')" />
             <input type="button" value="发送" onclick="sendMessage()" />
            </td>
          </tr>
         </table>
        </form>
   </div>

	</td>
	</tr>
</table>


</div>

</body>
</html>