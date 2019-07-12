package com.sapum.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	private static Map<String, MediaType> mediaMap;
	// 클래스를 로딩할 때 제일 먼저 실행되는 코드
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG",MediaType.IMAGE_JPEG);
		mediaMap.put("GIF",MediaType.IMAGE_GIF);
		mediaMap.put("PNG",MediaType.IMAGE_PNG);
	}
	public static MediaType getMediaType(String type) {//type 확장자가 들어옴
		// toUpperCase()대문자로 변경
		return mediaMap.get(type.toUpperCase()); // 확장자가 전부 대문자로 바뀜
		// 위에서 만든 미디어 맵중 일치하는 것만 가져옴. 예를들어 jpg면 위의 JPG맵만 가져오는 것
	}
}
