package com.sapum.controller.board;

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

import com.sapum.domain.board.BoardDTO;
import com.sapum.service.board.BoardService;
import com.sapum.service.board.Pager;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/board/*")
public class BoardController {
	@Inject
	private BoardService service;
	
	// 리스트페이지 출력
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public ModelAndView list(
			@RequestParam(defaultValue = "new")String sort_option,
			@RequestParam(defaultValue = "all")String search_option,
			@RequestParam(defaultValue = "")String keyword,
			@RequestParam(defaultValue = "1")int curPage) {
		log.info(">>>게시글 리스트 페이지 출력 ");
		// 게시물 총 개수를 구해 몇개로 나눠 한 페이지에띄울지 정함
		int count = service.countArticle(search_option, keyword);
		
		// 페이지 관련 설정
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		// 페이지에 출력할 게시글 목록
		List<BoardDTO> list = service.listAll(sort_option, search_option, keyword, start, end);
		log.info(">>>>>>>>>>>>>>>>>>>"+list.toString());
		
		
		// 화면단에 보낼 것을 mav에 담아서 보냄.
		ModelAndView mav = new ModelAndView();
		// 보낼 데이터
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("sort_option", sort_option);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		// mav에 목적지정보, 값을 담음
		mav.setViewName("board/list");
		mav.addObject("map", map);
		
		return mav;
	}
	
	
	// 게시글 1건 조회
	@RequestMapping(value = "view", method = RequestMethod.GET)
	public String view(int bno, Model model, HttpSession session) {
		log.info(">>>게시글 조회페이지 출력"+bno);
		// 비즈니스로직
		// 화면단에서 보내준 bno로DB에가서 그 bno로 조회, 1건만 출력
		// 또한 해당 bno viewcnt +1 처리
		service.increaseViewCnt(bno, session);
		
		BoardDTO bDto = service.read(bno);
		model.addAttribute("view_info", bDto);
		return "board/view";
	}
	
	
	
	// 게시글 등록페이지 출력
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createView() {
		log.info(">>>게시글 등록페이지 출력");
		
		return "board/create";
	}
	
	// 게시글 등록 기능 수행
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(BoardDTO bDto) {
		log.info(">>>게시글 등록페이지 출력");
		// log.info(">>>>>>>>>>게시글 등록페이지에서 값 가져옴"+bDto);
		service.create(bDto);
		log.info(">>>>>>>>>>>>>>"+bDto.getBno());
		
		return "redirect:/board/view?bno="+bDto.getBno();
	}
	
	
	// 게시글 삭제 기능 수행
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(int bno) {
		log.info(">>>게시글 삭제기능 출력"+bno);
		service.delete(bno);
		
		return "redirect:/board/list";
	}
	
	// 게시글 수정페이지 출력
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateView(int bno, Model model) {
		log.info(">>>게시글 수정페이지 출력");
		BoardDTO bDto = service.read(bno);
		model.addAttribute("modi_info", bDto);
		return "board/update";
	}
	
	// 게시글 수정기능 수행
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(BoardDTO bDto) {
		log.info(">>>게시글 수정 기능수행");
		log.info("수정페이지에서 값 가져옴"+bDto);
		service.update(bDto);
		
		return "redirect:/board/list";
	}
	
	// 답글 등록페이지 출력
	@RequestMapping(value = "answer", method = RequestMethod.GET)
	public String answerView(Model model, int bno) {
		log.info(">>>답글등록페이지 출력");
		
		// 답글을 달고자 하는 게시글의 내용을출력
		BoardDTO bDto = service.read(bno);
		bDto.setContent("=======================기존 게시물내용=======================<br><br>"+bDto.getContent()+"<br>==========================================================");
		model.addAttribute("one", bDto);
		
		return "board/answer";
	}
	
	// 답글 등록 실제기능 수행
	@RequestMapping(value = "answer", method = RequestMethod.POST)
	public String answer(BoardDTO bDto, HttpSession session, Model model) {
		log.info(">>>답글등록기능 수행");
		String writer = (String)session.getAttribute("userid");
		bDto.setWriter(writer);
		
		// 기존게시글의 ref, re_step, re_level 가져오기
		BoardDTO one = service.read(bDto.getBno());
		log.info("=======================기존 게시물내용=======================");
		log.info(one.toString());
		log.info("=========================================================");
		bDto.setRef(one.getRef());
		bDto.setRe_step(one.getRe_step());
		bDto.setRe_level(one.getRe_level());
		
		// DB등록
		service.answer(bDto);
		
		return "redirect:/board/list";
	}
	
}
