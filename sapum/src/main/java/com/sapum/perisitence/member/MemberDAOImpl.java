package com.sapum.perisitence.member;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sapum.domain.member.MemberDTO;
import com.sapum.domain.work.WorkDTO;

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

	@Override
	public int followCk(String followingId, String followerId) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("followingId", followingId);
		map.put("followerId", followerId);
		
		return sqlSession.selectOne("member.followCk", map);
	}

	@Override
	public void follow_insert(String followingId, String followerId) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("followingId", followingId);
		map.put("followerId", followerId);
		sqlSession.insert("member.follow_insert", map);
	}

	@Override
	public void follow_delete(String followingId, String followerId) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("followingId", followingId);
		map.put("followerId", followerId);
		sqlSession.delete("member.follow_delete", map);
	}

	@Override
	public int follower_count(String followingId) {
		return sqlSession.selectOne("member.follower_count", followingId);
	}

	@Override
	public List<String> following_list(String followerId) {
		return sqlSession.selectList("member.following_list", followerId);
	}

	@Override
	public int following_coutn(String myId) {
		return sqlSession.selectOne("member.following_count", myId);
	}

	@Override
	public List<WorkDTO> mywork_list(String followingid) {
		return sqlSession.selectList("member.mywork_list", followingid);
	}

}
