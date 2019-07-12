package com.sapum.service.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.sapum.domain.member.MemberDTO;

public interface MemberService {
	// Ajax로 id중복체크
	public int idCheck(String id);
	
	// 회원가입
	public int create(MemberDTO mDto);
	
	// Ajax:로그인
	public boolean login(MemberDTO mDto, HttpSession session);
	
	// 로그아웃
	public void logout(HttpSession session);
	
	// 회원정보 수정을 위한 1건의 회원정보 검색(기존회원정보 띄워줌)
	public MemberDTO viewMember(HttpSession session);
	
	// 비밀번호 변경: 입력한 비밀번호와 기존비밀번호가 같은지 체크
	public String pwCheck(MemberDTO mDto);
	
	// 비밀번호 변경 수행
	public void pwUpdate(MemberDTO mDto);
	
	// 회원정보 수정 DB반영하는 작업 수행
	public void memUpdate(MemberDTO mDto, HttpSession session);
	
	// 회원정보 삭제
	public void delete(HttpSession session);

	public int followCk(String followingId, HttpSession session);

	public void follow_switch(String followingId, HttpSession session);

	public int follower_count(String followingId);

	public List<String> following_list(HttpSession session);
}
