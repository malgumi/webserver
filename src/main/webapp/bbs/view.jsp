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

<!DOCTYPE html>
<html>

<!-- 게시글 보기 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" type="text/css" href="./css/main.css">
<title>씨밀레</title>
</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
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
				<td><%= post.getPost_content().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %></td>
			</tr>
		</table>
		<br><br>
		<p class="board">댓글 목록</p> 
		<table class="commenttable">
			<tr>
				<th>작성자</th>
				<th>내용</th>
				<th>작성일</th>
			</tr>
			<%
						CommentDAO CommentDAO = new CommentDAO();
						ArrayList<Comment> list = CommentDAO.comment_getList(post_id);
						for(int i = list.size()-1; i>=0; i--){
					%>
			<tr>
				<td style="text-align: center;"><%= list.get(i).getUser_id() %></td>
				<td style="text-align: center;"><%= list.get(i).getComment_content() %></td>
				<td style="text-align: end; font-size: 10px; color: gray;"><%= list.get(i).getDate().substring(0,11) + list.get(i).getDate().substring(11, 13) + "시" + list.get(i).getDate().substring(14,16) + "분" %></td>
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
					<%
						if (postDAO.getPost(post_id-1) != null) { // 이전 글이 존재할 경우.
					%>
						<tr style="border: 1px solid #dddddd">
					<%
						if (postDAO.getPost(post_id-1).getAvailable() != 0) { // 이전 글이 존재하고, 삭제되지 않았을 경우
					%>
							<td class="previousp" align="left"><b>이전글&nbsp;</b>
							<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id - 1 %>"><%= postDAO.getPost(post_id-1).getPost_title() %></a></td>
					<%
						}
						else if (postDAO.getPost(post_id-2) != null) { // 이전 글이 존재하고, 삭제되었고, 삭제된 글의 이전 글이 존재할 경우
					%>
							<td class="previousp" align="left"><b>이전글&nbsp;</b>
							<td><a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id - 2 %>"><%= postDAO.getPost(post_id-2).getPost_title() %></a></td>
					<%	
						}
					%>
					<%
						}
					%>
							<td><a href = "http://localhost:8080/webserver/bbs/bbs.jsp?board_id=<%= post.getBoard_id() %>" class="golist">글 목록&nbsp;</a> <!-- 글 목록으로 되돌아가기 -->
					<%
					if (postDAO.getPost(post_id+1) != null) { // 다음 글이 존재할 경우.
					%>

						<%
							if (postDAO.getPost(post_id+1).getAvailable() != 0) { // 다음 글이 존재하고, 삭제되지 않았을 경우
						%>
							<td class="nextp" align="right"><b>다음글&nbsp;</b>
							<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id + 1 %>"><%= postDAO.getPost(post_id+1).getPost_title() %></a></td>
						<%
						}
						else if (postDAO.getPost(post_id+2) != null) { // 다음 글이 존재하고, 삭제되었고, 삭제된 글의 다음 글이 존재하는 경우
						%>
							<td class="nextp" align="right"><b>다음글&nbsp;</b>
							<a style="text-decoration: none;" href="view.jsp?post_id=<%= post_id + 2 %>"><%= postDAO.getPost(post_id+2).getPost_title() %></a></td>
						<%
						}
						%>	
					</tr>
					<%
					}
					%>
					</table>
					</div>
					</div>

</body>
</html>