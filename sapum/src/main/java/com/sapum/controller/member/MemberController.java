package com.sapum.controller.member;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	@RequestMapping(value = "idCheck", method = RequestMethod.GET)
	public String idCheck(String memId) {
		log.info(">>>Ajax id check");
		service.idCheck(memId);
		return "member/create";
	}
	
}
