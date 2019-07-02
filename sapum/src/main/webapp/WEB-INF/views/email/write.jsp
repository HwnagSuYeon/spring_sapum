<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/board/board.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<div class="mail_wrap">
		<h2 class="mail_title">Send E-mail</h2>
		<form class="maiil_frm" method="POST" action="${path}/email/send">
			<div class="mail_box">
				<span class="box_title">발신자 이름</span>
				<input class="box_input" name = "senderName">
			</div>
			<div class="mail_box">
				<span class="box_title">발신자 이메일주소</span>
				<input class="box_input" name="senderMail">
			</div>
			<div class="mail_box">
				<span class="box_title">수신자 이메일주소</span>
				<input class="box_input" name="receiveMail" value="shrcktndus@gmail.com">
			</div>
			<div class="mail_box">
				<span class="box_title">제목</span>
				<input class="box_input" name="subject">
			</div>
			<div class="mail_box">
				<span class="box_title">내용</span>
				<textarea style="resize: none;" class="box_input txt_area" rows="5" cols="80" name="message"></textarea><br>
			</div>
			<input class="email_btn" type="submit" value="SUBMMIT">
		</form>
		<span class="mail_msg">${message}</span>
	</div>
	<%@ include file="../include/footer.jsp"%>
</body>
</html>