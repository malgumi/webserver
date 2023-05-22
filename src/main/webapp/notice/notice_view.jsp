<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>

<!-- 게시글 보기 -->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../css/view.css" type="text/css">
        <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .main {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
        }

        .cho {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .board {
            margin-bottom: 20px;
        }

        .header {
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }

        .title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .info p {
            margin-bottom: 5px;
        }

        .info span {
            font-weight: bold;
        }

        .body {
            font-size: 16px;
        }

        .content {
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            margin-right: 10px;
        }
    </style>
    <title>씨밀레</title>
</head>

<body>
    <%@ include file="../nav/navbar.jsp" %>
    <%
        int post_id = 0;
        if (request.getParameter("post_id") != null) {
            post_id = Integer.parseInt(request.getParameter("post_id"));
        }
        if (post_id == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다.')");
            script.println("location.href = 'notice_bbs.jsp'");
            script.println("</script>");
        }
        Post post = new PostDAO().getPost(post_id);
        if (post == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다.')");
            script.println("location.href = 'notice_bbs.jsp'");
            script.println("</script>");
        }
        if (post.getAvailable() == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('삭제된 글입니다.')");
            script.println("location.href = 'notice_bbs.jsp'");
            script.println("</script>");
        }
    %>
    <div class="container">
        <div class="row">
            <div class="main">
                <h1 class="cho"><span>공지사항</span></h1>
                <section class="board">
                    <div class="header">
                        <h3 class="title"><%= post.getPost_title() %></h3>
                        <div class="info">
                            <p>
                                <span>작성자</span> <%= post.getUser_id() %>
                            </p>
                            <p>
                                <span>작성일</span>
                                <%= post.getDate().substring(0, 16) %>
                            </p>
                        </div>
                    </div>
                    <div class="body">
                        <div class="content">
                            <%= post.getPost_content().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;")
                                .replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %>
                        </div>
                    </div>
                </section>
            </div>
            <a onclick="history.back()" class="btn btn-primary" id="btns">뒤로가기</a>
            <a href="notice_bbs.jsp" class="btn btn-primary" id="btns">목록</a>
            <% if (user_id != null && user_id.equals(post.getUser_id())) { %>
                <a href="notice_update.jsp?post_id=<%= post_id %>" class="btn btn-primary" id="btns">글 수정</a>
                <a onclick="return confirm('삭제하시겠습니까?')" href="delete_noticeAction.jsp?post_id=<%= post_id %>" class="btn btn-primary" id="btns">삭제</a>
            <% } %>
        </div>
    </div>
</body>

</html>
