package com.sapum.controller.work;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sapum.service.work.WorkService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/work/*")
public class WorkController {
	@Inject
	private WorkService service;
	
	// 갤러리 리스트페이지 출력
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list() {
		log.info(">>>작품 리스트페이지 출력");
		return "work/list";
	}
	
	// 작품추가페이지 출력
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create() {
		log.info(">>>작품 업로드페이지 출력");
		return "work/create";
	}
}
