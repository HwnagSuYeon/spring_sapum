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
		sqlSession.update("board.update", bDto);
	}

	@Override
	public void delete(int bno) {
		sqlSession.delete("board.delete", bno);
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
	// replyService의 create메서드로부터 호출, 게시글에 댓글을 달면 board table의 replycnt값을 올려주거나 내려주는 기능
	@Override
	public void updateReplyCnt(HashMap<String, Object> map) {
		sqlSession.update("board.updateReplyCnt", map);
	}

}
