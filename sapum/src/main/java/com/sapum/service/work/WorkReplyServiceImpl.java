package com.sapum.service.work;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.sapum.domain.work.WorkReplyDTO;
import com.sapum.perisitence.work.WorkReplyDAO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class WorkReplyServiceImpl implements WorkReplyService{
	@Inject
	private WorkReplyDAO rDao;
	
	@Override
	public List<WorkReplyDTO> list(int wno) {
		return rDao.list(wno);
	}

	@Override
	public void create(WorkReplyDTO rDto) {
		rDao.create(rDto);
	}



	@Override
	public void delete(HttpSession session, int wrno, String cmt_writer) {
		// url로 접근해서 댓글 삭제할수도 있으니까 session 검사
		String userId = (String) session.getAttribute("userId");
		if(userId == cmt_writer) {
			rDao.delete(wrno);
		}
	}
}
