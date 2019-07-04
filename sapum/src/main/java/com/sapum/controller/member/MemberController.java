package com.sapum.controller.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sapum.domain.member.MemberDTO;
import com.sapum.perisitence.member.MemberDAO;
import com.sapum.service.member.MemberService;

import lombok.val;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberController {
	@Inject
	private MemberService service;
	
	// 회원가입페이지 출력
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createView() {
		log.info(">>>회원가입 페이지 출력 ");
		return "member/create";
	}
	
	// 중복 아이디 체크
	@ResponseBody //ajax를 사용해 데이터가 있는지 없는지 순수 데이터만 띄워줄꺼니까 responseBody를 쓴다.(갈곳을 정해주지 않고 return을 순수데이터로 인식시켜줌)
	@RequestMapping(value = "idCheck", method = RequestMethod.POST)
	public int idcheck(String memId) {
		log.info("화면단 아이디>>"+memId);
		log.info(">>>Ajax:id 중복체크");
		int data = service.idCheck(memId);
		log.info(data + "");
		return data;
	}
	
	// 회원가입기능 수행
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(MemberDTO mDto) {
		log.info(">>>회원가입 기능 수행 ");
		int result = service.create(mDto);
		if(result > 0) {
			log.info("회원 등록성공 ");
		} else {
			log.info("회원 등록실패 ");
		}
		return "redirect:/";
	}
	
	// login
	@ResponseBody
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(MemberDTO mDto, HttpSession session) {
		log.info(">>>ajax login");
		boolean result = service.login(mDto, session);
		String flag = "-1";
		// 로그인 실패시 result값은 false => 이 if문을 타지 않음 
		if (result) { 
			flag = "1";
		}
		// 로그인 성공시 flag = 1반환 
		
		return flag;
	}
	
	// logout
	@ResponseBody
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	public void logout(HttpSession session) {
		log.info(">>>ajax logout");
		service.logout(session);
	}
	
	
	// 마이페이지 띄워주는 기능
	@RequestMapping(value = "mypage", method = RequestMethod.GET)
	public String mypage() {
		return "member/mypage";
	}
	
	// 계정삭제페이지 띄워주는 기능 
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteView() {
		log.info(">>>계정삭제페이지 출력");
		return "member/delete";
	}
	
	// 계정삭제 기능 
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public String delete(HttpSession session) {
		log.info(">>>회원삭제Action");
		service.delete(session);
		return "redirect:/";
	}
	
	// 회원 수정페이지 띄워줌
	@RequestMapping(value = "modify", method = RequestMethod.GET)
	public String modifyView(HttpSession session, Model model) {
		log.info(">>>회원수정페이지 출력");
		MemberDTO mDto = service.viewMember(session);
		model.addAttribute("info", mDto);
		
		return "member/modify";
	}
	
	// 회원수정 실제기능
	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public String modify(MemberDTO mDto, HttpSession session) {
		log.info(">>>회원수정기능 실행");
		service.memUpdate(mDto, session);
		
		return "redirect:/";
	}
	
	// 계정찾기 페이지 띄워주는 기능
	@RequestMapping(value = "find", method = RequestMethod.GET)
	public String findView() {
		log.info(">>>계정찾기페이지 출력");
		
		return "member/findAccount";
	}
	
}
