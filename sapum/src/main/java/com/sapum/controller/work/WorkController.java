package com.sapum.controller.work;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sapum.domain.work.WorkDTO;
import com.sapum.service.work.Pager;
import com.sapum.service.work.WorkService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/work/*")
public class WorkController {
	
	@Inject private WorkService wService;
	
	// 첨부파일 목록을 리턴
	// ArrayList를 json배열로 변환하여 리턴
	@RequestMapping("getAttach/{wno}") // 화면단에서 ajax로 보낸 url이 wno까지 붙어있으므로 mapping을 {who}와 같이 한다. 이렇게하면 wno를 값 자체로 인식한다는 뜻
	@ResponseBody // view가 아닌 데이터 자체를 리턴
	public List<String> getAttach(@PathVariable int wno){
		return wService.getAttach(wno);
	}
	
	// 리스트 페이지 출력
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public ModelAndView list(
			@RequestParam(defaultValue = "new")String sort_option,
			@RequestParam(defaultValue = "all")String search_option,
			@RequestParam(defaultValue = "")String keyword,
			@RequestParam(defaultValue = "1")int curPage) {
		log.info(">>>작품 리스트페이지 출력");
		
		// 게시물 총 개수를 구해 몇개로 나눠 한페이지에띄울지 정함
		int count = wService.countArticle(search_option, keyword);
		
		// 페이지관련 설정
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		// 페이지에 출력할 게시글 목록
		List<WorkDTO> list = wService.listAll(sort_option, search_option, keyword, start, end);
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
		wService.increaseViewCnt(wno, session);
		
		WorkDTO wDto = wService.read(wno);
		model.addAttribute("one", wDto);
		
		return "work/view";
	}
	
	// 작품추가, 수정페이지 출력
	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String create(@RequestParam(defaultValue = "0")int wno, Model model) {
		log.info(">>>작품 게시, 수정페이지 출력>>>>wno"+wno);
		// 화면단에 뿌려줄 빈 DTO를 생성한다.
		WorkDTO wDto = new WorkDTO();
		
		if (wno == 0) {
			// 화면단에서 받아온 wno가 0일경우 -> 빈깡통 들고 작품 등록페이지 출력
			model.addAttribute("wDto", wDto);
		} else {
			// 화면단에서 받아온 wno가 1이 아닐 경우 -> 기존정보 든 DTO들고 작품 수정페이지 출력
			wDto = wService.read(wno);
			model.addAttribute("wDto", wDto);
		}
		return "work/register";
	}
	
	// 작품 추가 실제기능수행
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(WorkDTO wDto) {
		log.info(">>>>작품 추가기능 수행"+wDto.toString());
		wService.create(wDto);
		
		return "redirect:/work/view?wno="+wDto.getWno();
	}
	
	// 작품 삭제기능 수행
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(int wno) {
		log.info(">>>작품 삭제기능 수행"+wno);
		wService.delete(wno);
		return "redirect:/work/list";
	}
	
	// 작품 수정기능 수행
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(WorkDTO wDto) {
		log.info(">>>작품 수정기능 수행");
		wService.update(wDto);
		return "redirect:/work/list";
	}
}

