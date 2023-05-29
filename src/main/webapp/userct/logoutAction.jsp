<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="users.UsersDAO" %>
 <%@ page import="java.io.PrintWriter" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>씨밀레</title>
</head>

<body>
	<%
		session.invalidate(); //로그아웃하는 회원들 세션 뺏기
		response.sendRedirect("http://localhost:8080/webserver/main.jsp"); //로그아웃시 메인 페이지로 돌아가
	%>
</body>

</html>