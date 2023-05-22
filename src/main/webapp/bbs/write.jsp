<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<title>씨밀레</title>

<!-- 글 쓰기, 글 삭제, 글 수정 공용 기능으로 통합하기-->


</head>
<body>
<%@ include file="../nav/navbar.jsp" %>

	<div class="container">
		<div class="row">
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd; width: 100%; height: 450px;">
				<thead>
					<tr>
						<th colspan="2" style ="background-color: #eeeeee; text-align: center; height: 30px;"> 자유게시판 글 작성 </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type= "text" class="form-control" placeholder="제목을 입력하세요" name="post_title" maxlength="50" style="width: 90%; height: 25px; margin-top: 10px; padding-left: 5px;"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="작성할 내용을 입력하세요" name="post_content" maxlength="2048" style="height:350px; width: 90%; padding-left: 5px; padding-top: 5px;"></textarea></td>
					</tr>
				</tbody>
				
			</table>
			<input type="submit" class = "btn btn-primary pull-right" value="제출" style="height: 30px; width: 50px; margin-top: 10px;">
		
		
		</form>
			
		</div>
	</div>
	
	
 
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

</body>
</html>