<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="post.PostDAO" %>
 <%@ page import="post.Post" %>
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
		
		int post_id = 0;
		if(request.getParameter("post_id") != null){ //post_id가 존재한다면
			post_id = Integer.parseInt(request.getParameter("post_id")); //post_id에 그걸 담아서 처리할 수 있게 함
		}
		if(post_id == 0){ //0이니까 post_id가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Post post = new PostDAO().getPost(post_id);
		if (!user_id.equals(post.getUser_id())){ //글 작성자 본인이 아닐 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 작성자만 수정 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //권한이 있는 사람이라면.
			if(request.getParameter("post_title").replaceAll("\\s", "").equals("") || request.getParameter("post_content").replaceAll("\\s", "").equals("")
					|| request.getParameter("post_title") == null || request.getParameter("post_content") == null){ 
				//null값이거나 빈칸인게 하나라도 있는 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				PostDAO postDAO = new PostDAO();
					int result = postDAO.updatePost(post_id, request.getParameter("post_title"), request.getParameter("post_content"));
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글을 수정했습니다.')");
						script.println("location.href='view.jsp?post_id="+post_id+"'");
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>