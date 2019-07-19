package com.sapum.service.work;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.sapum.domain.work.WorkDTO;

public interface WorkService {
	// 페이지네이션 계산을 위해 필요한 전체 게시물 수를 구함
	public int countArticle(String search_option, String keyword);
	
	// 게시글 목록(페이지나누기,검색기능포함)
	public List<HashMap<String, Object>> listAll(String sort_option, String search_option, String keyword, int start, int end);

	// 조회수 증가처리
	public void increaseViewCnt(int wno, HttpSession session);
	
	// 상세게시글조회
	public WorkDTO read(int wno);
	
	// 작품 삭제
	public void delete(int wno);
	
	// 작품 등록기능
	public void create(WorkDTO wDto);
	
	// 작품 수정기능
	public void update(WorkDTO wDto);

	public List<String> getAttach(int wno);
}
