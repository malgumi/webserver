<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="post.PostDAO" %>
 <%@ page import="post.Post" %>
 <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> 
<!DOCTYPE html>
<html>

<!-- 글삭제 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>씨밀레</title>
</head>

<body>
	<%
		String user_id = null;
		if(session.getAttribute("user_id")!= null){ //유저 ID에 해당 세션 값 넣기
			user_id = (String) session.getAttribute("user_id");
		}
		if (user_id == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'http://localhost:8080/webserver/userct/login.jsp'");
			script.println("</script>");
		}
		
		int post_id = 0;
		if(request.getParameter("post_id") != null){
			post_id = Integer.parseInt(request.getParameter("post_id"));
		}
		if(post_id == 0){ //0이니까 bbsID가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Post post = new PostDAO().getPost(post_id);
		Users user = new UsersDAO().getUserdata(user_id);
		if (user_id.equals(post.getUser_id()) || user.getPermission() == 2){ //권한이 있는 사람이라면.
					PostDAO PostDAO = new PostDAO();
					int board_id = PostDAO.getPost(post_id).getBoard_id();
					int result = PostDAO.deletePost(post_id); //삭제기능 수행
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 삭제에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글을 삭제했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
		}
		else{ //글 작성자 본인이 아니고 권한도 없다면.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 작성자만 삭제 가능합니다."+ user.getPermission() +"')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>

</html>