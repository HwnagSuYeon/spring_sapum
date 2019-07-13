package com.sapum.controller.work;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sapum.domain.work.WorkReplyDTO;
import com.sapum.service.work.WorkReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/workReply/*")
public class WorkReplyController {
	@Inject
	private WorkReplyService service;
	
	// 댓글목록 띄워주는 기능
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String listAll(int wno, Model model) {
		log.info(">>>댓글 리스트 출력");
		
		List<WorkReplyDTO> list = service.list(wno);
		log.info(">>>>>>>>>>>>>>댓글 리스트에서 가져"+list);
		model.addAttribute("cmt_list", list);
		return "work/comment_list";
	}
	
	// 댓글 등록기능
	@ResponseBody
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public void create(WorkReplyDTO rDto) {
		log.info(">>>갤러리 댓글 등록기능>>>>>>>> "+rDto.toString());
		service.create(rDto);
	}
}
