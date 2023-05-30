<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%
	int board_id = 0;
	if(request.getParameter("board_id") != null){
		board_id = Integer.parseInt(request.getParameter("board_id"));
	}
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 시도입니다. 다시 시도해주세요.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
%>

<div class="container">
	<p class="board">
		<%
			BoardDAO boardDAO = new BoardDAO();
			String board_name = boardDAO.getBoard_title(board_id);
		%>
		<span><%= board_name %></span>
	</p>

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
		    String searchKeyword = request.getParameter("search");
		    ArrayList<Post> postList;
		    if (searchKeyword != null && !searchKeyword.isEmpty()) {
		        postList = postDAO.getSearchList(searchKeyword, pageNumber, board_id);
		    } else {
		        postList = postDAO.getListByBoard(board_id, pageNumber);
		    }
		    for (Post post : postList) {
		        if (post.getBoard_id() == board_id) {
		%>
			<tr>
				<td><%=post.getPost_id()%></td>
				<td><a href="http://localhost:8080/webserver/bbs/view.jsp?post_id=<%= post.getPost_id()%>" style="text-decoration: none; color: black;"><%=post.getPost_title()%></a></td>
				<td><%=post.getUser_id()%></td>
				<td><%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + "시" + post.getDate().substring(14,16) + "분" %></td>
			</tr>
		<%
				}
			}
		%>
		</tbody>
	</table>
 
<%
	int cnt;
	if (searchKeyword != null && !searchKeyword.isEmpty()) {
		cnt = postDAO.getSearchCount(searchKeyword, board_id);
	} else {
		cnt = postDAO.Paging(board_id); // 게시판에 존재하는 전체 글 수
	}
	int pageBlock = 10; // 한 페이지에 보여줄 글 수
	if (cnt > pageBlock) { // 전체 글 수가 한 페이지에 보여지는 글 수보다 많다면
		// 추가 페이지 번호 표시
		int pageCount = cnt / pageBlock + (cnt % pageBlock == 0 ? 0 : 1); // 전체 페이지수 계산
		int startPage = ((pageNumber - 1) / pageBlock) * pageBlock + 1; // 시작 페이지 계산
		int endPage = startPage + pageBlock - 1; // 끝 페이지 계산
		if (endPage > pageCount) {
			endPage = pageCount;
		}
%>

<!-- 다음, 이전 페이지 버튼 만들기 -->
<% if (pageNumber != 1) { %> <!-- 첫번째 페이지가 아니라면 -->
	<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=<%= board_id %>&pageNumber=<%= pageNumber - 1 %>&user_id=<%= user_id %>">이전</a>
<% } %>
<% for (int i = startPage; i <= endPage; i++) { %>
	<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=<%= board_id %>&pageNumber=<%= i %>&user_id=<%= user_id %>"><%= i %></a>
<% } %>
<% if (postDAO.nextPage(pageNumber + 1, board_id)) { %> <!-- 다음 페이지가 있다면 --> 
	<a href="http://localhost:8080/webserver/bbs/bbs.jsp?board_id=<%= board_id %>&pageNumber=<%= pageNumber + 1 %>&user_id=<%= user_id %>">다음</a>
<% } %>

<% } 
	Users user = new UsersDAO().getUserdata(user_id); %>
<% if (board_id != 3) { %>
<a href="http://localhost:8080/webserver/bbs/write.jsp?board_id=<%= board_id %>" class="button">글쓰기</a>
<% } else if(session.getAttribute("user_id")!=null && board_id == 3 && user.getPermission() == 2){ %> <!-- 공지사항 게시판일 시, 관리자에게만 글쓰기 버튼 활성화 -->
<a href="http://localhost:8080/webserver/bbs/write.jsp?board_id=<%= board_id %>" class="button">글쓰기</a>
<% } %>

</div>

	<!-- 검색 기능 추가 -->
	<form class="search-form" method="get" action="http://localhost:8080/webserver/bbs/bbs.jsp" class="search-form">
		<input type="hidden" name="board_id" value="<%= board_id %>">
		<input type="text" name="search" placeholder="검색어를 입력하세요">
		<button type="submit">검색</button>
	</form> 
</body>
</html>
