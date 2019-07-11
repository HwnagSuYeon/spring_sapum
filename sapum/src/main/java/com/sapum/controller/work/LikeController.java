package com.sapum.controller.work;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sapum.service.work.LikeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/like/*")
public class LikeController {
	@Inject
	private LikeService service;
	
	@ResponseBody
	@RequestMapping(value = "check_like", method = RequestMethod.POST)
	public int check_like(int wno, HttpSession session) {
		log.info(">>>좋아요 체크기능");
		int result = service.check_like(wno, session);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "switch_like", method = RequestMethod.POST)
	public void switch_like(int wno, HttpSession session) {
		log.info(">>>좋아요 동작기능>>>>");
		service.switch_like(wno, session);
		
	}
}
