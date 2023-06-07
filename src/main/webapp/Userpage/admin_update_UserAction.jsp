<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="users.UsersDAO" %>
  <%@ page import="users.Users" %>
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
	int permission = 0;
	if(session.getAttribute("user_id")!= null){ //유저 ID에 해당 세션 값 넣기
		user_id = (String) session.getAttribute("user_id");
	}
	if(session.getAttribute("permission") != null && session.getAttribute("permission") instanceof Integer){
		permission = (int) session.getAttribute("permission");
	}
	if (user_id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'http://localhost:8080/webserver/login.jsp'");
		script.println("</script>");
	}
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("user_id");
	Users user = new UsersDAO().getUserdata(userId);
			if(request.getParameter("password").replaceAll("\\s", "").equals("") || request.getParameter("name").replaceAll("\\s", "").equals("") 
					|| request.getParameter("email").replaceAll("\\s", "").equals("")
					|| request.getParameter("password") == null || request.getParameter("name") == null 
					|| request.getParameter("email") == null){ 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{
				UsersDAO UserDAO = new UsersDAO();
				int result = UserDAO.updateUserdata(userId, request.getParameter("password"), request.getParameter("name"), permission, 
						request.getParameter("email"));
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('회원 정보 수정에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else if (result == -2){ //닉네임이 겹치는 경우
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('해당 닉네임이 이미 존재합니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('회원정보를 수정했습니다.')");
						script.println("location.href='http://localhost:8080/webserver/bbs/adminpage.jsp'");
						script.println("</script>");
					}
				}
	%>
</body>

</html>