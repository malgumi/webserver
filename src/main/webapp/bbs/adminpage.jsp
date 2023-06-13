<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="post.Post" %>
<%@ page import="users.Users" %>
<%@ page import="post.PostDAO" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<title>씨밀레</title>
<script>
    function toggleRows() {
        var tableBody = document.getElementById("postTableBody");
        var button = document.getElementById("toggleButton");

        if (tableBody.classList.contains("hidden")) {
            tableBody.classList.remove("hidden");
            button.textContent = "⇨ 글 목록 숨기기";
        } else {
            tableBody.classList.add("hidden");
            button.textContent = "⇨ 글 관리하기";
        }
    }

    function goToPage(pageNumber) {
        window.location.href = "http://localhost:8080/webserver/bbs/adminpage.jsp#" + pageNumber;
    }
    
    function updateUser(user_id) {
        var form = document.getElementById("updateForm");
        form.action = "update_UserAction.jsp";
        form.elements["user_id"].value = user_id;
        form.submit();
    }
</script>

</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
<h2 style="text-align: center; margin-top: 20px;">관리자 전용 페이지입니다.</h2>
<%
    Users users = new UsersDAO().getUserdata(user_id);
    if(user_id == null || users.getPermission() != 2){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자 페이지는 관리자만이 접속 가능합니다.')");
        script.println("location.href = 'http://localhost:8080/webserver/main.jsp'");
        script.println("</script>");
    }
%>

<div class="container">
    <!-- 글 목록 펼치기/접기 버튼 -->
    <button id="toggleButton" class="button" onclick="toggleRows()">&#8680; 글 관리하기</button>

    <table id="postTableBody" class="posttable hidden">
        <thead>
            <tr>
                <th>게시판</th>
                <th>글 제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>삭제</th>
            </tr>
        </thead>

        <!-- 글 목록 출력 -->
        <tbody>
            <%
                PostDAO postDAO = new PostDAO();
                ArrayList<Post> postList = postDAO.getListTen();
                BoardDAO boardDAO = new BoardDAO();
                for(Post post : postList){
                    String board_title = boardDAO.getBoard_title(post.getBoard_id());
            %>
            <tr>
                <td><%=board_title%></td>
                <td><a href="http://localhost:8080/webserver/bbs/view.jsp?post_id=<%= post.getPost_id()%>" style="text-decoration: none; color: black;"><%= post.getPost_title() %></a></td>
                <td><%=post.getUser_id()%></td>
                <td><%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + "시" + post.getDate().substring(14,16) + "분" %></td>
                <td><a href="http://localhost:8080/webserver/bbs/deleteAction.jsp?post_id=<%= post.getPost_id()%>" style="text-decoration: none; color: red;">삭제</a></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    
	<table class="posttable">
        <thead>
            <tr>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>이메일</th>
                <th>수정</th>
            </tr>
        </thead>

        <!-- 유저 목록 출력 -->
        <tbody>
            <%
                UsersDAO userDAO = new UsersDAO();
                ArrayList<Users> userList = userDAO.getList();
                for(Users user : userList){
                    
            %>
            <tr>
            	<td><%=user.getUser_id()%></td>
                <td><%=user.getPassword()%></td>
                <td><%=user.getName()%></td>
                <td><%=user.getEmail()%></td>
                <td><a href="http://localhost:8080/webserver/Userpage/admin_main_Userpage.jsp?user_id=<%= user.getUser_id() %>" style="text-decoration: none; color: red;">수정</a></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    
</div>

</body>
</html>
