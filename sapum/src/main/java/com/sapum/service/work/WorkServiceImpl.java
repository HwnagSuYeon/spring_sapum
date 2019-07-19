package com.sapum.service.work;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapum.domain.work.WorkDTO;
import com.sapum.perisitence.work.WorkDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WorkServiceImpl implements WorkService{
	@Inject
	private WorkDAO wDao;

	@Override
	public int countArticle(String search_option, String keyword) {
		return wDao.countArticle(search_option, keyword);
	}

	@Override
	public List<HashMap<String, Object>> listAll(String sort_option, String search_option, String keyword, int start, int end) {
		return wDao.listAll(sort_option, search_option, keyword, start, end);
	}
	// 조회수 증가처리
	@Override
	public void increaseViewCnt(int wno, HttpSession session) {
		long update_time = 0;
		
		if(session.getAttribute("update_time_"+wno) != null) {
			// 최근에 조회수를 올린 시간
			update_time = (long)session.getAttribute("update_time_"+wno);
		}
		long current_time = System.currentTimeMillis();
		
		// 24시간 경과 후 조회수 증가처리
		if (current_time - update_time > 24*60*60*1000) {
			wDao.increaseViewCnt(wno);
			// 조회수 올린 시간 저장
			session.setAttribute("update_time_"+wno , current_time);
		}
	}
	// 게시글 조회페이지 출력
	@Override
	public WorkDTO read(int wno) {
		return wDao.read(wno);
	}
	// 작품 삭제기능 수행
	@Override
	public void delete(int wno) {
		wDao.delete(wno);
	}
	@Override
	public void update(WorkDTO wDto) {
		wDao.update(wDto);
	}
	
	@Transactional
	@Override
	public void create(WorkDTO wDto) {
		log.info(">>>>>>>>>>>>>service"+wDto.toString());
		// 등록기능 수행
		wDao.create(wDto);
		
		// 등록이 성공하면 attach테이블에 첨부파일 이름 추가
		String files[] = wDto.getFilename();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@2파일이름>>"+wDto.getFilename());
		// 첨부파일이 없으면 skip
		if (files == null) return;
		// 작품등록시 첨부파일이 여러개면 하나씩 반복문을 돌며 넣어주는 기능
		// files.length-1 => 파일이 하나만 올라갈 수 있도록 한다. 배열 -1 은 마지막 파일을 의미.
		// 화면단이나 DTO에서 배열로 받지 못하도록 설정해도, 쌤이 준 소스중 배열로 받아서 저장하는 부분이 있어서 여기서 files.length-1로받도록 설정했다.
		// 또한 스프링에서는 문자열 배열로 된 구조를 String타입으로 받으라고 하면 ,를 붙여서 한줄로 만들어버림.
			wDao.addAttach(files[files.length-1]);

	}

	@Override
	public List<String> getAttach(int wno) {
		return wDao.getAttach(wno);
	}

	
}