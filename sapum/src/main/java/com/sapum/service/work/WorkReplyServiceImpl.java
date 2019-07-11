package com.sapum.service.work;

import java.util.List;

import javax.inject.Inject;

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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int bno) {
		// TODO Auto-generated method stub
		
	}

	
}
