<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>씨밀레</title>
</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
	<h2 style="text-align: center;">관리자 전용 페이지입니다.</h2>
	<%
		if(user_id == null || !user_id.equals("admin")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 페이지는 관리자만이 접속 가능합니다.')");
			script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
	%>

			<div class="container">
	<table class="posttable">
		<thead>
			<tr>
				<th>게시판</th>
				<th>글 제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<!-- 글 목록 출력 -->
		<tbody>
		<%
			PostDAO postDAO = new PostDAO();
			ArrayList<Post> postList = postDAO.getList(1);
			BoardDAO boardDAO = new BoardDAO();
			for(Post post : postList){
				String board_title = boardDAO.getBoard_title(post.getBoard_id());
		%>
			<tr>
				<td><%=board_title%></td>
				<td><a href="http://localhost:8080/webserver/bbs/view.jsp?post_id=<%= post.getPost_id()%>" style="text-decoration: none; color: black;"><%=post.getPost_title()%></a></td>
				<td><%=post.getUser_id()%></td>
				<td><%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + "시" + post.getDate().substring(14,16) + "분" %></td>
			</tr>
			<%}%>
		</tbody>
	</table>
</div>

</body>
</html>