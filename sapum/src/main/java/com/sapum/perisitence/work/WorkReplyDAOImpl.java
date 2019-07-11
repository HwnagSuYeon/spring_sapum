package com.sapum.perisitence.work;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.work.WorkReplyDTO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class WorkReplyDAOImpl implements WorkReplyDAO{
	@Inject
	private SqlSession session;
	
	// 댓글목록 출력
	@Override
	public List<WorkReplyDTO> list(int wno) {
		return session.selectList("workReply.list", wno);
	}
	// 댓글 추가
	@Override
	public void create(WorkReplyDTO rDto) {
		// TODO Auto-generated method stub
		
	}
	// 댓글 삭제
	@Override
	public void delete(int bno) {
		// TODO Auto-generated method stub
		
	}

}
