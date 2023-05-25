<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="users.Users" %>
<%@ page import="users.UsersDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="../css/main.css">
<title>씨밀레</title>
</head>


<!-- 23.01.21 유말그미 추가 -->
<body style ="background-color:#f5f1ee;">
<%@ include file="../nav/navbar.jsp" %>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	
	<% 
		Users user = new UsersDAO().getUserdata(user_id);
	if (user_id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = '../login.jsp'");
		script.println("</script>");
	}
	%>
	<!--왜 깃에 안올라가지   -->
	
	<div class="container">
		<div>
			<div style="margin-top:100px;">
				<form method="post" action="update_UserAction.jsp?user_id=<%= user_id %>">
					<h3 style="text-align: center;">회원 정보 수정</h3> 
					<hr>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span >아이디</span><br>
						<input type="text" disabled="disabled" value =<%= user.getUser_id() %> style="width: 258px; border:none;">
					</label>
						<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span >비밀번호</span><br>
						<input type="password" name="password" maxlength="50" style="width: 258px; border:none;" value="<%=user.getPassword()%>">	
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>이름</span><br>
						<input type="text" placeholder="이름" name="name" maxlength="50" style="width: 258px; border:none;" value="<%= user.getName() %>">		
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>이메일</span><br>
						<input type="email" placeholder="이메일" name="email" maxlength="50" style="width: 258px; border:none;" value="<%= user.getEmail() %>">		
					</label>
					<br><br>
					<input onclick="return confirm('수정하시겠습니까?')" type="submit" class="btn btn-primary pull-right" value="수정하기">
				</form>
			</div>
		</div>
	</div>

</body>
</html>