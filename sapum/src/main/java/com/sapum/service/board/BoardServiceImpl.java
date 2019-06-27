package com.sapum.service.board;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import com.sapum.domain.board.BoardDTO;
import com.sapum.perisitence.board.BoardDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardServiceImpl implements BoardService{
	@Inject
	private BoardDAO bDao;

	@Override
	public void create(BoardDTO bDto) {
		bDao.create(bDto);
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
		return bDao.read(bno);
	}
	// 게시글 목록(페이지 나누기, 검색기능 포함)
	@Override
	public List<BoardDTO> listAll(String sort_option, String search_option, String keyword, int start, int end) {
		return bDao.listAll(sort_option, search_option, keyword, start, end);
	}
	// 조회수 증가처리
	@Override
	public void increaseViewCnt(int bno, HttpSession session) {
		// 조회수를 증가처리하기위한 변수선언
		long update_time = 0;
		//session.getAttribute("update_time_"+bno) -> session에서 게시글을 눌렀을 때 이름을 달리주기 위해 이렇게 씀
		// 예를들어 1번 게시물 선택시 update_time_1 이런식으로 session에서 값을 받아옴
		// session.getAttribute("update_time_"+bno) != null => 게시글이 본적 있음 
		if (session.getAttribute("update_time_"+bno) != null ) {
			// 최근에 조회수를 올린 시간
			update_time = (long)session.getAttribute("update_time_"+bno);
			// 게시글을 본 경우 그 게시글 본 시간을 session에서 가져와 update_time에 담음
		}
		// 현재시간을 long타입으로 반환하는 메서드를 current_time에 담음
		long current_time = System.currentTimeMillis();
		
		// 24시간 경과후 조회수 증가 처리
		// 24*60*60*1000 -> 밀리초로 24시간 계산
		// current_time - update_time -> 현재시간 - 과거에 게시글을 조회한 시간
		// 현재시간 - 과거게시글조회시간이 24시간보다 크면 조회수를 1증가시키고, 게시글을 새로 조회한 시간을 session에 저장
		if (current_time - update_time > 24*60*60*1000) {
			// 실제 조회수 증가 처리되는 부분
			bDao.increaseViewCnt(bno);
			// 조회수 올린 시간 저장
			session.setAttribute("update_time_"+bno, current_time);
		}
	}
	// 게시글 검색결과 몇건이 떴는지 알려주는 기능
	@Override
	public int countArticle(String search_option, String keyword) {
		return bDao.countArticle(search_option, keyword);
	}

}
