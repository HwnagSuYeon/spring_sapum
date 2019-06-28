package com.sapum.controller.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sapum.domain.board.ReplyDTO;
import com.sapum.service.board.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/reply/*")
public class ReplyController {
	@Inject
	private ReplyService service;
	
	
	// boardview에서 ajax로 호출하기때문에 response body를 쓰지 않음
	// 댓글목록을 띄워주는 역
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String listAll(int bno, Model model) {
		log.info(">>>>>>>>게시글에서 bno받아옴"+bno);
		log.info(">>> 댓글리스트 출력");
		
		List<ReplyDTO> list = service.list(bno);
		model.addAttribute("cmt_list", list);
		return "board/comment_list";
	}
	
	// 댓글 등록
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public void create(ReplyDTO rDto) {
		log.info(">>>ajax: 댓글등록"+rDto);
		
	}
}
