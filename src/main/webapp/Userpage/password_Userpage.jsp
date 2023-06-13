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
<body style ="background-color:#f5f1ee;">
<a class="logo" href="http://localhost:8080/webserver/main.jsp" style="margin-top:5px;"><img src="http://localhost:8080/webserver/img/logo.png"></a>
    <%@ include file="../nav/navbar_backup.jsp" %>
	<div class="container" style="margin-top: 50px; border:1px solid #c2c2c2;"> 
			<div>
				<form method="post" action="passwordAction.jsp" style="background-color: white;">
					<h3 style="text-align: center;">비밀번호 확인</h3> <!--1.23 뒷 배경 제거  -->
					<hr>
					<label style="text-align: left; font-size: 12px; color: #666">
						<br> <span>정보 수정을 위해 비밀번호를 입력해주세요.</span> <br> <br>
						<input type="password" placeholder="비밀번호" name="password" maxlength="20">
					</label>

					<p>
						<input type="submit" value="Sign in" class="button">
					</p>
				</form>
				<hr>
			</div>
	</div>
</body>
</html>