package com.sapum.controller.email;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sapum.domain.email.EmailDTO;
import com.sapum.service.email.EmailService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/email/*")
public class EmailController {
	@Inject
	EmailService eService;
	// 페이지 출력
	@RequestMapping("write")
	public String writer() {
		return "/email/write";
	}
	// 실제로 이메일 보내는애
	@RequestMapping("send")
	public String send(@ModelAttribute EmailDTO eDto, Model model) {
		try {
			log.info(eDto.toString());
			eService.sendMail(eDto);
			model.addAttribute("message", "이메일이 발송되었습니다");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "이메일 발송 실패");
		} 
		return "/email/write";
	}
}
