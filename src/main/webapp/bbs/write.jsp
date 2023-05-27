<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
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
		else{ // board_id값이 제대로 넘어오지 않았을 시
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 시도입니다. 다시 시도해주세요.')");
			script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
		if(session.getAttribute("user_id")!= null){ //유저 ID에 해당 세션 값 넣기
			user_id = (String) session.getAttribute("user_id");
		}
		if (user_id == null) { //로그인 안했을 시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'http://localhost:8080/webserver/userct/login.jsp'");
			script.println("</script>");
		}
		if(board_id == 3 && !user_id.equals("admin")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('공지사항은 관리자만 작성 가능합니다.')");
			script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
	%>

	<div class="container">
		<div class="row">
		<form method="post" action="http://localhost:8080/webserver/bbs/writeAction.jsp?board_id=<%= board_id %>">
			<table class="viewtable" style="text-align: center; border:1px solid #dddddd; width: 100%; height: 450px;">
				<thead>
					<tr>
						<th colspan="2" style ="background-color: #eeeeee; text-align: center; height: 30px;"> 글 작성 </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type= "text" class="form-control" placeholder="제목을 입력하세요" name="post_title" maxlength="50" style="width: 90%; height: 25px; margin-top: 10px; padding-left: 5px;"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="작성할 내용을 입력하세요" name="post_content" maxlength="2048" style="height:350px; width: 90%; padding-left: 5px; padding-top: 5px;"></textarea></td>
					</tr>
				</tbody>
				
			</table>
			<input type="submit" class = "btn btn-primary pull-right" value="제출" style="height: 30px; width: 50px; margin-top: 10px;">
		
		
		</form>
			
		</div>
	</div>

</body>
</html>