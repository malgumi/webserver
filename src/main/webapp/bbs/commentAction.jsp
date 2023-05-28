<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="post.PostDAO" %> <!-- Post데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="users.UsersDAO" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    request.setCharacterEncoding("UTF-8");
    String user_id = (String) session.getAttribute("user_id");
    
    if (user_id == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.')");
        script.println("location.href = 'http://localhost:8080/webserver/userct/login.jsp'");
        script.println("</script>");
    } else {
        int post_id = 0;
        if (request.getParameter("post_id") != null) { // Post_id가 존재한다면
            post_id = Integer.parseInt(request.getParameter("post_id")); // Post_id에 그걸 담아서 처리할 수 있게 함
        }
        if (post_id == 0) { // 0이니까 Post_id가 없는 경우임. 왜냐? 위에서 번호 담았으니까
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다.')");
            script.println("location.href = 'http://localhost:8080/webserver/bbs/bbs.jsp'");
            script.println("</script>");
        } else {
            String comment_content = request.getParameter("comment_content");
            // 뭔가 입력이 안됐을때
            if (comment_content == null || comment_content.trim().isEmpty()) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안 된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else { // 입력이 됐다면 데이터베이스로 보내버리기
                CommentDAO commentDAO = new CommentDAO();
                int result = commentDAO.comment_write(user_id, post_id, comment_content, 1); // 1<-아마 available
                if (result == -1) { // 데이터베이스 오류
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('댓글쓰기에 실패했습니다.')");
                    script.println("history.back()"); // 이전 페이지로 되돌려보냄
                    script.println("</script>");
                } else {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href = 'http://localhost:8080/webserver/bbs/view.jsp?post_id=" + post_id + "'"); // 게시글로 보냄
                    script.println("</script>");
                }
            }
        }
    }
%>
