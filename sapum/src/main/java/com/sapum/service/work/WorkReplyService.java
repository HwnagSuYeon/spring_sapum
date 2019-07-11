package com.sapum.service.work;

import java.util.List;

import com.sapum.domain.work.WorkReplyDTO;

public interface WorkReplyService {
	public List<WorkReplyDTO> list(int wno);
	public void create(WorkReplyDTO rDto);
	public void delete(int bno);
}
