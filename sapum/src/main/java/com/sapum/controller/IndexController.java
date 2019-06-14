package com.sapum.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class IndexController {
	
	@RequestMapping("/") 
	public String index(Model model) {
		log.info(">>> Index페이지");
		
		return "index";
	}
}
