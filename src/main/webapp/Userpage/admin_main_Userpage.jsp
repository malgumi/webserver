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
<body>
<a class="logo" href="http://localhost:8080/webserver/main.jsp" style="margin-top:5px;"><img src="http://localhost:8080/webserver/img/logo.png"></a>
    <%@ include file="../nav/navbar_backup.jsp" %>
	
	<% 
		request.setCharacterEncoding("UTF-8");
    	String userId = request.getParameter("user_id");
		Users user = new UsersDAO().getUserdata(userId);
	if (userId == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = '../login.jsp'");
		script.println("</script>");
	}
	%>
	<div class="container" style="width: 60%;">
			<div style="margin-top:80px;">
				<form method="post" action="admin_update_UserAction.jsp?user_id=<%= userId %>" style="margin-top: 50px; border:1px solid #c2c2c2; background-color: white; text-align: center;">
					<h3 style="text-align: center; background-color: #f5f2ea; padding: 10px 0px 10px 0px;"><%= userId %> 회원 정보 수정</h3> 
					<label style="text-align: left; font-size: 14px; color: #666">
						<br><span >아이디</span><br>
						<input type="text" disabled="disabled" value =<%= user.getUser_id() %> style="width: 258px; border:none;">
					</label>
						<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span >비밀번호</span><br>
						<input type="text" name="password" maxlength="50" style="width: 40%" value="<%=user.getPassword()%>">	
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>이름</span><br>
						<input type="text" placeholder="이름" name="name" maxlength="50" style="width: 40%" value="<%= user.getName() %>">		
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>이메일</span><br>
						<input type="email" placeholder="이메일" name="email" maxlength="50" style="width: 40%" value="<%= user.getEmail() %>">		
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>권한</span><br>
						<input type="number" placeholder="권한" name="permission" maxlength="2" style="width: 40%" value="<%= user.getPermission() %>">		
					</label>
					<br><br>
					<input onclick="return confirm('수정하시겠습니까?')" type="submit" class="button" value="수정하기"><br><br>
				</form>
		</div>
	</div>

</body>
</html>