<jsp:useBean id="crud" class="neo.velocity.common.CRUDService"
	scope="request" /><%@ page contentType="text/html; charset=utf-8"
	language="java"%>
${crud.make(param.id,param.table,param.owner,"crud",param.path)}
