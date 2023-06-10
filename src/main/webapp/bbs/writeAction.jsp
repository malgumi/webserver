<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="file.FileDAO" %>
<%@ page import="file.FileDTO" %>
<%@ page import="java.io.File" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="post" class="post.Post" scope="page" />
 <jsp:setProperty name="post" property="post_title" />
 <jsp:setProperty name="post" property="post_content" />
 <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>

<!DOCTYPE html>
<html>

<!-- 글쓰기 기능 TODO! 첨부파일 글 id가 -1로 저장되는 부분 수정 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>씨밀레</title>
</head>

<body>
	<%
	
	int board_id = 0;
	if(request.getParameter("board_id") != null){
		board_id = Integer.parseInt(request.getParameter("board_id"));
	}
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 시도입니다. 다시 시도해주세요.')");
		script.println("location.href = 'http://localhost:8080/webserver/bbs/bbs.jsp'");
		script.println("</script>");
	}
	
	
	String directory = application.getRealPath("/upload/");
	int maxSize = 1024*1024*100;
	String encoding = "UTF-8";
	
	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
	String fileName = multipartRequest.getOriginalFileName("file");
	String fileRealName = multipartRequest.getFilesystemName("file");
	String postTitle = multipartRequest.getParameter("post_title");
	String postContent = multipartRequest.getParameter("post_content");
	
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
		
		else{
			//뭔가 입력이 안됐을때
			if(postTitle == null || postContent == null || postContent.replaceAll("\\s", "").equals("") || postTitle.replaceAll("\\s", "").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다."+postTitle +"')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else if(board_id == 2){ //홍보게시판일시
				UsersDAO userDAO = new UsersDAO();
				PostDAO postDAO = new PostDAO();
					int result = postDAO.write("[입양가능] "+postTitle, user_id, postContent, board_id);
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						new FileDAO().upload(fileName, fileRealName, board_id);
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'http://localhost:8080/webserver/bbs/bbs.jsp?board_id=" + board_id + "'");
						script.println("</script>");
					}
			}
			else{ 
				UsersDAO userDAO = new UsersDAO();
				PostDAO postDAO = new PostDAO();
					int result = postDAO.write(postTitle, user_id, postContent, board_id);
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						new FileDAO().upload(fileName, fileRealName, board_id);
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'http://localhost:8080/webserver/bbs/bbs.jsp?board_id=" + board_id + "'");
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>