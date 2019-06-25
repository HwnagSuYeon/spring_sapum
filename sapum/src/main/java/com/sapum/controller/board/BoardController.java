package com.sapum.controller.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sapum.domain.board.BoardDTO;
import com.sapum.service.board.BoardService;
import com.sapum.service.board.Pager;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("board/*")
@Controller
public class BoardController {
	@Inject
	private BoardService service;
	
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public ModelAndView list(
			@RequestParam(defaultValue = "new")String sort_option,
			@RequestParam(defaultValue = "all")String search_option,
			@RequestParam(defaultValue = "")String keyword,
			@RequestParam(defaultValue = "1")int curPage) {
		log.info(">>>게시글 목록 출력");
		
		// 레코드 갯수(게시물 총개수를 구해 몇개로 나눠서 한 페이지에 띄울지 정함
		int count = service.countArticle(search_option, keyword);
		
		// 페이지 관련 설정
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		// 페이지에 출력할 게시글 목록 출력
		List<BoardDTO> list = service.listAll(sort_option, search_option, keyword, start, end);
		
		// 화면단에 보낼 것을 mav에 담아 보냄.
		ModelAndView mav = new ModelAndView();
		
		// 보낼데이터
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("sort_option", sort_option);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		mav.setViewName("board/list");
		mav.addObject("map", map);
		
		return mav;
	}
}
