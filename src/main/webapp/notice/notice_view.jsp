<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %><!-- bbs데이터베이스 사용 가능하도록 해당 클래스 가져오기 -->
<%@ page import="post.PostDAO"%><!-- 데이터베이스 접근 객체도 가져옴 -->
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>

<!-- 게시글 보기 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" href="../css/bootstrap.css" type="text/css">
<link rel="stylesheet" href="../css/view.css" type="text/css">

<title>씨밀레</title>
</head>


<body>
<%@ include file="../nav/navbar.jsp" %>
	<%
		int post_id = 0;
		if(request.getParameter("post_id") != null){ //bbsID가 존재한다면
			post_id = Integer.parseInt(request.getParameter("post_id")); //bbsID에 그걸 담아서 처리할 수 있게 함
		}
		if(post_id == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'notice_bbs.jsp'");
			script.println("</script>");
		}
		Post Post = new PostDAO().getPost(post_id); //해당 글 가져옴
		if(Post == null){ //존재하지 않는 글일경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'notice_bbs.jsp'");
			script.println("</script>");
		}
		if(Post.getAvailable() == 0){
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
       				     <h3 class="title"><%= Post.getPost_title() %></h3>
       				     <div class="info">
        			        <p>
        			        <span>작성자</span> <%= Post.getUser_id() %><!-- 닉네임으로 뜨도록 변경 2.3 배정훈   -->
           				    </p>
           				     <p><span>작성일</span>
           				       <%= Post.getDate().substring(0,11) + Post.getDate().substring(11, 13) + "시" + Post.getDate().substring(14,16) + "분" %>
           				     </p>
            			 </div>
      			 	 </div>
    				  <div class="body">
    				  	<div class="content">
    				  		<%= Post.getPost_content().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %>
    				  	</div>
    				  </div>
    				</section>
			</div>
			
						<a onclick="history.back()" class="btn btn-primary" id="btns">뒤로가기</a>
						<a href = "notice_bbs.jsp" class="btn btn-primary" id="btns">목록</a> <!-- 글 목록으로 되돌아가기 -->
					<%
						if (user_id != null && user_id.equals(Post.getUser_id())){ //만약 글 쓴 유저가 해당 유저라면 글 수정, 삭제 가능하게 하기
					%>	
						<a href="notice_update.jsp?post_id=<%= post_id %>" class="btn btn-primary" id="btns">글 수정</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="delete_noticeAction.jsp?post_id=<%= post_id %>" class="btn btn-primary" id="btns">삭제</a>
					<%
						}	
					%>

					
			
			
			
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>