package com.sapum.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sapum.service.board.BoardService;
import com.sapum.util.MediaUtils;
import com.sapum.util.UploadFileUtils;

@Controller
public class AjaxUploadController {
	// 로깅을 위한 변수
	private static final Logger logger = LoggerFactory.getLogger(AjaxUploadController.class);
	
	@Inject
	BoardService boardService;

	// 업로드 디렉토리 servlet-context.xml에 설정되어 있음
	@Resource(name = "uploadPath")
	String uploadPath;

	// 파일첨부 페이지로 이동
	@RequestMapping(value = "upload/uploadAjax", method = RequestMethod.GET)
	public String uploadAjax() {
		return "/upload/uploadAjax";
	}

	// 업로드한 파일은 MultipartFile 변수에 저장됨
	@ResponseBody // json 형식으로 리턴
	@RequestMapping(value = "upload/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		// 화면단에서 보낸 file의 타입이 멀티파트파일. 매개변수로 받은 file내에는 드래그앤드롭으로 첨부한 파일이 들어있다.
		// 업로드한 파일 정보와 Http 상태 코드를 함께 리턴
		
		// ResponseEntity => 기존에 응답할때는 화면단 주소 등을 보냈는데, ResponseEntity는 HTTP에 상태코드(잘 되었으면 200번대코드, 서버를 못찾을때는 400, 화면단을 못찾을때는 500번대)를 함께 보낼 때 쓴다.
				// UploadFileUtils앞글자가 대문자. 그러므로 클래스명이고, static이다. 객체 생성없이 참조 가능.
				// UploadFileUtils 클래스를 참조해서 uploadFile 메서드 실행(uploadFile뒤에 괄호가 붙어있으므로 메서드이다)
				// uploadFile메서드 안에 매개변수로 uploadPath를 갖고간다. uploadPath => 서블릿컨텍스트루트에서 설정해줌. D:\\uploadfile
				// file.getOriginalFilename = file의 이름(000.jpg)
				// file.getBytes() = 바이트단위의 파일 사이즈
		return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
	}

	// 이미지 표시 기능
	@ResponseBody // view가 아닌 data 리턴
	@RequestMapping("upload/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		// 서버의 파일을 다운로드하기 위한 스트림
		InputStream in = null; // java.io
		ResponseEntity<byte[]> entity = null;
		try {
			// 확장자 검사
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			// 헤더 구성 객체
			HttpHeaders headers = new HttpHeaders();
			// InputStream 생성
			in = new FileInputStream(uploadPath + fileName);
//			if (mType != null) { // 이미지 파일이면
//				headers.setContentType(mType);
//			} else { // 이미지가 아니면
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				// 다운로드용 컨텐트 타입
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				// 큰 따옴표 내부에 " \" "
				// 바이트배열을 스트링으로
				// iso-8859-1 서유럽언어
				// new String(fileName.getBytes("utf-8"),"iso-8859-1")
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(
							fileName.getBytes("utf-8"), "iso-8859-1") + "\"");
				// headers.add("Content-Disposition"
				// ,"attachment; filename='"+fileName+"'");
//			}
			// 바이트배열, 헤더
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if (in != null)
				in.close(); // 스트림 닫기
		}
		return entity;
	}
	
	@ResponseBody //뷰가 아닌 데이터를 리턴. 이것이 붙어있음으로써 화면단에서 보낸 데이터를 json타입으로 받을 수 있다.
	@RequestMapping(value="upload/deleteFile", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		logger.info("fileName:"+fileName); 
		//확장자 검사
		String formatName=fileName.substring(fileName.lastIndexOf(".")+1);  // formatName에는 확장자가 들어있음
		MediaType mType=MediaUtils.getMediaType(formatName); // getMediaType은 static이기 때문에 클래스명으로 접근한다.
		if(mType != null) { //이미지 파일이면 원본이미지 삭제
			String front=fileName.substring(0, 12); // 0~11자리까지 읽으므로 날짜만 읽는다. 즉 front에는 날짜디렉터리 정보가 담김.
			String end=fileName.substring(14); // s가빠져있는 이름을 찾음. 즉 end에는 sid가포함된 원본파일 정보가 담김
			//File.separatorChar : 유닉스 / 윈도우즈\	
			new File(uploadPath+(front+end).replace('/',File.separatorChar)).delete(); // 유닉스, 윈도우에따라 경로를 찾아갈 수 있도록 설정해줌
		}
		//원본 파일 삭제(이미지이면 썸네일 삭제)
		new File(uploadPath+fileName.replace('/',File.separatorChar)).delete();
		//레코드 삭제
		// boardService.deleteFile(fileName); 
		
		//ResponseEntity -> 결과와 상태코드를 함께 보내는 것.
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	@ResponseBody //뷰가 아닌 데이터를 리턴
	@RequestMapping(value="upload/deleteAllFile", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files){
		logger.info("delete all files: " + files); 
		
		if(files == null || files.length == 0) {
			return new ResponseEntity<String>("deleted", HttpStatus.OK);
		}
		
		for(String fileName : files) {
			String formatName=fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType=MediaUtils.getMediaType(formatName);
			
			if(mType != null) { //이미지 파일이면 원본이미지 삭제
				String front=fileName.substring(0, 12);
				String end=fileName.substring(14);
				//File.separatorChar : 유닉스 / 윈도우즈\	
				new File(uploadPath+(front+end).replace('/',File.separatorChar)).delete();
			}
			
			//원본 파일 삭제(이미지이면 썸네일 삭제)
			new File(uploadPath+fileName.replace('/',File.separatorChar)).delete();
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
