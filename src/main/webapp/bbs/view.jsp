<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %> 
<%@ page import="comment.Comment" %>
<%@ page import="post.PostDAO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="users.Users" %>
<%@ page import="users.UsersDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="file.FileDTO" %>
<%@ page import="file.FileDAO" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>

<!-- 게시글 보기 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>씨밀레</title>
</head>

<body>
<a class="logo" href="http://localhost:8080/webserver/main.jsp" style="margin-top:5px;"><img src="http://localhost:8080/webserver/img/logo.png"></a>
    <%@ include file="../nav/navbar_backup.jsp" %>
	<%
		String link = request.getHeader("referer");
		int post_id = 0;
		if(request.getParameter("post_id") != null){ //post_id가 존재한다면
			post_id = Integer.parseInt(request.getParameter("post_id")); //post_id에 그걸 담아서 처리할 수 있게 함
		}
		if(post_id == 0){ //0이니까 post_id가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
		Post post = new PostDAO().getPost(post_id); //해당 글 가져옴
		if(post == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
		if(post.getAvailable() == 0){ // 삭제된 글일경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제된 글입니다.')");
			script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
		
		FileDAO fileDAO = new FileDAO();
	    String fileRealName = fileDAO.getFileRealName(post_id);
	%>
	
	
	<div class="container">
		<p class="board">
			<% BoardDAO boardDAO = new BoardDAO();
			String board_name = boardDAO.getBoard_title(post.getBoard_id());
			%>
			<span><%= board_name %></span>
		</p>
		<table class="viewtable">
			<tr><th colspan="2"><%= post.getPost_title()%></th></tr>
			<tr class="viewect">
				<td>작성자: <%= post.getUser_id() %> <br> 작성일: <%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + ":" + post.getDate().substring(14,16) %></td>	
			</tr>
			<tr>
				<td>
				<% 
			if (fileRealName != null) { %>
		<img src="../img/<%= fileRealName %>" alt="이미지"><br>
				<% } %>
				<%= post.getPost_content().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %></td>
			</tr>
		</table>
		<br><br>
		<p class="board">댓글 목록</p> 
		<table class="commenttable">
			<tr>
				<th>작성자</th>
				<th>내용</th>
				<th></th>
			</tr>
			<%
						CommentDAO CommentDAO = new CommentDAO();
			ArrayList<Comment> list = CommentDAO.comment_getList(post_id);
			for (Comment comment : list) { // 향상된 for문 사용
		%>
		<tr>
			<td style="text-align: center;"><%= comment.getUser_id() %></td>
			<td style="text-align: center;"><%= comment.getComment_content() %></td>
				<td style="text-align: end; font-size: 10px; color: gray;"><%= comment.getDate().substring(0,11) + comment.getDate().substring(11, 13) + "시" + comment.getDate().substring(14,16) + "분" %>&nbsp;&nbsp;&nbsp;
				<a href="http://localhost:8080/webserver/bbs/comment_deleteAction.jsp?comment_id=<%= comment.getComment_id() %>"
    style="color: red; text-decoration: none;"
    onclick="return confirm('정말 삭제하시겠습니까?');">
    삭제
</a>
</td>
			</tr>
			<% } %>
		</table>

		<div>
		<!-- 댓글 입력 -->
		<% if (user_id != null) { %>
		<form method="post" action="http://localhost:8080/webserver/bbs/commentAction.jsp?post_id=<%= post_id %>">
			<table style="text-align: center; border: 1px solid #dddddd; width: 100%"> 
				<tr>						
					<td><textarea class="commentform" placeholder="댓글을 입력하세요." name="comment_content" maxlength="300"></textarea></td>
				</tr>		
			</table>			
			
			<input type="submit" class="button" style="float: right;" value="작성">
		</form>
			<% if (user_id != null && user_id.equals(post.getUser_id())){ //만약 글 쓴 유저가 해당 유저라면 글 수정, 삭제 가능하게 하기
			%>
				<div>
					<a href="http://localhost:8080/webserver/bbs/update.jsp?post_id=<%= post_id %>" class="button">수정</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href="http://localhost:8080/webserver/bbs/deleteAction.jsp?post_id=<%= post_id %>" class="button">삭제</a>
					<%
						if (post.getBoard_id() == 2){
					%>
					<a onclick="return confirm('입양 상태를 변경하시겠습니까?')" href="http://localhost:8080/webserver/bbs/updateState.jsp?post_id=<%= post_id %>" class="button">상태변경</a>
					<% } %>
				</div>
			<% }
	}
	else { %>
	<p class="plslogin">댓글 작성을 위해서 <a href="http://localhost:8080/webserver/userct/login.jsp">로그인이 필요합니다.</a></p>
	<%
	}
	PostDAO postDAO = new PostDAO();
	
	%>
	</div>
				<!-- TODO: 이전글, 다음글이 post_id로 찾아오는 거라서, board_id별로 차별화 필요 -->
				
				<div class="container">
					<table style="width: 100%;">
					<!-- 이전 글 -->
					<%if (post.getBoard_id() == 1) {//자유게시판일 경우
						int board_id = post.getBoard_id();
						for (int i = 1; i < 9999 ; i++) {
							if (postDAO.getPost(post_id-i) == null) {break;}
							if (postDAO.getPost(post_id-i).getAvailable() != 0 && postDAO.getPost(post_id-i) != null && postDAO.getPost(post_id-i).getBoard_id() == 1) { // 다음 글이 존재할 경우.
					%>
								<tr style="border: 1px solid #dddddd">
								<td class="nextp" align="right"><b>이전글&nbsp;</b>
								<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id - i %>"><%= postDAO.getPost(post_id-i).getPost_title() %></a></td>
					<%
							break;}
						}
					} else if (post.getBoard_id() ==2) {//홍보게시판
						for (int i = 1; i < 9999 ; i++) {
							if (postDAO.getPost(post_id-i) == null) {break;}
							if (postDAO.getPost(post_id-i).getAvailable() != 0 && postDAO.getPost(post_id-i) != null && postDAO.getPost(post_id-i).getBoard_id() == 2) { // 다음 글이 존재할 경우.
					%>
								<tr style="border: 1px solid #dddddd">
								<td class="nextp" align="right"><b>이전글&nbsp;</b>
								<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id - i %>"><%= postDAO.getPost(post_id-i).getPost_title() %></a></td>
					<%
							break;}
						}
					} else if (post.getBoard_id() == 3) {
						for (int i = 1; i < 9999 ; i++) {
							if (postDAO.getPost(post_id-i) == null) {break;}
							if (postDAO.getPost(post_id-i).getAvailable() != 0 && postDAO.getPost(post_id-i) != null && postDAO.getPost(post_id-i).getBoard_id() == 3) { // 다음 글이 존재할 경우.
					%>
								<tr style="border: 1px solid #dddddd">
								<td class="nextp" align="right"><b>이전글&nbsp;</b>
								<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id - i %>"><%= postDAO.getPost(post_id-i).getPost_title() %></a></td>
					<%
							break;}
						}
					}
					%>
					
							<td><a href = "http://localhost:8080/webserver/bbs/bbs.jsp?board_id=<%= post.getBoard_id() %>" class="golist">글 목록&nbsp;</a> <!-- 글 목록으로 되돌아가기 -->
					
					<%if (post.getBoard_id() == 1) {//자유게시판일 경우
						int board_id = post.getBoard_id();						
						for (int i = 1; i < 9999 ; i++) {
							if (postDAO.getPost(post_id+i) == null) {break;}
							if (postDAO.getPost(post_id+i).getAvailable() != 0 && postDAO.getPost(post_id+i) != null && postDAO.getPost(post_id+i).getBoard_id() == 1) { // 다음 글이 존재할 경우.
					%>
								<tr style="border: 1px solid #dddddd">
								<td class="nextp" align="right"><b>다음글&nbsp;</b>
								<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id + i %>"><%= postDAO.getPost(post_id+i).getPost_title() %></a></td>
					<%
							break;}
						}
					} else if (post.getBoard_id() ==2) {//홍보게시판
						for (int i = 1; i < 9999 ; i++) {
							if (postDAO.getPost(post_id+i) == null) {break;}
							if (postDAO.getPost(post_id+i).getAvailable() != 0 && postDAO.getPost(post_id+i) != null && postDAO.getPost(post_id+i).getBoard_id() == 2) { // 다음 글이 존재할 경우.
					%>
								<tr style="border: 1px solid #dddddd">
								<td class="nextp" align="right"><b>다음글&nbsp;</b>
								<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id + i %>"><%= postDAO.getPost(post_id+i).getPost_title() %></a></td>
					<%
							break;}
						}
					} else if (post.getBoard_id() == 3) {//공지사항
						for (int i = 1; i < 9999 ; i++) {
							if (postDAO.getPost(post_id+i) == null) {break;}
							if (postDAO.getPost(post_id+i).getAvailable() != 0 && postDAO.getPost(post_id+i) != null && postDAO.getPost(post_id+i).getBoard_id() == 3) { // 다음 글이 존재할 경우.
					%>
								<tr style="border: 1px solid #dddddd">
								<td class="nextp" align="right"><b>다음글&nbsp;</b>
								<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id + i %>"><%= postDAO.getPost(post_id+i).getPost_title() %></a></td>
					<%
							break;}
						}
					}
					%>
					
					</table>
					</div>
					</div>

</body>
</html>