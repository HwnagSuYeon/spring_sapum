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
	public int idCheck(String id) {
		log.info("service>>>"+id);
		return mDao.idCheck(id);
	}

	@Override
	public int create(MemberDTO mDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean login(MemberDTO mDto, HttpSession session) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void logout(HttpSession session) {
		// TODO Auto-generated method stub
		
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

