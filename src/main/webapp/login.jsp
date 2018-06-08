<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="n" class="neo.velocity.common.NeoContext"
	scope="application" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${n.i18n.app_title}</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<link href="lte/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />

<link href="lte/assets/bootstrap/lte/css/AdminLTE.min.css"
	rel="stylesheet" type="text/css" />
<link href="lte/assets/bootstrap/lte/css/skins/skin-blue-light.min.css"
	rel="stylesheet" type="text/css" />
<!-- <link
	href="lte/assets/bootstrap/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" /> -->

<!-- <link rel="stylesheet"
	href="lte/assets/bootstrap/plugins/icomoon/style.css"> -->
</head>

<script src="lte/assets/bootstrap/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- <script src="lte/assets/bootstrap/js/bootstrap.min.js"
	type="text/javascript"></script> -->
<!-- <script src="lte/assets/bootstrap/plugins/chartjs/Chart.min.js"
	type="text/javascript"></script> -->
</head>
<body class="login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="index.jsp"><b>${n.i18n.app_name_large}</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">Sign in to System</p>
			<form action="" method="post">
				<div class="form-group has-feedback">
					<input type="text" class="form-control input-lg"
						placeholder="User name" name="username" id="username" /> <span
						class="glyphicon glyphicon-user form-control-feedback"></span>
					<!--a href="javascript:sendotp()">
				<font style="font-size:9px;font-color:darkblue;text-decoration:none">${n.i18n.app_name_get_otp}</font></a-->
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control input-lg"
						placeholder="Password" name="password" /> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
					<!-- <font
						style="font-size: 10px; font-color: darkblue; text-decoration: none">M&#7853;t
						kh&#7849;u: &lt;M&#7853;t kh&#7849;u&gt;</font> -->
				</div>
				<div class="row">
					<div class="col-xs-8">
						<!--gia tri cu IncorrectCredentialsException-->
						<%
							if (request != null) {
								String rep = (String) request.getAttribute("loginResult");
								//out.println(rep);
								if (rep != null) {
									//out.println(rep);
									if (rep.contains("Exception")) {
										//out.println(rep);
										out.println(n.getI18n().get(rep));
									}
								}
							}
						%>
					</div>
					<!-- /.col -->
					<div class="col-xs-4">
						<button type="submit" class="btn btn-success btn-block btn-flat">Sign
							In</button>
					</div>
					<!-- /.col -->
				</div>
			</form>

		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
	<!-- jQuery 2.1.4 -->
	<!-- <script src="lte/assets/bootstrap/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	Bootstrap 3.3.2 JS
	<script src="lte/assets/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	iCheck
	<script src="lte/assets/bootstrap/plugins/iCheck/icheck.min.js"
		type="text/javascript"></script>
	-->
	<script>
		

		
	</script>
</body>
</html>
