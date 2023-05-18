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
		String User_id = null;
		int Permission = 0;
		if(session.getAttribute("User_id")!= null){ //유저 ID에 해당 세션 값 넣기
			User_id = (String) session.getAttribute("User_id");
			Permission = (int) session.getAttribute("Permission");
		}
		if (User_id == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'http://localhost:8080/webserver/login.jsp'");
			script.println("</script>");
		}
		Users user = new UsersDAO().getUserdata(User_id);
		if (!User_id.equals(user.getUser_id())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('본인 외의 정보는 수정 불가능합니다.')");
			script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		}
		else{
			if(request.getParameter("Password").replaceAll("\\s", "").equals("") || request.getParameter("Name").replaceAll("\\s", "").equals("") 
					|| request.getParameter("Email").replaceAll("\\s", "").equals("")
					|| request.getParameter("Password") == null || request.getParameter("Name") == null 
					|| request.getParameter("Email") == null){ 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{
				UsersDAO UserDAO = new UsersDAO();
					int result = UserDAO.updateUserdata(User_id, request.getParameter("Password"), request.getParameter("Name"), Permission, 
							request.getParameter("Email"));
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
						script.println("location.href='main_Userpage.jsp'");
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>