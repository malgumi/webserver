<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://localhost:8080/webserver/css/main.css">

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
			<div class="logo"><ul>
				<li><a href="http://localhost:8080/webserver/main.jsp"><img src="http://localhost:8080/webserver/img/logo.png"></a></li>
			</ul></div>
			<div class="menu"><ul>
				<li><a href="http://localhost:8080/webserver/notice/notice_bbs.jsp">공지사항</a></li>
				<li><a href="http://localhost:8080/webserver/bbs/bbs.jsp">자유게시판</a></li>
				<li><a href="http://localhost:8080/webserver/adv/adv_bbs.jsp">홍보게시판</a></li>
			</ul></div>
			<div class="loginmenu">
				<%
				if(user_id == null) {
			%>
			<ul>
				<li><a href="#">접속하기</a>
					<ul class="dropdown-menu">
						<li><a href="http://localhost:8080/webserver/login.jsp">로그인</a></li>
						<li><a href="http://localhost:8080/webserver/join.jsp">회원가입</a></li>
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
						<li><img src="https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E" style="width:80px; height:80px; border-radius:50%; overflow: hidden;"></li>
						
						<li><a href="http://localhost:8080/webserver/Userpage/password_Userpage.jsp">회원정보관리</a></li>
						<li><a href="http://localhost:8080/webserver/logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<% 
				}
			%>
			</div>
		</div>
	</nav>

</body>
</html>