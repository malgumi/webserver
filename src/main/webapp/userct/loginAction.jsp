<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="users.Users" %>
 <%@ page import="users.UsersDAO" %>
 <%@ page import="java.io.PrintWriter" %> 
 
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="user" class="users.Users" scope="page" />
 <jsp:setProperty name="user" property="user_id" /> <!-- user ID 받아오는거 -->
 <jsp:setProperty name="user" property="password" />

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
		if(session.getAttribute("user_id")!= null){ //유저 ID에 해당 세션 값 넣기
			user_id = (String) session.getAttribute("user_id");
		
		}
		if (user_id != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
		UsersDAO UsersDAO = new UsersDAO();
	//변수 받아서 login 함수로 보내버리기
		int result = UsersDAO.login(user.getUser_id(), user.getPassword());
		Users users = new UsersDAO().getUserdata(user.getUser_id());
		if (result == 1 && users.getPermission() == 2) {
			session.setAttribute("user_id", user.getUser_id()); //유저 ID를 세션번호?로 지정해줌
			PrintWriter script = response.getWriter();	
			script.println("<script>");
			script.println("alert('환영합니다. 관리자님')");
			script.println("location.href='http://localhost:8080/webserver/bbs/adminpage.jsp'");
			script.println("</script>");
		}
		else if (result == 1 && users.getPermission() != 2) {
			session.setAttribute("user_id", user.getUser_id());
			PrintWriter script = response.getWriter();	
			script.println("<script>");
			script.println("alert('로그인 되었습니다.')");
			script.println("location.href='http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
	%>
</body>

</html>