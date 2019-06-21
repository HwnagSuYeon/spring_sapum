package com.sapum.perisitence.member;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.member.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDAOImpl implements MemberDAO{
	@Inject SqlSession session;

	@Override
	public int idCheck(String id) {
		log.info("DAO>>>>"+id);
		return session.selectOne("member.idCheck", id);
	}

	@Override
	public int create(MemberDTO mDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String login(MemberDTO mDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberDTO viewMember(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void pwUpdate(MemberDTO mDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void memUpdate(MemberDTO mDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(String id) {
		// TODO Auto-generated method stub
		
	}
}
