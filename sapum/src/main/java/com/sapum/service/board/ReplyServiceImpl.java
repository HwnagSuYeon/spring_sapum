package com.sapum.service.board;

import java.util.HashMap;
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
		// 1. 댓글 DB에 등록
		rDao.create(rDto);
		// 2. 해당 게시글에  replycnt +1
		HashMap<String, Object> map = new HashMap<>();
		map.put("flag", "plus");
		map.put("bno", rDto.getBno());
		bDao.updateReplyCnt(map);
	}

	@Override
	public void delete(ReplyDTO rDto) {
		// 1. DB에서 댓글 삭제
		rDao.delete(rDto.getRno());
		// 2. 해당 게시글 replycnt -1
		HashMap<String, Object> map = new HashMap<>();
		map.put("flag", "minus");
		map.put("bno", rDto.getBno());
		bDao.updateReplyCnt(map);
	}

}
