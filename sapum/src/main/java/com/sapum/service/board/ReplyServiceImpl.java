package com.sapum.service.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sapum.domain.board.ReplyDTO;
import com.sapum.perisitence.board.BoardDAO;
import com.sapum.perisitence.board.ReplyDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReplyServiceImpl implements ReplyService {
	@Inject
	private ReplyDAO rDao;
	@Inject
	private BoardDAO bDao;
	
	
	@Override
	public List<ReplyDTO> list(int bno) {
		return rDao.list(bno);
	}

	@Override
	public void create(ReplyDTO rDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int rno) {
		// TODO Auto-generated method stub
		
	}

}
