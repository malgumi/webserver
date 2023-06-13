<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<title>씨밀레</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<a class="logo" href="http://localhost:8080/webserver/main.jsp" style="margin-top:5px;"><img src="http://localhost:8080/webserver/img/logo.png"></a>
    <%@ include file="../nav/navbar_backup.jsp" %>
	<div class="container" style="width: 60%; margin-top:100px;"> 
				<form method="post" action="passwordAction.jsp" style="margin-top: 50px; border:1px solid #c2c2c2; background-color: white; text-align: center;">
					<h3 style="text-align: center; background-color: #f5f2ea; padding: 10px 0px 10px 0px;">비밀번호 확인</h3>
					<label style="text-align: center; font-size: 15px; color: #666">
						<br> <span>정보 수정을 위해 비밀번호를 입력해주세요.</span><br><br>
						<input type="password" placeholder="비밀번호" name="password" maxlength="20" style="width: 40%;">
					</label>
					<p>
						<input type="submit" value="Sign in" class="button">
					</p><br>
				</form>
	</div>
</body>
</html>