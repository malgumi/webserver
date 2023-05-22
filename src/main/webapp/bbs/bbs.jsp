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

		<div class="container">
		<p class="board">자유게시판</p>
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
			ArrayList<Post> postList = postDAO.getList(pageNumber);
			BoardDAO boardDAO = new BoardDAO();
			for(Post post : postList){
				if (post.getBoard_id() == 1) { // board_id가 1인 글만 출력
		%>
			<tr>
				<td><%=post.getPost_id()%></td>
				<td><a href="http://localhost:8080/webserver/view.jsp?post_id=<%= post.getPost_id()%>" style="text-decoration: none; color: black;"><%=post.getPost_title()%></a></td>
				<td><%=post.getUser_id()%></td>
				<td><%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + "시" + post.getDate().substring(14,16) + "분" %></td>
			</tr>
			<%}
			}%>
		</tbody>
	</table>
<%
			int cnt = postDAO.Paging(); //게시판에 존재하는 전체 글 수
			int pageBlock = 10; //한 페이지에 보여줄 글 수
				if(cnt>pageBlock){ //전체 글 수가 한 페이지에 보여지는 글 수보다 많다면
					
					//추가 페이지 번호 표시
					int pageCount = cnt / pageBlock + (cnt%pageBlock==0?0:1); //전체 페이지수 계산
					int startPage = ((pageNumber-1)/pageBlock)*pageBlock+1; //시작 페이지 계산
					int endPage = startPage + pageBlock - 1; //끝 페이지 계산
					if(endPage > pageCount){
						endPage = pageCount;
					}
			%>
			
			<!-- 다음, 이전 페이지 버튼 만들기 -->
			<% if(pageNumber!=1){ %> <!-- 첫번째 페이지가 아니라면 -->
				<a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>">이전</a>
			<%} %>
			<% for(int i=startPage; i<=endPage; i++){ %>
				<a href="bbs.jsp?pageNumber=<%= i%>"><%= i%></a>
			<%} %>
			<% if(postDAO.nextPage(pageNumber+1)){ %> <!-- 다음 페이지가 있다면 -->
				<a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>">다음</a>
			<%} %>
			
			<%} %>
							
			<a href="write.jsp" class="button">글쓰기</a>
		</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/bootstrap.js"></script>

</body>
</html>