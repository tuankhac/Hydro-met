<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<jsp:useBean id="topmenu" class="neo.smartui.taglib.TreeView"
	scope="session" />
<jsp:useBean id="u" class="neo.velocity.common.ServiceUtility"
	scope="application" />
<%-- <jsp:setProperty name="n" property="language" value="${not empty param.language ? param.language : 'vi_VN'}"/> --%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="neo.velocity.common.ServiceUtility"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<% 
   //request.getSession().setMaxInactiveInterval(30* 60); 
   String path = application.getRealPath("/").replace('\\', '/');
   session.setAttribute("lang","en_US");
   request.setAttribute("pathroot",path);
   session.setAttribute("pathroot",path);
   //String lang = "";
   //if(request.getAttribute("language") == null){
   // lang = "vi_VN";
   //}else{
   // lang = request.getAttribute("language").toString();
   //}
   //request.setAttribute("language",lang); 
   //out.println(lang);
   
   //response.setHeader( "Set-Cookie abcg", "name=true; HttpOnly");
   String sessionid = request.getSession().getId();
   response.setHeader("Set-Cookie", "JSESSIONID=" + sessionid + "; Path=/; Secure; HttpOnly");
   %>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="refresh"
	content="<%= session.getMaxInactiveInterval() %>">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>${n.i18n.app_title}</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<link href="lte/plugins/iCheck/flat/_all.css" rel="stylesheet"
	type="text/css" />
<link href="lte/plugins/iCheck/flat/_all.css" rel="stylesheet"
	type="text/css" />

<link href="lte/assets/bootstrap/lte/css/AdminLTE.min.css"
	rel="stylesheet" type="text/css" />
<link href="lte/assets/bootstrap/lte/css/skins/skin-blue-light.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="lte/assets/bootstrap/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link href="lte/assets/bootstrap/plugins/datepicker/datepicker3.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="lte/assets/bootstrap/plugins/icomoon/style.css">

<link rel="stylesheet" href="style/chosen.min.css">
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
<!--LTE-->
<link href="lte/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<!--[if lt IE 8]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
<!-- <link href="lte/assets/bootstrap/css/jquery-ui.min.css" rel="stylesheet" /> -->
<script src="lte/assets/bootstrap/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="lte/assets/bootstrap/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="lte/assets/bootstrap/lte/js/app.min.js"
	type="text/javascript"></script>
<script src="lte/assets/bootstrap/plugins/chartjs/Chart.min.js"
	type="text/javascript"></script>
<script
	src="lte/assets/bootstrap/plugins/datepicker/bootstrap-datepicker.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="lte/assets/bootstrap/plugins/ckeditor/ckeditor.js"></script>


<!-- phan trang -->
<link rel="stylesheet" type="text/css" media="screen"
	href="style/page_template/page_templates.css" />
<script type="text/javascript"
	src="style/page_template/page_templates.js"></script>
<script src="style/chosen.jquery.min.js"></script>
<script>
         function Go(l){
            document.location.href=l;
         }
      </script>
</head>
<body class="skin-blue-light sidebar-mini">
	<div class="wrapper">
		<header class="main-header">
			<!-- Logo -->
			<a href="index.jsp" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>${n.i18n.app_name_small}</b></span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg">${n.i18n.app_name_large}</span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span>
				</a>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="lte/assets/bootstrap/user.png" class="user-image"
								alt="User Image" /> <span class="hidden-xs"><%=request.getUserPrincipal().getName() %></span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="lte/assets/bootstrap/user.png" class="img-circle"
									alt="User Image" />
									<p>
										<%=request.getUserPrincipal().getName() %>
										- Java Developer <small>NEO Member</small>
									</p></li>
								<li class="user-footer">
									<div class="pull-left">
										<a href="help.jsp" class="btn btn-default btn-flat">Help</a>
									</div>
									<div class="pull-right">
										<a href="logout" class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</ul></li>
					</ul>
				</div>
				<!--
            <div class ="navbar-custom-menu" >
               <ul class="nav navbar-nav">
                  <li class="dropdown user user-menu">            
                     <%-- <% 
                        String lang = "";
                        if(request.getParameter("language") == null) { 
                        if(request.getAttribute("language") == null){
                        lang ="vi_VN" ;
                        }else{
                        lang = request.getAttribute("language").toString() ;
                        }
                        }else{
                        lang = request.getParameter("language").toString();
                        }
                           //out.print(request.getParameter("language") +"\t"+lang);
                        if(lang.equals("vi_VN")){
                        out.println("<a href='javascript:void(0)' data-option='en_US'  id='Header_EN'>"
                        +"<img src='/style/img/icon_lang_en.gif' alt='English'>"
                        +"&nbsp;<span class='hidden-xs'>English</span></a>");
                        }else{
                        out.println("<a href='javascript:void(0)' data-option='vi_VN' id='Header_VN'>"
                        +"<img src='/style/img/icon_lang_vn.gif' alt='Vietnamese'>"
                        +"&nbsp;<span class='hidden-xs'>Tiếng Việt</span></a>");
                        }
                        request.setAttribute("language",lang); 
                        %> --%>
                  </li>
               </ul>
            </div>
			-->
				<br></br>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside id="sidebar" class="main-sidebar">
			<div id="dragbar"></div>
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- search form -->
				<form action="#" method="GET" class="sidebar-form" name="frmAgent">
					<div class="input-group">
						<input type="text" name="q" class="form-control"
							placeholder="Search..." /> <span class="input-group-btn">
							<button type='submit' name='search' id='search-btn'
								class="btn btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</form>
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<n:cache>
					<ul class="sidebar-menu">
						${topmenu.getBootstrapMenu("menu_service","top",pageContext.request.userPrincipal.name,"crud",pageContext.request.contextPath,not empty param.language ? param.language : 'vi_VN') }
					</ul>
				</n:cache>
			</section>
			<!-- /.sidebar -->
		</aside>
		<script>
         $('#Header_VN').on('click', function () {
            var $el = $(this);
            var currentURL = window.location.href;
            if(currentURL.indexOf("?")!=-1){
               if(currentURL.indexOf("language")==-1){
                  window.location.href = currentURL + "&language="+$el.data('option');
               }else{
                  if("${param.language}" != $el.data('option')){
                     currentURL = currentURL.replace("${param.language}",$el.data('option'));
                  }
                  window.location.href = currentURL ;
               }
            }
            else{
               window.location.href = currentURL + "?language="+$el.data('option');
            }   
         });
         $('#Header_EN').on('click', function () {
            var $el = $(this);
            var currentURL = window.location.href;
            if(currentURL.indexOf("?")!=-1){
               if(currentURL.indexOf("language")==-1){
                  window.location.href = currentURL + "&language="+$el.data('option');
               }else{
                  if("${param.language}" != $el.data('option')){
                     currentURL = currentURL.replace("${param.language}",$el.data('option'));
                  }
                  window.location.href = currentURL ;
               }
            }
            else{
               window.location.href = currentURL + "?language="+$el.data('option');
            } 
         });
      </script>