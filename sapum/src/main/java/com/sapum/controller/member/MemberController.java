package com.sapum.controller.member;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sapum.perisitence.member.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberController {
	@Inject
	private MemberDAO mDao;
}
