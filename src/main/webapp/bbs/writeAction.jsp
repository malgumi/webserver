<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="post.Post" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="java.io.PrintWriter" %> 

 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="post" class="post.Post" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="post" property="Post_title" />
 <jsp:setProperty name="post" property="Post_content" />
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
	
		String User_id = null;
		if(session.getAttribute("User_id")!= null){ //유저 ID에 해당 세션 값 넣기
			User_id = (String) session.getAttribute("User_id");
		}
		if (User_id == null) {
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
					int result = postDAO.write(post.getPost_title(), User_id, post.getPost_content(), 1);//1->자유게시판 board_id
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
						script.println("location.href = 'bbs.jsp'"); //게시판으로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>