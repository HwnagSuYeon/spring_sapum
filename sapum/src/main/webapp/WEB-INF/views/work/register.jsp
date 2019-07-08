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
				<!-- 게시글 첨부파일 등록 -->
				<div class="write_input_wrap form_group">
					<div class="baord_div fileDrop">
						<p>
							<i class="up_icon fas fa-arrow-circle-up"></i>
						</p>
					</div>
				</div>
				<div class="wrote_input_wrap">
					<ul id="uploadedList" class="mailbox-attachments clearfix uploadedList"></ul>
				</div>
				
			
				<!-- <div class="work_wrap up_img">
					<div class="up_img_line">
						<div class="up_icon"><i class="fas fa-arrow-circle-up"></i></div>
						<span class="up_text">Drag or click to upload</span>
						<span class="up_wor">Recommendation: High-quality imagery</span>
					</div>
				</div> 
				<input class="img_uplaod_in" type="file" style="display: none;" name=""> -->
				<div class="work_text_wrap">
					<div class="te_user up_all">
						<form class="upload_work_frm" method="POST" action="${path}/work/<c:out value="${wDto.wno == 0 ? 'create' : 'update' }"/>">
							<div class="up_instyle">
								<input type="text" name="title" class="upload_title" placeholder="title" value="${wDto.title}">
								<input type="text" name="w_img" class="upload_title" placeholder="w_img" value="${wDto.w_img}">
							</div>
							<span class="up_user_wrap">
								<span class="up_user_dot"></span>
								<span class="comm_user">${sessionScope.userid}</span>
							</span>
							<span class="up_follower_cnt"><span>Follower</span> <span class="fl_cnt">345</span></span>
							<div class="up_instyle">
								<textarea class="comm_inp" placeholder="Explain your work" name="content">${wDto.content}</textarea>
							</div>
							<input type="hidden" name="writer" value="${sessionScope.userid}" name="writer">
							<input type="hidden" name="wno" value="${wDto.wno}">
							<button id="upload_Btn" type="button" class="follow_btn up_btn">Upload</button>
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
		
		// 업로드 버튼을 눌렀을 때
		$('#upload_Btn').click(function () {
			$('.upload_work_frm').submit();
		});
		
		// 드래그앤드롭 기본 효과 막음
		// : 작업 안하면 실제파일이 열림
		$('.fileDrop').on('dragenter dragover', function (e) {
			e.preventDefault();
		});
		// drop했을 때 일어나는 동작임
		$('.fileDrop').on('drop', function (e) {
			e.preventDefault();
			
			//Ajax 파일 -> d://upload
			//첫번째 첨부파일(다중첨부파일을 막음. 세개의 파일을 드래그 해서 드롭하면 그중에서 가장 첫번째의 파일만 가져오도록 하는 기능이다)
			var files = e.originalEvent.dataTransfer.files; //드래그에 전달된 첨부파일 전부
			var file = files[0]; // 그중 하나만 꺼냄
			alert(file);
			//폼 데이터에 첨부파일 추가
			var formData = new FormData(); // 폼 객체
			formData.append("file", file) // 폼에 파일변수 추가
			// 서버에 파일 업로드(백그라운드에서 실행됨)
			// contentType: false => multipart/form-data로 처리
			$.ajax({
				url: "${path}/upload/uploadAjax",
				data: formData,
				dataType: "text",
				processData: false,
				contentType: false,
				type: "POST",
				success: function (data) {
					consol.log(data);
					//data: 업로드한 파일 정보와 http 상태 코드
					printFiles(data); // 첨부파일 출력 메서드 호출
				}
			});
		});
		
	});
	</script>
</body>
</html>