<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>씨밀레</title>
    <link rel="stylesheet" type="text/css" href="http://localhost:8080/webserver/css/user.css">
</head>
<body>
    <%@ include file="../nav/navbar.jsp" %>
    
    <div class="loginbox">
        <form method="post" action="findUserAction.jsp">
            <h3 class="ltitle">회원정보 찾기</h3>
            <hr>
            <div class="loginform">
                <p>가입 시 입력한 이메일을 입력해주세요.</p>
                <br>
                <input type="email" class="insert" placeholder="이메일" name="email" maxlength="50">
                <br><br>
                <input type="submit" id="submitbtn" value="찾기">
            </div>
        </form>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</body>
</html>
