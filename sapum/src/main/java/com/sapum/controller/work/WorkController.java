package com.sapum.controller.work;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sapum.domain.work.WorkDTO;
import com.sapum.service.work.Pager;
import com.sapum.service.work.WorkService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/work/*")
public class WorkController {
	@Inject
	private WorkService service;
	
	// 리스트 페이지 출력
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public ModelAndView list(
			@RequestParam(defaultValue = "new")String sort_option,
			@RequestParam(defaultValue = "all")String search_option,
			@RequestParam(defaultValue = "")String keyword,
			@RequestParam(defaultValue = "1")int curPage) {
		log.info(">>>작품 리스트페이지 출력");
		
		// 게시물 총 개수를 구해 몇개로 나눠 한페이지에띄울지 정함
		int count = service.countArticle(search_option, keyword);
		
		// 페이지관련 설정
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		// 페이지에 출력할 게시글 목록
		List<WorkDTO> list = service.listAll(sort_option, search_option, keyword, start, end);
		// 화면단에 보낼것을 mav에 담아 보냄
		ModelAndView mav = new ModelAndView();
		// 보낼 데이터
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("sort_option", sort_option);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		// mav에 목적지정보, 데이터 담음
		mav.setViewName("work/list");
		mav.addObject("map", map);
		
		return mav;
	}
	
	// 작품 1건 조회
	@RequestMapping(value = "view", method = RequestMethod.GET)
	public String view(int wno, Model model, HttpSession session) {
		log.info(">>>작품 상세조회페이지 출력"+wno);
		service.increaseViewCnt(wno, session);
		
		WorkDTO wDto = service.read(wno);
		model.addAttribute("one", wDto);
		
		return "work/view";
	}
	
	
	// 작품추가페이지 출력
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create() {
		log.info(">>>작품 업로드페이지 출력");
		return "work/create";
	}
}
