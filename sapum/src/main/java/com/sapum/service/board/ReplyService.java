package com.sapum.service.board;

import java.util.List;

import com.sapum.domain.board.ReplyDTO;

public interface ReplyService {
	public List<ReplyDTO> list(int bno);
	public void create(ReplyDTO rDto);
	public void delete(ReplyDTO rDto);
}
