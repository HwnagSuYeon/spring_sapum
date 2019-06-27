package com.sapum.perisitence.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.board.BoardDTO;
import com.sapum.domain.member.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class BaordDAOImpl implements BoardDAO{
	@Inject
	private SqlSession sqlSession;

	@Override
	public void create(BoardDTO bDto) {
		sqlSession.insert("board.create", bDto);
	}

	@Override
	public void update(BoardDTO bDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int bno) {
		// TODO Auto-generated method stub
		
	}
	// 상세게시글 조회
	@Override
	public BoardDTO read(int bno) {
		return sqlSession.selectOne("board.read", bno);
	}

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
	public void increaseViewCnt(int bno) {
		sqlSession.update("board.increaseViewCnt", bno);
		log.info(">>>>>>>DAO"+bno);
	}

	@Override
	public int countArticle(String search_option, String keyword) {
		Map<String, String> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		
		return sqlSession.selectOne("board.countArticle", map);
	}

	@Override
	public void updateReplyCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
	}

}
