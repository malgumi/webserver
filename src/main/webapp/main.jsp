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
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="./css/main.css">
<title>씨밀레</title>
</head>
<body>
		<a class="logo" style="margin-top: 5px;" href="http://localhost:8080/webserver/main.jsp"><img src="http://localhost:8080/webserver/img/logo.png"></a>
		<%@ include file="../nav/navbar.jsp" %>
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
				<td><%= post.getUser_id() %></td>
				<td><%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + "시" + post.getDate().substring(14,16) + "분" %></td>
			</tr>
			<%}%>
		</tbody>
	</table>
</div>

</body>
</html>