package com.sapum.service.work;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.sapum.perisitence.work.LikeDAO;
import com.sapum.perisitence.work.WorkDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LikeServiceImpl implements LikeService{
	@Inject
	private LikeDAO lDao;
	@Inject
	private WorkDAO wDao;
	
	@Override
	public int check_like(int wno, HttpSession session) {
		String id = (String)session.getAttribute("userid");
		return lDao.check_like(wno, id);
	}

	@Override
	public void switch_like(int wno, HttpSession session) {
		String id = (String)session.getAttribute("userid");
		int result = lDao.check_like(wno, id);
		
		if(result == 0){
			// 좋아요 준 기록 없음  --> tbl_sa_like insert
			// 좋아요 테이블에 좋아요를 주고
			lDao.insertLike(wno, id);
			// work테이블에 goodcnt에 +1해줘야함
			wDao.updateLikecnt(wno, result);
		} else {
			// 좋아요 준 기록 있음  --> tbl_sa_like delete
			lDao.deleteLike(wno, id);
			wDao.updateLikecnt(wno, result);
		}
	}
	
	
}
