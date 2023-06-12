<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="java.io.PrintWriter" %> 
<% request.setCharacterEncoding("UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>씨밀레</title>
</head>

<body>
	<%
	String user_id = null;
	if(session.getAttribute("user_id")!=null){
		user_id = (String) session.getAttribute("user_id");
	}
		if (user_id == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
		}
		
		int comment_id = 0;
		if(request.getParameter("comment_id") != null){
			comment_id = Integer.parseInt(request.getParameter("comment_id"));
		}
		if(comment_id == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Comment Comment = new CommentDAO().getComment(comment_id);
		if (!user_id.equals(Comment.getUser_id())){ //글 작성자 본인이 아닐 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글 작성자만 삭제 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //권한이 있는 사람이라면.
					CommentDAO CommentDAO = new CommentDAO();
					int result = CommentDAO.delete(comment_id); //삭제기능 수행
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('댓글 삭제에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('댓글을 삭제했습니다.')");
						script.println("</script>");
						String link = request.getHeader("referer");
						response.sendRedirect(link);
					}
		}
	%>
</body>

</html>