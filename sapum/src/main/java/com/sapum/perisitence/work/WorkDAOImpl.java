package com.sapum.perisitence.work;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.work.WorkDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class WorkDAOImpl implements WorkDAO{
	@Inject
	private SqlSession session;

	@Override
	public int countArticle(String search_option, String keyword) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		return session.selectOne("work.countArticle", map);
	}

	@Override
	public List<WorkDTO> listAll(String sort_option, String search_option, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sort_option", sort_option);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		
		return session.selectList("work.listAll", map);
	}

	@Override
	public void increaseViewCnt(int wno) {
		session.update("work.increaseViewCnt", wno);
		log.info(">>>>>DAO"+wno);
	}

	@Override
	public WorkDTO read(int wno) {
		return session.selectOne("work.read", wno);
	}
	
	

}
