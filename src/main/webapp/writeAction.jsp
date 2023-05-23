<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="java.io.PrintWriter" %> 

 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="post" class="post.Post" scope="page" />
 <jsp:setProperty name="post" property="post_title" />
 <jsp:setProperty name="post" property="post_content" />
 <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>



<!DOCTYPE html>
<html>

<!-- 글쓰기 기능 -->

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
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
		String user_id = null;
		if(session.getAttribute("user_id")!= null){ //유저 ID에 해당 세션 값 넣기
			user_id = (String) session.getAttribute("user_id");
		}
		if (user_id == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
		}
		
		else{
			//뭔가 입력이 안됐을때
			if(post.getPost_title() == null || post.getPost_content() == null || post.getPost_content().replaceAll("\\s", "").equals("") || post.getPost_title().replaceAll("\\s", "").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				UsersDAO userDAO = new UsersDAO();
				//String name = userDAO.//nameserach(User_id);//닉네임가져와서 데이터베이스로 저장 
				PostDAO postDAO = new PostDAO();
					int result = postDAO.write(post.getPost_title(), user_id, post.getPost_content(), board_id);
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("history.back(-2)"); //★수정필요★
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>