<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<title>씨밀레</title>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/webserver/css/user.css">
</head>
<body>
<a class="logo" href="http://localhost:8080/webserver/main.jsp" style="margin-top:5px;"><img src="http://localhost:8080/webserver/img/logo.png"></a>
    <%@ include file="../nav/navbar_backup.jsp" %>
	<div class="loginbox">
		<%
		String Email = request.getParameter("email");

		UsersDAO usersDAO = new UsersDAO();
		Users user = usersDAO.findUserByEmail(Email);
		//회원정보를 찾은 경우
		if (user != null) { %>
		<h3 class="ltitle">회원 정보를 찾았습니다.</h3>
		<hr>
		<div class="loginform">
			아이디는 &nbsp;
			<span class="find">
				<%out.println(user.getUser_id()); %>
			</span>		
			&nbsp;입니다.<br><br>비밀번호는&nbsp;
			<span class="find">
				<%out.println(user.getPassword());%>
			</span>
			&nbsp;입니다.<br><br>
			<div id="backbtn">
				<a class="back" href="http://localhost:8080/webserver/userct/login.jsp">로그인</a>
			</div>
				
		</div>
		<%}
		//찾지못한경우
		else {%>
			<h3 class="ltitle">일치하는 회원정보가 없습니다.</h3>
			<a class="back" href="http://localhost:8080/webserver/userct/findUser.jsp">뒤로가기</a>
		<%} %>
	</div>
</body>

