<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="comment.CommentDAO" %>
 <%@ page import="post.Post" %>
  <%@ page import="post.PostDAO" %> <!-- Post데이터 객체를 이용해서 받아오는 것 -->
 <%@ page import="java.io.PrintWriter" %> 
 <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="comment" class="comment.Comment" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="comment" property="comment_comment" />
<!DOCTYPE html>
<html>

<!-- 글쓰기 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>씨밀레</title>
</head>

<body>
	<%
		Post post = new Post();
		CommentDAO CommentDAO = new CommentDAO();
		String User_id = null;
		if(session.getAttribute("User_id")!= null){ //유저 ID에 해당 세션 값 넣기
			User_id = (String) session.getAttribute("User_id");
		}
		if (User_id == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		else{
			int Post_id = 0;
			if(request.getParameter("Post_id") != null){ //Post_id가 존재한다면
				Post_id = Integer.parseInt(request.getParameter("Post_id")); //Post_id에 그걸 담아서 처리할 수 있게 함
			}
			if(Post_id == 0){ //0이니까 Post_id가 없는 경우임. 왜냐? 위에서 번호 담았으니까
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
			//뭔가 입력이 안됐을때
			if(request.getParameter("comment_content").replaceAll("\\s", "").equals("") || request.getParameter("comment_content") == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 

			else{ //입력이 됐다면 데이터베이스로 보내버리기
				UsersDAO UsersDAO = new UsersDAO();
				CommentDAO commentDAO = new CommentDAO();
					int result = commentDAO.comment_write(User_id, Post_id, comment.getComment_content(), 1);//1<-아마 available
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('댓글쓰기에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'view.jsp?Post_id="+Post_id+"'"); //게시글로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>