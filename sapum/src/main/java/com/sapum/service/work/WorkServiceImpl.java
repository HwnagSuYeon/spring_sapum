package com.sapum.service.work;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

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
	public List<WorkDTO> listAll(String sort_option, String search_option, String keyword, int start, int end) {
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
	// 작품 추가기능 수행
	@Override
	public void create(WorkDTO wDto) {
		log.info(">>>>>>>>>>>>>service"+wDto.toString());
		wDao.create(wDto);
	}
	// 작품 수정기능 수행
	@Override
	public void update(WorkDTO wDto) {
		wDao.update(wDto);
	}
	
	
	
	
}