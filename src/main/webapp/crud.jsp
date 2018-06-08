<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/neotag.tld" prefix="n"%>
<jsp:useBean id="n" class="neo.velocity.common.NeoContext"
	scope="session" />
<n:check value="${param.crud_type}" minLength="3" maxLength="200"
	type="string" exp="[0-9a-zA-Z_/.]+">Tham số không chính xác, vui lòng kiểm tra lại!</n:check>
<html>

<%@include file="header.jsp"%>
<shiro:authenticated>
	<!--value="${sessionScope.lang}" -->
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="main content-header">
			<h1>${n.i18n(param.crud_type)}</h1>
		</section>
		<section class="main content">
			<div class="row">
				<div class="col-md-12">
					<!-- Block buttons -->
					<div class="box box-primary">
						<div class="box-body no-padding">
							<%--  <% 
            String role ="";
            List<Map<String,String>> list_roles = 
            ServiceUtility.ref("get_all_role_by_user","default",
              new String[]{request.getUserPrincipal().getName(),request.getRequestURI()+"?"+request.getQueryString()},2);
              for (Map<String, String> map : list_roles) {
              for (Map.Entry<String, String> entry : map.entrySet()) {
              String key = entry.getKey();
              role += entry.getValue();
            }
          }
          //System.out.println("ra di nao "+role + "   "+request.getQueryString());
		  //role ="DULIEU,";
          %>
          <shiro:hasAnyRoles name="<%=role%>"> --%>
							<n:velocity>
          #parse ("${param.crud_type}")
        </n:velocity>
							<%-- </shiro:hasAnyRoles> --%>
							<%-- <shiro:lacksRole name="<%=role%>"><h1 align="center">You don't have role to enter this menu</h1></shiro:lacksRole> --%>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /. row -->
		</section>
	</div>
	<!-- /.content-wrapper -->
	</div>
	<!-- ./wrapper -->
	<%@include file="footer.jsp"%>
</shiro:authenticated>