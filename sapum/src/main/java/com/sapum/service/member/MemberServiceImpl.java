package com.sapum.service.member;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.sapum.domain.member.MemberDTO;
import com.sapum.domain.work.WorkDTO;
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
	// 회원정보 수정시 기존 회원정보 보여주는 역할 
	@Override
	public MemberDTO viewMember(HttpSession session) {
		String id = (String)session.getAttribute("userid");
		MemberDTO mDto = mDao.viewMember(id);
		return mDto;
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
	// 회원수정기능 
	@Override
	public void memUpdate(MemberDTO mDto, HttpSession session) {
		int result =  mDao.memUpdate(mDto);
		if(result > 0) {
			session.removeAttribute("name");
			session.setAttribute("name", mDto.getName());
		}
	}
	// 회원삭제 
	@Override
	public void delete(HttpSession session) {
		String id = (String)session.getAttribute("userid");
		log.info(id);
		int result = mDao.delete(id);
		// 삭제 성공시 세션값의 초기화
		if(result > 0) {
			session.invalidate();
			log.info("계정삭제 성공");
		}
	}
	@Override
	public int followCk(String followingId, HttpSession session) {
		String userid;
		if((userid = (String)session.getAttribute("userid"))!= null) {
			return mDao.followCk(followingId, userid);
		}else {
			return 0;
		}
	}
	
	@Override
	public void follow_switch(String followingId, HttpSession session) {
		String followerId = (String) session.getAttribute("userid");
		if( mDao.followCk(followingId, followerId) == 0) {
			// if문 안의 조건문 -> 팔로우 버튼을 누른 기록이 없을때 = insert문
			mDao.follow_insert(followingId, followerId);
		} else {
			mDao.follow_delete(followingId, followerId);
		}
	}
	
	
	@Override
	public int follower_count(String followingId) {
		return mDao.follower_count(followingId);
	}
	
	
	@Override
	public List<String> following_list(HttpSession session) {
		String followerId = (String) session.getAttribute("userid");
		return mDao.following_list(followerId);
	}
	
	// 마이페이지 불러올 시 유저 정보 아래 팔로잉/팔로워 수, 내가 등록한 작품을 띄워주기 위함
	@Override
	public HashMap<String, Object> mypage_list(HttpSession session) {
		String followingid = (String) session.getAttribute("userid");
		// 나를 따르는 애의 수를 집계
		int follower_count = mDao.follower_count(followingid);
		// 내가 따르는 애의 수를 집계
		int following_count = mDao.following_coutn(followingid);
		
		// 내가 올린 작품의 리스트를 띄워줌
		List<HashMap<String, Object>> list = mDao.mywork_list(followingid);
		log.info(list.toString());
		HashMap<String, Object> map = new HashMap<>();
		map.put("follower_count", follower_count);
		map.put("following_count", following_count);
		map.put("list", list);
		return map;
	}
	
	
	
}

