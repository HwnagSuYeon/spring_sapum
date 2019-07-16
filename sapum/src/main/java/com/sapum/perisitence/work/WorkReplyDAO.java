package com.sapum.perisitence.work;

import java.util.List;

import com.sapum.domain.work.WorkReplyDTO;

public interface WorkReplyDAO {
	public List<WorkReplyDTO> list(int wno);
	public void create(WorkReplyDTO rDto);
	public void delete(int wrno);
}
