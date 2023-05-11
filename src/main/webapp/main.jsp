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
<link rel="stylesheet" href="css/main.css">
<title>씨밀레</title>
</head>
<body>
		<h1 style="padding-top: 10px;"><img src="http://localhost:8080/webserver/img/logo.png"></h1>
		<jsp:include page="nav/navbar.jsp"/> <!-- 네비바 -->
		
		<!-- 이곳에 글 목록 출력 -->
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
				String boardTitle = boardDAO.getBoardTitle(post.getBoard_id());
		%>
			<tr>
				<td><%=boardTitle%></td>
				<td><a href="http://localhost:8080/webserver/view.jsp?post_id=<%= post.getPost_id()%>" style="text-decoration: none; color: black;"><%=post.getPost_title()%></a></td>
				<td><%=post.getUser_id()%></td>
				<td><%=post.getDate()%></td>
			</tr>
			<%}%>
		</tbody>
	</table>
</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>