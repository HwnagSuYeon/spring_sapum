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
<link rel="stylesheet" href="${path}/resources/css/work/workAll.css?v=1">
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
						<span class="up_text">Drag or click to upload</span>
						<span class="up_wor">Recommendation: High-quality imagery</span>
					</div>
				</div>
				<div class="write_input_wrap">
					<ul id="uploadedList" class="mailbox-attachments clearfix uploadedList"></ul>
				</div>
				<input class="img_uplaod_in" type="file" style="display: none;" name="">
				                         
			
				<!-- <div class="work_wrap up_img">
					<div class="up_img_line">
						<div class="up_icon"><i class="fas fa-arrow-circle-up"></i></div>
						<span class="up_text">Drag or click to upload</span>
						<span class="up_wor">Recommendation: High-quality imagery</span>
					</div>
				</div>  -->
				<div class="work_text_wrap">
					<div class="te_user up_all">
						<form class="upload_work_frm" method="POST" action="${path}/work/<c:out value="${wDto.wno == 0 ? 'create' : 'update' }"/>">
							<div class="up_instyle">
								<input type="text" name="title" class="upload_title" placeholder="title" value="${wDto.title}">
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
							<input type="hidden" name="filename" id="filename">
							<button id="upload_Btn" type="button" class="follow_btn up_btn">Upload</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	<script id="fileTemplate" type="text/x-handlebars-template">
    <li>
        <div class="mailbox-attachment-icon has-img">
            <center><img src="{{imgSrc}}" alt="Attachment" class="s_img"></center>
        </div>
        <div class="mailbox-attachment-info">
            <a href="{{originalFileUrl}}" class="mailbox-attachment-name">
                <i class="fa fa-paperclip"></i> {{originalFileName}}
            </a>
            <span class="btn btn-default btn-xs pull-right delBtn" data-src="{{basicFileName}}">
                <i class="fas fa-times"></i>
            </span>
        </div>
    </li>
	</script>
	<script type="text/javascript">
	//작품 업로드페이지
	
	//Handlebars 파일템플릿 컴파일
	var fileTemplate = Handlebars.compile($("#fileTemplate").html());
	// 수정시 로컬드라이브에서 삭제할 기존 첨부파일 목록
	var deleteFileList = new Array();
	
	$(document).ready(function() {
		// 등록 & 수정 페이지 디자인
		var wno = '${wDto.wno}';
		if(wno == '') {  // 게시글 등록
			
		} else {  // 게시글 수정
			var str='';
			str += "<input type='hidden' name='wno' value='" + wno + "'>";
			$("#frm_add").append(str);
		}
		
		// 첨부파일 목록 출력
		listAttach();
		
		// 답글이면 title 수정 못하게 막음
		var re_level = "${one.re_level}";
		if(re_level > 0) {
			$('#board_title').attr('readonly', 'readonly');
		}
		
		//이미지 올리는데 클릭하면 숨겨져있는 인풋파일이 클릭되게 하는 기능
		$('.write_input_wrap').click(function() {
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
			var str="";
			// uploadedList 내부의 .file 태그 각각 반복
			$("#uploadedList .file").each(function(i){
				alert($(this).val());
				// each = 인풋타입 히든으로 만든 class의 이름이 file의 갯수만큼 반복
				console.log(i);
				//hidden 태그 구성(files라는 배열에 인풋타입 히든에 val을 해당 태그의 값으로 넣어라. 그러니까 올린 파일의 갯수만큼 배열에 값을 순서대로 넣어주는 역할.)
				str += "<input type='hidden' name='filename' value='" + $(this).val()+"'>";
			});
			
			// 로컬드라이브에 저장되어있는 해당 게시글 
			// 첨부파일 삭제
			if(deleteFileList.length > 0) {
				$.post('${path}/upload/deleteAllFile', {files:deleteFileList}, function(){});
			}
			
			//폼에 hidden 태그들을 붙임
			$(".upload_work_frm").append(str);
			$('.upload_work_frm').submit();
		});
		
		// 드래그앤드롭 기본 효과 막음
		// : 작업 안하면 실제파일이 열림
		$('.fileDrop').on('dragenter dragover', function (e) {
			e.preventDefault();
		});
		
		// 1. 파일을 드래그 앤 드롭했을 때
		// drop했을 때 일어나는 동작임
		$('.fileDrop').on('drop', function (e) {
			// 드래그앤 드롭시 기본 파일실행을 막음
			e.preventDefault();
			
			// 첨부파일 하나만 올리도록함(하나 올리고 이어서 하나더 올리면 기존의 올려놨던 파일을 삭제하는 것)
			var dfile = $('.delBtn');
			if(dfile.length > 0) {
				$.ajax({
					url: "${path}/upload/deleteFile",
					type: "post",
				 // content: json,
					data: { fileName: dfile.attr("data-src") }, // 여기서 보내는 데이터(컨텐츠와 데이터는 한쌍)
					dataType: "text", // 컨트롤러에서 처리하고 받아온 데이터의 타입
					success: function(result) { // result는 text로 받는다고 위의 datatype에서 설정해준것(datatype과 result는 한쌍)
						if(result == "deleted") {
							dfile.parents("li").remove();
						}
					}, error: function() {
						alert("System Error!!!");
					}
				});	
			}
			
			
			//Ajax 파일 -> d://upload
			//첫번째 첨부파일(다중첨부파일을 막음. 세개의 파일을 드래그 해서 드롭하면 그중에서 가장 첫번째의 파일만 가져오도록 하는 기능이다)
			var files = e.originalEvent.dataTransfer.files; //드래그에 전달된 첨부파일 전부
			var file = files[0]; // 그중 하나만 꺼냄
			//폼 데이터에 첨부파일 추가: ajax로 객체를 보낼때 쓰는 것
			var formData = new FormData(); // 폼 객체
			formData.append("file", file); // 폼에 파일변수 추가 => append=추가기능, 기존에 있는 것의 맨 마지막에 추가된다. 기존것의 수정은 불가능하고 계속 꼬리부분에 추가만 가능.
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
					// data -> 썸네일 이름
					console.log(data);
					//data: 업로드한 파일 정보와 http 상태 코드
					printFiles(data); // 첨부파일 출력 메서드 호출
				}
			});
		});
		
		// 첨부파일 삭제 함수
		// 첨부파일을 올리기 전에 화면단에서 삭제버튼을 누르면 로컬저장소인 D드라이브에서도 삭제가 되도록 만드는 기능
		$(".uploadedList").on("click", ".delBtn", function(event) {
			var wno = '${wDto.wno}';
			var that = $(this);
			if(wno == 0) { // 게시글 등록
				$.ajax({
					url: "${path}/upload/deleteFile",
					type: "post",
				 // content: json,
					data: { fileName: $(this).attr("data-src") }, // 여기서 보내는 데이터(컨텐츠와 데이터는 한쌍)
					dataType: "text", // 컨트롤러에서 처리하고 받아온 데이터의 타입
					success: function(result) { // result는 text로 받는다고 위의 datatype에서 설정해준것(datatype과 result는 한쌍)
						if(result == "deleted") {
							that.parents("li").remove();
						}
					}, error: function() {
						alert("System Error!!!");
					}
				});	
			} else {
				/* 
					첨부파일 x버튼 클릭시 바로바로 드라이브에서 삭제해버리면
					수정작업중 수정을 취소했을 때 기존에 파일이 사라지는 문제가 발생
					따라서 삭제를 눌렀을 때 화면단에서는 삭제가 되지만 드라이브와 DB에서
					삭제하지 않고 삭제목록(list)을 따로 저장해 둔 후 실제 유저가
					수정버튼을 클릭했을 때 form태그에 append하고 가져가서 파일을 삭제
					및 수정
				*/
				var arr_size = deleteFileList.length;
				deleteFileList[arr_size] = $(this).attr("data-src");
				$(this).parents("li").next("input").remove();
				$(this).parents("li").remove();
				/* for (var i = 0; i <= deleteFileList.length; i++)
				console.log(deleteFileList[i]); */
			}
		});
	});
	
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
	
	//첨부파일 리스트를 출력하는 함수
	function listAttach(){
		var listCnt = 0;
		$.ajax({
			type: "post",
			url: "${path}/work/getAttach/${wDto.wno}",
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
	</script>
</body>
</html>