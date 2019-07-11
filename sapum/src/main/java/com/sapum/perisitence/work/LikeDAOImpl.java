package com.sapum.perisitence.work;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class LikeDAOImpl implements LikeDAO{
	@Inject SqlSession session;

	@Override
	public int check_like(int wno, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("wno", wno);
		map.put("id", id);
		
		return session.selectOne("like.check_like", map);
	}

	@Override
	public void insertLike(int wno, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("wno", wno);
		map.put("id", id);
		session.insert("like.insertLike", map);
	}

	@Override
	public void deleteLike(int wno, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("wno", wno);
		map.put("id", id);
		session.insert("like.deleteLike", map);
	}

}
