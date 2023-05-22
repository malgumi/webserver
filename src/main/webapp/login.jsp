<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">


<title>씨밀레</title>

<link rel="stylesheet" type="text/css" href="./css/user.css">


</head>
<body>
<%@ include file="./nav/navbar.jsp" %>

<% String link = request.getHeader("referer"); %>
	<div class="loginbox">
		<form method="post" action="loginAction.jsp">
			<h3 class="ltitle">로그인</h3>
			<hr>
			<div class="loginform">
				<label>
					아이디<br><br>
					<input type="text" class ="insert" placeholder="아이디를 입력하세요" name="user_id" maxlength="20">
				</label><br><br>
				<label>
					비밀번호<br><br>
					<input type="password" class ="insert" placeholder="비밀번호를 입력하세요" name="password" maxlength="20">
				</label>
				<br><br>
				
				<input type="hidden" name="link" value=<%= link %>>
				<br><br>
				<input type="submit" value="로그인하기" id="loginbtn">
			</div>
		</form>
		
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</body>
</html>