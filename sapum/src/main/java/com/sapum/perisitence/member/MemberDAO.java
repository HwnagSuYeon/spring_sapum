package com.sapum.perisitence.member;

import javax.servlet.http.HttpSession;

import com.sapum.domain.member.MemberDTO;

public interface MemberDAO {
		// Ajax로 id중복체크
		public int idCheck(String id);
		// 회원가입
		public int create(MemberDTO mDto);
		// Ajax:로그인
		public String login(MemberDTO mDto);
		// 회원정보 수정을 위한 1건의 회원정보 검색(기존회원정보 띄워줌)
		public MemberDTO viewMember(String id);
		// 비밀번호 변경 수행
		public void pwUpdate(MemberDTO mDto);
		// 회원정보 수정 DB반영하는 작업 수행
		public int memUpdate(MemberDTO mDto);
		// 회원정보 삭제
		public int delete(String id);

}
