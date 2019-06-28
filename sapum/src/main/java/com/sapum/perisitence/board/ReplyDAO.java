package com.sapum.perisitence.board;

import java.util.List;

import com.sapum.domain.board.ReplyDTO;

public interface ReplyDAO {
	public List<ReplyDTO> list(int bno);
	public void create(ReplyDTO rDto);
	public void delete(int rno);
}
