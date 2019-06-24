package com.sapum.service.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.sapum.domain.member.MemberDTO;
import com.sapum.perisitence.member.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	@Inject MemberDAO mDao;
	// 중복아이디체크 
	@Override
	public int idCheck(String memId) {
		log.info("service>>>"+memId);
		return mDao.idCheck(memId);
	}
	// 회원가입 
	@Override
	public int create(MemberDTO mDto) {
		return mDao.create(mDto);
	}
	// 로그인 
	@Override
	public boolean login(MemberDTO mDto, HttpSession session) {
		String name = mDao.login(mDto);
		boolean result = false;
		if (name != null) {
			//로그인 성공한 경우 
			session.removeAttribute("userid");
			session.setAttribute("userid", mDto.getId());
			session.setAttribute("name", name);
			result = true;
			log.info("session>>>"+session.getAttribute("name"));
		}
		return result;
	}
	// 로그아웃 
	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public MemberDTO viewMember(HttpSession session) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String pwCheck(MemberDTO mDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void pwUpdate(MemberDTO mDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void memUpdate(MemberDTO mDto, HttpSession session) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(HttpSession session) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	}

