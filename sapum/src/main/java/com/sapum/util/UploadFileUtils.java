package com.sapum.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.swing.filechooser.FileNameExtensionFilter;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitterReturnValueHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UploadFileUtils {
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		// 에이젝스 업로드 컨트롤러에서 매개변수로 uploadPath=저장할경로, originalName=파일이름, fileData=바이트단위의 파일 사이즈를 받아옴
		// uuid발급 => 랜덤으로 만들어지는 36자리의 id. 중복된 이름이 들어오는 것을 막음. uuid + 파일이름 이런식으로 들어와 파일명이 같아도 uuid가 다르기때문에 처리가 가능하다.
		UUID uid = UUID.randomUUID(); // 랜덤으로 된 36자리의 uuid가 uid에 담김
		String savedName = uid.toString() + "_" + originalName; // 생성된 uid에 _ + 실제 첨부된 파일 이름이 추가됨(ex -> 1asdfs-sdf54322-1df235-sd12354_여름.jpg)
		//업로드할 디렉토리 생성
		String savedPath = calcPath(uploadPath); //calcPath? -> 날짜 디렉토리를 생성해준다. 날짜별로 디렉토리를 생성해줌. savedPath=아래서 컬크패스가 계산한 결과를 담음
		File target = new File(uploadPath + savedPath, savedName); // 지정한 경로 안에 uuid가 붙은 파일을 넣어라 (여기서 로컬서버에 실제로 첨부파일을넣음)
		// 임시 디렉토리에 업로드된 파일을 지정된 디렉토리로 복사
		FileCopyUtils.copy(fileData, target); // 파일카피유틸즈로 가는데 파일데이터랑 타겟 갖고가
		// 파일의 확장자 검사
		// a.jpg / aaa.bbb.ccc.jpg
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1); // 파일의 실제 이름에서 끝에서부터 첫번째 점을 찾고, +1 을 함으로써 점은 제외한 뒤의 확장자만 가져옴. 포맷네임에는 확장자만 들어오게 된다.
		String uploadedFileName = null;
		// 이미지 파일은 썸네일 사용
		if(MediaUtils.getMediaType(formatName) != null) {
			// 썸네일 생성
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName); // makeThumbnail함수를 실행하는데, 저장경로, 날짜별로생성하는 디렉터리, uuid가 붙은 파일이름을 함께 보냄
		} else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		return uploadedFileName;
	}
	// 아이콘 생성
	private static String makeIcon(String uploadPath, String path, String fileName)throws Exception {
		// 아이콘의 이름
		String iconName = uploadPath + path + File.separator + fileName;
		// 아이콘의 이름을 리턴
		// File.separatorChar: 디렉토리 구분자
		// 윈도우 \, 유닉스(리눅스)/
		return iconName.substring(uploadPath.length()).replace(File.pathSeparatorChar, '/');
	}
	
	private static String makeThumbnail(String uploadPath, String Path, String fileName)throws Exception {
		// 이미지를 읽기위한 버퍼
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + Path, fileName)); // 원본파일이 들어있다.
		// 100 픽셀 단위의 썸네일 생성(원본파일을 100px로 resize만 시킴. 어디에 저장한것이 X)
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100); // Scalr-> 썸네일을 만들어준다. 원본파일인sourceImg를 가져와 높이 기준으로(FIT_TO_HEIGHT) 100px단위로 썸네일을 만들라는 것.
		// 썸네일의 이름(썸네일의 이름은 기존 파일의 이름앞에 s_만 붙인다. 스트링타입의 변수만 생성해주고 거기에 썸네일의 저장경로와 이름만 넣어준 것. 아직 저장된것이 아님.)
		String thumbnailName = uploadPath + Path + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		// 확장자를 대문자로 변경해서 
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		// 썸네일 생성(실제로 썸네일을 만들고 저장이 되는 곳. 원본파일의 resize(썸네일 이미지), JPG, 저장경로, 날짜디렉토리, s_ + uuid가붙은 파일이름 -> 파일이 로컬서버에 저장이 됨.
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		// 썸네일의 이름을 리턴함(썸네일 이미지의 이름을 리턴함. /2019/07/12 s_asflkjlakflksfjdfal...000.jpg
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	// 날짜별로 디렉토리를 생성해주는 역할
	private static String calcPath(String uploadPath) {
		// uploadPath => 컨트롤러에서 받아온 파일 저장 경로
		Calendar cal = Calendar.getInstance(); // 오늘날짜가 들어감(ex. 2019-07-12)
		String yearPath = File.separator + cal.get(Calendar.YEAR); // 년도만 갖고와서 앞에 슬러시를 붙여줌(separator=/) -> (/+2019)
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // new DecimalFormat("00")->두자리수로 맞춰줌./ (Calendar.MONTH) + 1 -> 월을 갖고오는데, 0부터 월을 가져오기때문에 1을 더해준다.                                  
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // /2019/07 + / + 12 =/2019/07/12
		makeDir(uploadPath, yearPath, monthPath, datePath); // 완성된 결과물로 디렉토리를 만들어라=makeDir, uploadPath = D:/upload, yearPath=/2019, monthPath=/07, datePath=/12
		log.info(datePath); // 디렉토리를 만들기에 성공하면 데이트 패스를 출력
		return datePath; // datePath = /2017/07/12
	}
	
	private static void makeDir(String uploadPath, String... paths) {
		// type... -> ellipsis(일립시스): 생략. 값을 가변적으로 받기 위함. 배열로 받아주기때문에 갯수의 제한이 없다.
		// 디렉토리가 존재하면 skip
		if (new File(paths[paths.length -1]).exists()) {
			return;
		}
		for (String path : paths) {
			File dirPath = new File (uploadPath + path);
			if ( !dirPath.exists()) {
				dirPath.mkdir(); // 디렉토리 생성
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
