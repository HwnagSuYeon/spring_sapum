package com.sapum.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class IndexController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@RequestMapping("/") 
	public String index(Model model) {
		logger.info(">>> Index페이지");
		
		return "index";
	}
}
