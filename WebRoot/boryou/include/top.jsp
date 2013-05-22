<%@ page language="java"  pageEncoding="utf-8"%>
<%@ page language="java" import="com.boryou.entity.*"%>
<%@ page language="java" import="com.boryou.util.*"%>
<% 
BOrderUser user = (BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
String path = request.getContextPath(); %>
	<script src="<%=path %>/boryou/js/jquery.js" type="text/javascript"></script>
	<script src="<%=path %>/boryou/js/global.js" type="text/javascript"></script>
	<script src="<%=path %>/boryou/js/AjaxObject.js" type="text/javascript"></script>
	<script src="<%=path %>/boryou/js/bootstrap-collapse.js"></script>
	
	<script src="<%=path %>/boryou/js/jquery.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-transition.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-alert.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-modal.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-dropdown.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-scrollspy.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-tab.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-tooltip.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-popover.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-button.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-collapse.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-carousel.js"></script>
    <script src="<%=path %>/boryou/js/bootstrap-typeahead.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
    <link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/bootstrap-responsive.min.css"/>
	
	
    
	<script type="text/javascript">
    function logout(){
         window.top.location.href="<%=path %>/boryou/user_logout.action";
    }
    function about(){
         var info_mes = "";
         info_mes += "\n";
         info_mes += "作者:  superkey";
         info_mes += "\n";
         info_mes += "Email: astro.liuhang@gmail.com";
         info_mes += "\n";
         info_mes += "QQ:    124915122";
         info_mes += "\n\n";
         info_mes += "欢迎提出改进建议以及反馈系统bug";
         alert(info_mes);
    }
    
    function changeActive(index){
        var ul = document.getElementById("nav-div").getElementsByTagName("ul")[0].getElementsByTagName("li");
        for(var i=0;i<ul.length;i++){
            if(index ==i){
                ul[i].className="active";
            }else{
                ul[i].className="";
            }
        }
     }
     
    </script>
 <div class="container">

      <!-- Static navbar -->
      <div class="navbar">
        <div class="navbar-inner">
          <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </a>
            <a class="brand" href="<%=path %>/boryou/login_notice.action">ifan</a>
            <div id="nav-div" class="nav-collapse collapse">
              <ul class="nav">
                <li><a href="<%=path %>/boryou/login_notice.action">系统首页</a></li>
                <li><a href="<%=path %>/boryou/order_myorder.action">在线下单</a></li>
                <li><a href="<%=path %>/boryou/order_list.action">当前订单</a></li>
                <li><a href="<%=path %>/boryou/order_query.action">订单查询</a></li>
                <li><a href="<%=path %>/ShowImgServlet" target="_blank">今日菜单</a></li>
                <%if(user != null && user.getTypeId() < 3){ %>
                <li><a href="<%=path %>/boryou/order_menu.action">菜单管理</a></li>
                <li><a href="<%=path %>/boryou/order_orderManage.action">订单管理</a></li>
                <%} %>
                <!--  
                <li class="dropdown">
                  <a href="javascript:void(0)" id="onlineUserList"  onclick="showOnline()" class="dropdown-toggle" data-toggle="dropdown">在线好友 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li>(<font id="onlineNb">0</font>)</li>
                  </ul>
                </li>
                -->
              </ul>
              <ul class="nav pull-right">
                <li><a href="<%=path %>/boryou/user_userManage.action">${sessionScope.USER.userName }</a></li>
                <li><a href="javascript:void()" onclick="about();">关于系统</a></li>
                <li><a href="javascript:void()" onclick="logout();">退出系统</a></li>
              </ul>
            </div><!--/.nav-collapse -->
          </div>
      </div>
    </div>
</div>