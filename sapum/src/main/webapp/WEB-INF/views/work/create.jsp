<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/work/work.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- 작품 업로드 페이지 -->
	<div class="detail_all">
		<a href="${path}/work/list" class="detail_delete"><i class="fas fa-times all_close_btn"></i></a>
		<div class="board_all">
			<div class="board">
				<div class="work_wrap up_img">
					<div class="up_img_line">
						<div class="up_icon"><i class="fas fa-arrow-circle-up"></i></div>
						<span class="up_text">Drag or click to upload</span>
						<span class="up_wor">Recommendation: High-quality imagery</span>
					</div>
				</div>
				<input class="img_uplaod_in" type="file" style="display: none;" name="">
				<div class="work_text_wrap">
					<div class="te_user up_all">
						<form class="upload_work_frm" name="" method="" action="">
							<div class="up_instyle">
								<input type="text" name="" class="upload_title" placeholder="title">
							</div>
							<span class="up_user_wrap">
								<span class="up_user_dot"></span>
								<span class="comm_user">lim</span>
							</span>
							<span class="up_follower_cnt"><span>Follower</span> <span class="fl_cnt">345</span></span>
							<div class="up_instyle">
								<textarea class="comm_inp" placeholder="Explain your work"></textarea>
							</div>
							<input type="hidden" name="writer" value="">
							<button type="button" class="follow_btn up_btn">Upload</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
	//작품 업로드페이지
	$(document).ready(function() {
		//이미지 올리는데 클릭하면 숨겨져있는 인풋파일이 클릭되게 하는 기능
		$('.up_img').click(function() {
			$('.img_uplaod_in').click();
		});
		//타이틀 쓰는부분 클릭하면 라인 색 바뀌게
		$('.upload_title').click(function() {
			$(this).css('border-bottom','1px solid #70D6C7');
		});
		$('.upload_title').blur(function() {
			$(this).css('border-bottom','1px solid #eaeaea');
		});
		//설명쓰는 박스 크기 키웠다가 줄어들었다가
		$('.comm_inp').focus(function() {
			$(this).css('border', '1px solid #70D6C7')
				   .css('height', '90px');
		});
		$('.comm_inp').blur(function() {
			$(this).css('border', '1px solid #EAEAEA')
				   .css('height', '30px');
		});
	});
	</script>
</body>
</html>