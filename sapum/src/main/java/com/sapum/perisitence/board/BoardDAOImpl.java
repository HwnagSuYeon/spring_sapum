package com.sapum.perisitence.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.board.BoardDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class BoardDAOImpl implements BoardDAO{
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void create(BoardDTO bDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(BoardDTO bDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int bno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public BoardDTO read(int bno) {
		// TODO Auto-generated method stub
		return null;
	}
	// 상세게시글 출력 
	@Override
	public List<BoardDTO> listAll(String sort_option, String search_option, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("sort_option", sort_option);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("board.listAll", map);
	}

	@Override
	public void increaseViewCnt(int bno, HttpSession session) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int countArticle(String search_option, String keyword) {
		// TODO Auto-generated method stub
		return 0;
	}

}
