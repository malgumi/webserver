<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 <%@ page import="users.UsersDAO" %>
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="users" class="users.Users" scope="page" />
 <jsp:setProperty name="users" property="user_id" /> <!-- user ID 받아오는거 -->
 <jsp:setProperty name="users" property="password" />
 <jsp:setProperty name="users" property="name" /> 
 <jsp:setProperty name="users" property="permission" /> 
 <jsp:setProperty name="users" property="email" /> 
<!DOCTYPE html>
<html>

<!-- 로그인 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>씨밀레</title>
</head>

<body>
	<%
		String user_id = null;
		String link = request.getParameter("link");
		if(session.getAttribute("user_id")!= null){ //유저 ID에 해당 세션 값 넣기
			user_id = (String) session.getAttribute("user_id");
		}
		if (user_id != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
			response.sendRedirect(link);
		}
			
		if(users.getUser_id() == null || users.getPassword() == null || users.getName() == null  || users.getEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 곳이 있습니다!');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
		else{
			UsersDAO userDAO = new UsersDAO();
			//변수 받아서 login 함수로 보내버리기
				int result = userDAO.join(users);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('해당 ID가 이미 존재합니다.');");
					script.println("history.back()"); //이전 페이지로 되돌려보냄
					script.println("</script>");
				}
				else {
					session.setAttribute("user_id", users.getUser_id());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원가입에 성공했습니다.');");
					script.println("location.href='http://localhost:8080/webserver/main.jsp'");
					script.println("</script>");
					//response.sendRedirect(link);
				}
		}
		

	%>
</body>

</html>