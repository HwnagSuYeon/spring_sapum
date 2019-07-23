<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.all_wrap{
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    flex-flow: column;
		    width: 100%;
		    height: 100%;
		    margin: 0 auto;
		    color: #4c4c4c;
		}
		.er_text_wrap{
			display: flex;
			justify-content: center;
			align-items: center;
			flex-flow: column;
		}
		.er_title {
			color: #70D6C7;
		}
		.er_img {
		    width: 260px;
   			margin-bottom: 60px;
		}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="all_wrap">
		<div class="img">
			<img class="er_img" src="${path}/resources/img/error_404.png">
		</div>
		<div class="er_text_wrap">
			<h3 class="er_title">That file isn’t here anymore</h3>
			<span class="er_content">Someone might’ve deleted the file or disabled the link.</span>
		</div>
	</div>
</body>
</html>