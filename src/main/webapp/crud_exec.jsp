<%@ taglib uri="/WEB-INF/neotag.tld" prefix="n"%><%@ page
	contentType="text/html; charset=utf-8" language="java"%><n:check
	value="${param.crud_type}" minLength="3" maxLength="200" type="string"
	exp="[0-9a-zA-Z_/.]+">CRUD Type không chính xác</n:check><%@ taglib
	prefix="shiro" uri="http://shiro.apache.org/tags"%><%-- <%@ page import="java.util.ArrayList" %><%@ page import="neo.velocity.common.ServiceUtility"%><%@ page import="java.util.List"%><%@ page import="java.util.Map"%><% String role =""; List<Map<String,String>> list_roles = ServiceUtility.ref("get_all_role_by_user","default",new String[]{request.getUserPrincipal().getName(),request.getRequestURI()+"?"+request.getQueryString()},2); for (Map<String, String> map : list_roles) {	for (Map.Entry<String, String> entry : map.entrySet()) { String key = entry.getKey(); role += entry.getValue();	}}%><shiro:hasAnyRoles name="<%=role%>"> --%>
<n:velocity>#parse ("${param.crud_type}")</n:velocity>
<%-- </shiro:hasAnyRoles><shiro:lacksRole name="<%=role%>">You don't have role</shiro:lacksRole> --%>