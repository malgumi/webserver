<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/main.css" type="text/css">
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
	script.println("location.href = 'main.jsp'");
	script.println("</script>");
}
Post post = new PostDAO().getPost(post_id); 
%>

			<div class="container">
   				 <section>
      				  <div>
       				     <h3><%= post.getPost_title()%></h3>
       				     <div>
        			        <p>
        			        <span>작성자</span> <%= post.getUser_id() %>
           				    </p>
           				     <p><span>작성일</span>
           				       <%= post.getDate().substring(0,11) + post.getDate().substring(11, 13) + "시" + post.getDate().substring(14,16) + "분" %>
           				     </p>
            			 </div>
      			 	 </div>
    				  <div>
    				  	<div>
    				  		 <%= post.getPost_content().replaceAll("\"", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %>
    				  	</div>
    				  </div>
    				</section>
			</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrap.js"></script>

</body>
</html>
