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
	<a class="logo" style="margin-top: 100px; margin-bottom: 50px;" href="http://localhost:8080/webserver/main.jsp"><img src="http://localhost:8080/webserver/img/logo2.png"></a>
	<%@ include file="../nav/navbar_backup.jsp" %>
			<div class="slideshow" style="margin-top: 30px;">
			<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=1"><img src="/webserver/img/main1.png"></a>
			<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=1"><img src="/webserver/img/main2.png"></a>
			<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=2"><img src="/webserver/img/main3.png"></a>
		</div> 
	<div class="container">

		<!-- 글 목록 테이블 -->
		<p style="font-size: 40px; text-align: center;">최신글 목록</p>
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
			ArrayList<Post> postList = postDAO.getListTen();
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

	<script>
		// 슬라이드쇼 이미지 전환을 위한 변수 및 설정
		var slideIndex = 0;
		var slides = document.querySelectorAll('.slideshow img');

		// 슬라이드쇼 시작 함수
		function startSlideshow() {
			// 이미지 숨김 처리
			for (var i = 0; i < slides.length; i++) {
				slides[i].style.display = 'none';
			}
			// 다음 이미지 표시
			slideIndex++;
			if (slideIndex > slides.length) {
				slideIndex = 1;
			}
			slides[slideIndex - 1].style.display = 'block';
			// 3초마다 슬라이드 전환
			setTimeout(startSlideshow, 5000);
		}

		// 슬라이드쇼 시작
		startSlideshow();
	</script>
</body>
</html>