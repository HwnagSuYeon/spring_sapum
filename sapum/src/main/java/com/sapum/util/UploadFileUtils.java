package com.sapum.util;

import java.io.File;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UploadFileUtils {
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		//uuid발급
		UUID uid = UUID.randomUUID();
		String sacedName = uid.toString() + "_" + originalName;
		//업로드할 디렉토리 생성
		String savedPath = calcPath(uploadPath);
		File target = new File(uploadPath + savedPath, sacedName);
		// 임시 디렉토리에 업로드된 파일을 지정된 디렉토리로 복사
		FileCopyUtils.copy(fileData, target);
		// 파일의 확장자 검사
		// a.jpg / aaa.bbb.ccc.jpg
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName = null;
		// 이미지 파일은 썸네일 사용
		if(MediaUtils.getMediaType(formatName) != null) {
			// 썸네일 생성
			uploadedFileName = makeThumbnail(uploadPath, savedPath, sa)
		}
	}
}
