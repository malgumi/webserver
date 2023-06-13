<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<title>씨밀레</title>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/webserver/css/user.css">
</head>
<body>
<a class="logo" href="http://localhost:8080/webserver/main.jsp" style="margin-top:5px;"><img src="http://localhost:8080/webserver/img/logo.png"></a>
    <%@ include file="../nav/navbar_backup.jsp" %>
<% String link = request.getHeader("referer"); %>
<%	
if (user_id != null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('잘못된 접근입니다.')");
	script.println("location.href='http://localhost:8080/webserver/main.jsp'");
	script.println("</script>");
} %>
	<div class ="loginbox">
		<form method="post" action="joinAction.jsp">
			<h3 class ="ltitle">회원가입</h3>
			<hr>
			<div class="loginform">
    		아이디<br><br>
    		<input type="text" class="insert" placeholder="아이디" name="user_id" maxlength="20">
    		<br><br>비밀번호<br><br>
    		<input type="password" class="insert" placeholder="비밀번호는 최소 8자 이상, 영문자/숫자/특수문자가 모두 포함되어야 합니다" name="password" maxlength="20" pattern="(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,}" title="최소 8자, 영문자/숫자/특수문자 모두 포함">
    		<br><br>이름<br><br>
    		<input type="text" class="insert" placeholder="이름" name="name" maxlength="20">
    		<br><br>이메일<br><br>
    		<input type="email" class="insert" placeholder="ex) abc@cde.com" name="email" maxlength="20">
    		<br><br><br>
    		<input type="hidden" name="link" value="<%= link %>">
    		<input type="submit" id="submitbtn" value="회원가입">
		</div>

			<%-- <%
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입을 축하합니다!')");
			script.println("location.href='http://localhost:8080/webserver/main.jsp'");
			script.println("</script>");
		%> --%>
		</form>
		
	</div>



	<%-- <div id="con">
		<div id="logi">
			<div id="login_form">
				<!--로그인 폼-->
				<form method="post" action="joinAction.jsp">
					<h3 class="login" style="letter-spacing: -1px;">Sign up to Web</h3>

					<!-- <p>
            <input type="submit" value="Sign in with Google" class="btn" style="background-color:#217Af0">
        </p> 구글로 로그인-->

					<hr>

					<!-- <span>ID</span> -->
					<label>
						<p style="text-align: left; font-size: 12px; color: #666">userID</p>
						<input type="text" class="size" placeholder="아이디" name="user_id" maxlength="20">
						<p></p>
					</label>
					<!--아이디-->

					<label> <!-- <span>PW</span> -->
						<p style="text-align: left; font-size: 12px; color: #666">Password</p> 
						<input type="password" class="size" placeholder="비밀번호" name="password" maxlength="20">
					</label>
					

					<label> <!-- <span>PW</span> -->
						<p style="text-align: left; font-size: 12px; color: #666">userName</p> 
						<input type="text" class="size" placeholder="이름" name="name" maxlength="20">
					</label>


					<label> <!-- <span>PW</span> -->
						<p style="text-align: left; font-size: 12px; color: #666">E-mail</p>
						<input type="email" class="size" placeholder="이메일" name="email" maxlength="20">
					</label>
					<!--이메일-->

					<br>
					
					<input type="hidden" name="link" value=<%= link %>><!-- 전 페이지의 링크를 담아서 보냄  -->
					<p>
						<input type="submit" class="btn" value="회원가입">

					</p>
				</form>

				<hr>
			</div>
		</div>
	</div> --%>
</body>
</html>