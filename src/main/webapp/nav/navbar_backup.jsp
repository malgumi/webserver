<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://localhost:8080/webserver/css/main_backup.css">

<title>씨밀레</title>
</head>
<body>
	<%
		String user_id = null;
		if(session.getAttribute("user_id")!=null){
			user_id = (String) session.getAttribute("user_id");
		}
		int pageNumber = 1; //기본 첫 페이지
		if (request.getParameter("pageNumber") != null){ //파라미터가 넘어오면 페이지 넘버 삽입
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav>
		<div class="nav">
			<div class="menu"><ul>
				<li><a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=3">공지사항</a></li>
				<li><a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=1">자유게시판</a></li>
				<li><a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=2">홍보게시판</a></li>
				<li class="loginmenu">
				<%
				if(user_id == null) {
			%>
			<ul>
				<li><a style="font-size: 18px; text-decoration: none; color: black;" href="#">접속하기</a>
					<ul class="dropdown-menu">
						<li><a href="http://localhost:8080/webserver/userct/login.jsp">로그인</a></li>
						<li><a href="http://localhost:8080/webserver/userct/join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
				else {
					UsersDAO UserDAO = new UsersDAO();
					
					Users user = new UsersDAO().getUserdata(user_id);
			%>
			<ul>
				<li><a href="#">회원관리</a>
					<ul class="dropdown-menu">
						<li style="color: white;"><%= user_id %></li>
						<hr>
						<li><a href="http://localhost:8080/webserver/Userpage/password_Userpage.jsp">회원정보<br>관리</a></li>
						<li><a href="http://localhost:8080/webserver/userct/logoutAction.jsp">로그아웃</a></li>
						<% if (user.getPermission() == 2) { %>
							<li><a href="http://localhost:8080/webserver/bbs/adminpage.jsp">관리자<br>페이지</a></li>
						<% } %>
					</ul>
				</li>
			</ul>
			<% 
				}
			%>
			</li>
			</ul>
			</div>
			
		</div>
	</nav>

</body>
</html>