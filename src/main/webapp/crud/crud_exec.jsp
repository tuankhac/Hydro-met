<%@ taglib uri="/WEB-INF/neotag.tld" prefix="n"%><%@ page
	contentType="text/html; charset=utf-8" language="java"%><n:check
	value="${param.crud_type}" minLength="3" maxLength="200" type="string"
	exp="[0-9a-zA-Z_/.]+">CRUD Type không chính xác</n:check>
<n:velocity>#parse ("${param.crud_type}")</n:velocity>