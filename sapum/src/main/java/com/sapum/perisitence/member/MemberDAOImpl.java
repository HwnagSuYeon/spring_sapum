package com.sapum.perisitence.member;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.member.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDAOImpl implements MemberDAO{
	@Inject SqlSession sqlSession;

	@Override
	public int idCheck(String memId) {
		log.info("DAO>>>>"+memId);
		return sqlSession.selectOne("member.idCheck", memId);
	}
	
	@Override
	public int create(MemberDTO mDto) {
		return sqlSession.insert("member.create", mDto);
	}
	// 로그인
	@Override
	public String login(MemberDTO mDto) {
		return sqlSession.selectOne("member.login", mDto);
	}
	// 회원수정을 위한 기존정보 띄우는 역할 
	@Override
	public MemberDTO viewMember(String id) {
		return sqlSession.selectOne("member.viewMember", id);
	}

	@Override
	public void pwUpdate(MemberDTO mDto) {
		// TODO Auto-generated method stub
		
	}
	// 회원수정 
	@Override
	public int memUpdate(MemberDTO mDto) {
		return sqlSession.update("member.update", mDto);
	}
	// 회원삭제 
	@Override
	public int delete(String id) {
		return sqlSession.delete("member.delete", id);
	}
}
