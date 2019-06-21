package com.sapum.controller.member;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public int idcheck(String id) {
		log.info("화면단 아이디>>"+id);
		log.info(">>>Ajax:id 중복체크");
		int data = service.idCheck(id);
		log.info(data + "");
		return data;
	}
	
}
