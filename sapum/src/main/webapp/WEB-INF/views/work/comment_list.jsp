<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/work/work.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<span class="com_text">There are no registered comments</span>
	<span class="com_text"><a class="cmt_login" href="#" style="color: #70D6C7;">Login</a> to comment</span>
	<span class="com_text">
		<span class="cmt_user">
			<span class="user_name"><span class="dot"></span> lim</span>
			<a href="#" class="cmt_del_btn"><i class="fas fa-backspace"></i></a>
		</span>
		<span class="cmt_content">
			ㅋㅋㅋㅋㅋㅋㅋ
		</span>
	</span>
	<form class="comment_frm" action="" name="" method="">
		<span class="user_wrap">
			<span class="user_dot"></span>
			<span class="comm_user">lim</span>
		</span>
		<div class="conn_inp">
			<textarea class="comm_inp" placeholder="write your comment"></textarea>
		</div>
		<input type="hidden" name="id" class="comment_userid" value="">
		<button type="button" class="cmt_add_btn"><i class="fas fa-plus"></i></button>
	</form>
</body>
</html>