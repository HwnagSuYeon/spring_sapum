package com.sapum.perisitence.board;

import java.util.HashMap;
import java.util.List;

import com.sapum.domain.board.BoardDTO;
import com.sapum.domain.member.MemberDTO;

public interface BoardDAO {
	//게시글 등록
	public void create(BoardDTO bDto);
	//게시글 수정
	public void update(BoardDTO bDto);
	//게시글 삭제
	public void delete(int bno);
	//상세게시글
	public BoardDTO read(int bno);
	//게시글목록(페이지 나누기, 검색기능 포함)
	public List<BoardDTO> listAll(String sort_option, String search_option, String keyword, int start, int end);
	//조회수 증가처리
	public void increaseViewCnt(int bno);
	//레코드 갯수 계산("ㅇㅇ"으로 검색결과 총"ㅇ"건이 검색되었습니다)
	public int countArticle(String search_option, String keyword);
	// 해당게시글 replycnt를 +1OR -1해주는 작업
	public void updateReplyCnt(HashMap<String, Object> map);
}
