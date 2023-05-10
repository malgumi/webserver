<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="css/main.css">
<title>씨밀레</title>
</head>
<body>
<!-- 테스트 주석 -->
	<div>
		<h1>씨밀레</h1>
		<jsp:include page="nav/navbar.jsp"/> <!-- 네비바 -->
		
		<div class="container"> <div class="row">
		<!-- 이곳에 글 목록 출력 -->
			<div>
	<table class="posttable">
		<thead>
			<tr>
				<th>글 번호</th>
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
				for(Post post : postList){
			%>
			<tr>
				<td><%=post.getPost_id()%></td>
				<td><a href="post.jsp?post_id=<%=post.getPost_id()%>"><%=post.getPost_title()%></a></td>
				<td><%=post.getUser_id()%></td>
				<td><%=post.getDate()%></td>
			</tr>
			<%}%>
		</tbody>
	</table>
</div>

		</div></div>
		
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>