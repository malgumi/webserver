<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="file.FileDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="http://localhost:8080/webserver/css/main_backup.css">
<title>씨밀레</title>
</head>
<body style="background-color: #fffdf2;">
	<br><a class="logo" href="http://localhost:8080/webserver/main.jsp"><img src="http://localhost:8080/webserver/img/logo2.png"></a><br>
	<%@ include file="../nav/navbar_backup.jsp" %>
			<div class="slideshow">
			<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=3"><img src="/webserver/img/main1.png"></a>
			<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=1"><img src="/webserver/img/main2.png"></a>
			<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=2"><img src="/webserver/img/main3.png"></a>
		</div>
	<div class="container"> 
	<p style="font-size: 40px; text-align: center;">최신 홍보글</p><br>
<div class="container" style="flex-direction: row; flex-wrap: wrap; justify-content: space-between;">
    <%
    PostDAO postDAO = new PostDAO();
    ArrayList<Post> postList2;
    postList2 = postDAO.getListByBoard(2, pageNumber);
    int count = 0; // 불러온 게시물 수를 세는 변수

    for (Post post : postList2) {
        if (post.getBoard_id() == 2) {
            FileDAO fileDAO = new FileDAO();
            String fileRealName = fileDAO.getFileRealName(post.getPost_id());
    %>
    <div>
        <p><a href="http://localhost:8080/webserver/bbs/view.jsp?post_id=<%= post.getPost_id()%>" style="text-decoration: none; color: black;"><img src="./img/<%= fileRealName %>" onerror="this.src='./img/default.PNG'" width="300px" height="300px" style="border: 1px solid #ddd;"><br><%=post.getPost_title()%></a></p>
        <p><%=post.getUser_id()%></p>
        <p><%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + "시" + post.getDate().substring(14,16) + "분" %></p>
    </div>
    <br>
    <%
            count++;
            if (count >= 3) { // 3개 이상 불러왔을 경우 루프 종료
                break;
            }
        }
    }
    %>
</div>

<br><br>
<hr>
<br><br> 
		<!-- 글 목록 테이블 -->
		<p style="font-size: 40px; text-align: center;">전체글</p><br><br>
		<table class="posttable" style="margin-bottom: 30px;"> 
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
			postDAO = new PostDAO();
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
			// 5초마다 슬라이드 전환
			setTimeout(startSlideshow, 5000);
		}

		// 슬라이드쇼 시작
		startSlideshow();
	</script>
</body>
</html>