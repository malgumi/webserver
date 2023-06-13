<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<!DOCTYPE html>
<html>

<!-- 게시글 수정 페이지 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" href="../css/main.css">
<title>씨밀레</title>
</head>

<body>
<a class="logo" href="http://localhost:8080/webserver/main.jsp" style="margin-top:5px;"><img src="http://localhost:8080/webserver/img/logo.png"></a>
    <%@ include file="../nav/navbar_backup.jsp" %>
	<%
		if(user_id == null){ //ID값이 null이면 아직 로그인 안한거
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다')");
			script.println("location.href = 'http://localhost:8080/webserver/userct/login.jsp'");
			script.println("</script>");
		}
		int post_id = 0;
		if(request.getParameter("post_id") != null){ //post_id가 존재한다면
			post_id = Integer.parseInt(request.getParameter("post_id")); //post_id에 그걸 담아서 처리할 수 있게 함
		}
		if(post_id == 0){ //0이니까 post_id가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Post post = new PostDAO().getPost(post_id);
		if (!user_id.equals(post.getUser_id())){ //글 작성자 본인이 아닐 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 작성자만 수정 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	<br><br><br>
	<div class="container" style="width: 60%;">
		 <!-- updateAction페이지로 내용 숨겨서 전송 -->
		<form method="post" action="updateAction.jsp?post_id=<%= post_id %>">
			<table class="viewtable" style="text-align: center; border: 1px solid #dddddd; width: 100%; height: 450px;">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #f5f2ea; text-align: center; height: 30px;">글 수정</th>

					</tr>
				</thead>
				<tbody>
					<tr>
					<!-- value 부분은 자기가 전에 작성했던 글 보여주는거임! -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="post_title" maxlength="50" style="width: 90%; height: 25px; margin-top: 10px; padding-left: 5px;" value="<%= post.getPost_title().replace("[입양가능] ","").replace("[입양완료] ","") %>"></td>
					</tr>
					<tr>						
						<td><textarea class="form-control" placeholder="글 내용" name="post_content" maxlength="2048" style="height: 350px; width: 90%; padding-left: 5px; padding-top: 5px;"><%= post.getPost_content() %></textarea></td>
					</tr>

				</tbody>
			</table>
			<input onclick="return confirm('수정하시겠습니까?')" type="submit" class="button" value="수정하기" style="height: 30px; width: 80px; margin-top: 10px;">
		</form>
	</div>	

</body>
</html>