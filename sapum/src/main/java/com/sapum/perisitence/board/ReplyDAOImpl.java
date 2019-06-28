package com.sapum.perisitence.board;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.board.ReplyDTO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class ReplyDAOImpl implements ReplyDAO{
	@Inject
	private SqlSession session;

	@Override
	public List<ReplyDTO> list(int bno) {
		return session.selectList("reply.list", bno);
	}

	@Override
	public void create(ReplyDTO rDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int rno) {
		// TODO Auto-generated method stub
		
	}

}
