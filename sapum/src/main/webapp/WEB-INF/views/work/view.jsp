<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
<link rel="stylesheet" href="${path}/resources/lightbox/css/lightbox.css">
<script src="${path}/resources/lightbox/js/lightbox.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/work/workAll.css?v=1">
</head>
<body>
	<!-- 메인에서 작품을 눌렀을 때 모달이 뜨도록 한다(클릭이벤트) -->
	<div class="detail_all">
		<a href="${path}/work/list" class="detail_delete"><i class="fas fa-times all_close_btn"></i></a>
		<div class="board_all">
			<div class="board">
				<div class="work_wrap">
					<div id="uploadedList" class="mailbox-attachments clearfix uploadedList work_wrap"></div>
				</div>
				<div class="work_text_wrap">
					<div class="menu_btn">
						<c:if test="${!empty sessionScope.userid}">
							<div class="i_wrap">
								<a class="down_icon"><i class="fas fa-file-download do_icon"></i></a>
								<a class="down_icon" id="unlike"><i class="far fa-heart do_icon"></i></a>
								<a class="down_icon" id="like"><i class="fas fa-heart do_icon"></i></a>
							</div>
							<span class="sp_margin"></span>
							<c:if test="${sessionScope.userid != one.writer}">
								<button id="follow_btn" type="button" class="follow_btn">Follow</button>
							</c:if>
						</c:if>
					</div>
					<div class="te_user">
						<h3 class="wo_user_name">${one.title}</h3>
						<div></div>
						<span class="follower_cnt">
							<span class="work_username">${one.writer}</span>
							<span>Follower</span>
							<span id="follower_cnt" class="fl_cnt"></span></span>
						<span class="work_text_con">${one.content}</span>
					</div>
					<div class="button_wrap">
						<button type="button" class="worker_link">See this artist's work</button>
					</div>
					<div class="comment_wrap">
						<h3>Comment</h3>
						<span class="see_comm"><i class="fas fa-chevron-down"></i></span>
					</div>
					
					
					
					<div class="hidden_comment" style="display: none;">
						<div id="commentList"></div>
					</div>
					
					
					
					<div class="de_up_btn">
						<c:if test="${sessionScope.userid == one.writer}">
							<button type="button" id="work_delete_btn" class="follow_btn re_btn">Remove</button>
							<button id="work_upBtn" type="button" class="follow_btn mo_btn">Modify</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- work delete modal -->
	<div id="wo_de_modal" class="work_modal" style="display: none;">
		<div class="work_modal_box delete_modal">
			<div class="work_modal_wrap">
				<span id="wo_de_btn" class="lo_modal_close"><i class="fas fa-times"></i></span>
				<h1 class="de_modal_title delete_title">Are you sure to<br> delete this work?</h1>
				<span class="warring"><i class="fas fa-exclamation-circle"></i></span>
				<div class="">
					<button id="n_btn" type="button" class="n_btn">NO</button>
					<button id="work_delBtn" type="button" class="n_btn">YES</button>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	<script id="fileTemplate" type="text/x-handlebars-template">
           <img src="{{originalFileUrl}}" alt="Attachment" class="s_img">
	</script>
	<script type="text/javascript">
	//Handlebars 파일템플릿 컴파일
	var fileTemplate = Handlebars.compile($("#fileTemplate").html());
	// 디테일페이지
	$(document).ready(function() {
		// 좋아요가 기존에 있는지 없는지 알기위한 메서드 호출
		if(${!empty sessionScope.userid}) check_like();
		
		// 댓글 목록을 띄우기 위한 메서드 호출
		comment_list();
		
		// 첨부파일 출력
		var listCnt = listAttach();
		
		// 첨부파일 0건일 때 '첨부파일이 없습니다' 출력
		/* if(listCnt == 0){
			var text = '<span class="no_attach">첨부파일이 없습니다.</span>';
			$('#uploadedList').html(text);
		} */
		
		// 팔로우버튼을 눌렀는지 안눌렀는지 알기위한 메서드 호출
		followCk();
		

		// 코멘트 박스 보기 아래화살표 누르면 댓글 다는 공간 나옴
		var flag = 0;
		
		$('.see_comm').click(function() {
			if(flag == 0) {
				$('.hidden_comment').css('display','block');
				$('.comment_wrap').css('border-bottom', '0px');
				flag = 1;
			} else {
				$('.hidden_comment').css('display','none');
				$('.comment_wrap').css('border-bottom', '1px solid #EAEAEA');
				flag = 0;
			}
			
		});

		// 좋아요버튼 기능
		$('#unlike').click(function() {
			check_like();
			like_switch();
		});		
		$('#like').click(function() {
			check_like();
			like_switch();
		});

		//작품 삭제버튼 누르면 정말 삭제할거냐 물어보는 모달창
		$('#work_delete_btn').click(function() {
			$('.work_modal').css('display', 'flex');
		});
		$('#n_btn').click(function() {
			$('.work_modal').css('display', 'none');
		});
		$('#wo_de_btn').click(function() {
			$('.work_modal').css('display', 'none');
		});
		
		// 작품삭제버튼 누를시 컨트롤러로 보냄
		$('#work_delBtn').click(function () {
			location.href = "${path}/work/delete?wno=${one.wno}";
		});
		
		// 작품 수정버튼 누를시 컨트롤러로 보냄
		$('#work_upBtn').click(function () {
			location.href = "${path}/work/register?wno=${one.wno}";
		})
		
		// 팔로우/언팔로우 스위치 기능
		$('#follow_btn').click(function () {
			$.ajax({
				type: "GET",
				url: "${path}/member/follow_switch",
				data: "followingId=${one.writer}",
				success: function () {
					followCk();
				}
			});
		});
		
		
		
	});
	
	// comment_list.jsp를 띄워주기위한 function
	function comment_list() {
		$.ajax({
			type: "GET",
			url: "${path}/workReply/list?wno=${one.wno}",
			success: function (result) {
				$('#commentList').html(result);
			}
		});
	} 
	
	//첨부파일 리스트를 출력하는 함수
	function listAttach(){
		var listCnt = 0;
		$.ajax({
			type: "post",
			url: "${path}/work/getAttach/${one.wno}", // url 자체로 wno를 보내버림.
			async: false,
			success: function(list){
				// list : json
				//console.log(list);
				listCnt = list.length;
				
				/* console.log(list.length); */
				/* 
					jQuery each()는 반복문
					i와 e는 index와 element로
					json에서 { 0: "apple.png"}일 때
					index는 0, element는 apple.png가 됨
				*/
				$(list).each(function(i, e){
					/* console.log(list) */
					printFiles(e); // 첨부파일 출력 메서드 호출
				});
			}
		});
		return listCnt;
	}
	
	// 파일 정보 처리
	function getFileInfo(fullName) {
	    var originalFileName;   // 화면에 출력할 파일명
	    var imgSrc;                   // 썸네일 or 파일아이콘 이미지 파일 출력 요청 URL
	    var originalFileUrl;       // 원본파일 요청 URL
	    var uuidFileName;       // 날짜경로를 제외한 나머지 파일명 (UUID_파일명.확장자)
	    var basicFileName = fullName;      // 삭제시 값을 전달하기 위한 파일이름을 줄이지 않은 url
		
	    // 이미지 파일이면
	    if (checkImageType(fullName)) {
	        imgSrc = "${path}/upload/displayFile?fileName=" + fullName; // 썸네일 이미지 링크
	        uuidFileName = fullName.substr(14); // 전체이름에서 14만큼(날짜파일디렉토리와s_를 잘라줌) 문자열을 자름 => 실제 uuid가붙은 원본 파일의 이름
	        var originalImg = fullName.substr(0, 12) + fullName.substr(14); // 오리지널 이미지의 경로를 만들어줌. /2019/07/12asdfas-asdfasd...000.jpg
	        // 원본 이미지 요청 링크(쿼리스트링으로 오리지널 이미지의 경로를 붙이고 경로를 변수에 담아줌. 아직 실행 안함)
	        originalFileUrl = "${path}/upload/displayFile?fileName=" + originalImg;
	    } else {
	        imgSrc = "${path}/resources/img/file-icon.png"; // 파일 아이콘 이미지 링크
	        uuidFileName = fullName.substr(12);
	        // 파일 다운로드 요청 링크
	        // uuidFileName.indexOf("_") => 실제 파일 이름을 구함. uuid와 _를 제외(+을 한 이유임)한 실제 파일 이름 000.jpg
	        originalFileUrl = "${path}/upload/displayFile?fileName=" + fullName;
	    }
	    originalFileName = uuidFileName.substr(uuidFileName.indexOf("_") + 1);
	 // 전체 파일명의 크기가 14보다 작으면 그대로 이름 출력,
	    // 14보다 크면 실행
	    if(originalFileName.length > 14) {
	    	// 앞에서부터 11글자 자름
	    	var shortName = originalFileName.substr(0, 10);
	    	// .을 기준으로 배열 생성
	    	var formatVal = originalFileName.split(".");
		// formatVal = originalFileName.substr(originalFileName.length-3);
		// 파일명에 .이 여러개 들어가 있을수도 있음
		// 배열크기를 구해와서 무조건 맨 마지막 확장자부분 출력되게 함
		var arrNum = formatVal.length - 1
		// 맨 처음 문자열 10글자 + ... + 확장자
		originalFileName = shortName + "..." + formatVal[arrNum];
	    }
	 	// 리턴으로 보내주는 데이터는 JSON타입
	    return {originalFileName: originalFileName, imgSrc: imgSrc, originalFileUrl: originalFileUrl, fullName: fullName, basicFileName: basicFileName};
	}
	//첨부파일 출력
	function printFiles(data) {
		// data = 날짜파일디렉토리와 썸네일 이름
	    // 파일 정보 처리
	    var fileInfo = getFileInfo(data);
	    /* console.log(fileInfo); */
	    // Handlebars 파일 템플릿에 파일 정보들을 바인딩하고 HTML 생성
	    // fileTemplate -> 
	    var html = fileTemplate(fileInfo);
	    html += "<input type='hidden' class='file' value='"
			+fileInfo.fullName+"'>";
	    // Handlebars 파일 템플릿 컴파일을 통해 생성된 HTML을 DOM에 주입
	    $(".uploadedList").append(html);
	    // 이미지 파일인 경우 aaaaaaaaaaa파일 템플릿에 lightbox 속성 추가
	    // 썸네일 이미지인지 아닌지 판별하는 if문
	    if (fileInfo.fullName.substr(12, 2) === "s_") {
	        // 마지막에 추가된 첨부파일 템플릿 선택자
	        var that = $(".uploadedList li").last();
	        // lightbox 속성 추가
	        that.find(".mailbox-attachment-name").attr("data-lightbox", "uploadImages"); // mailbox-attachment-name(썸네일)을 누르면 미리보기 기능(라이트박스)을 함. 라이트박스 속성을 주지 않으면 이미지를 클릭하면 다운이 되버림.
	        // 파일 아이콘에서 이미지 아이콘으로 변경(이미지가 아닌 다른 파일이 들어오면 클립으로 이미지가 들어옴)
	        that.find(".fa-paperclip").attr("class", "fa fa-camera");
	    }
	}
	function getOriginalName(fileName){
		if(checkImageType(fileName)){ //이미지 파일이면 skip
			return;
		}
		var idx=fileName.indexOf("_")+1; //uuid를 제외한 파일이름
		return fileName.substr(idx);
	}
	function getImageLink(fileName){
		if(!checkImageType(fileName)){//이미지 파일이 아니면 skip
			return;
		}
		var front=fileName.substr(0,12);//연월일 경로
		var end=fileName.substr(14);// s_ 제거
		return front+end;
	}
	function checkImageType(fileName){
		var pattern=/jpg|gif|png|jpeg/i; //정규표현식(대소문자 무시)
		return fileName.match(pattern); //규칙에 맞으면 true
	}
	
	// 좋아요를 실질적으로 주는 기능
	function like_switch() {
		var wno = "${one.wno}";
		$.ajax({
			type: "post",
			url: "${path}/like/switch_like?wno="+wno,
			success: function(result) {
				check_like();
			}
		});
	} 
	// 기존에 좋아요를 준적 있는지 없는지 확인하는 기능
	function check_like() {
		var wno = "${one.wno}";
		$.ajax({
			type: "post",
			url: "${path}/like/check_like?wno="+wno,
			success: function(result) {
				if(result == 1) {
					$('#unlike').css('display','none');
					$('#like').css('display','block');
				} else {
					$('#unlike').css('display', 'block');	
					$('#like').css('display','none');
				}
			}
		});
	} 
	
	// 팔로우 버튼을 눌렀는지 안눌렀는지 상태를 알기위한 ajax
	function followCk() {
		$.ajax({
			type: "GET",
			url: "${path}/member/followCk",
			data: "followingId=${one.writer}",
			success: function(result) {
				if(result.followCk == 0){
					$('#follow_btn').css('background-color','#70D6C7')
									.text('Follow');
				} else {
					$('#follow_btn').css('background-color','#dadada')
								    .text('UnFollow');
				}
				$('#follower_cnt').text(result.follewr_count);
			}
		});
	}
	
	// 댓글 등록버튼을 눌렀을 때 유효성 검사 및 컨트롤러 이동
	$(document).on('click', '#cmt_add_btn', function () {
		var content = $('.comm_inp').val();
		var cmt_writer = '${sessionScope.userid}';
		var writer = $('.comment_userid').val(cmt_writer);
		
		if(content == "") {
			$('.cmt_err_msg').css('display', 'block');
			$('.comm_inp').focus();
			return false;
		} else {
			var wno = '${one.wno}';
			$('#cmt_wno').val(wno);
			$.ajax({
				url: "${path}/workReply/create",
				type: "POST",
				data: $('.comment_frm').serialize(),
				contentType: 'application/x-www-form-urlencoded; charset+UTF-8',
				success: 
					function () {
						comment_list();
						$('.comm_inp').val("");
					},
				error: function () {
					alert("system error");
				}
				
			});
		}
	});
	
	// 댓글 삭제기능
	$(document).on('click', '#cmt_del', function () {
		var wrno = $(this).attr("data_num");
		var cmt_writer = $("#cmt_writer").attr("data_num2");
		$.ajax({
			url: "${path}/workReply/delete",
			type: "GET",
			data: "wrno="+wrno+"&cmt_writer="+cmt_writer,
			success: 
				function () {
					comment_list();
				},
			error: function () {
				alert("system error");
			}
			
		});
	});
	
	
	</script>
</body>
</html>