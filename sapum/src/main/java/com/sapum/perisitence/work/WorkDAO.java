package com.sapum.perisitence.work;

import java.util.List;

import com.sapum.domain.work.WorkDTO;

public interface WorkDAO {
	public int countArticle(String search_option, String keyword);
	public List<WorkDTO> listAll(String sort_option, String search_option, String keyword, int start, int end);
	public void increaseViewCnt(int wno);
	public WorkDTO read(int wno);
	public void delete(int wno);
	public void create(WorkDTO wDto);
	public void update(WorkDTO wDto);
}
